import { Repository } from "typeorm";
import { User } from "../entities/user";
import { Role } from "../entities/role";
import { UserRole } from "../entities/user-role";
import { Dept } from "../entities/dept";
import { AppDataSource } from "../../../utils/data-source";
import { LoginParam } from "../params/login.param";
import { LoginTokenVO } from "../vos/login-token.vo";
import { ServiceException } from "../../../utils/service-exception";
import { md5Password } from "../../../utils/tool";
import { TokenManager } from "../../../token/token-manager";
import { LoginUserVO } from "../vos/login-user.vo";
import { getLoginUser, getLoginUserId, getLoginUserName, getToken, isSuperAdmin } from "../../../middlewares/auth-middleware";
import { AdminTypeEnum } from "../enums/admin-type.enum";
import rbacService from "./rbac.service";
import UserService from "./user.service";
import { TreeTool } from "../../../utils/tree-tool";

class AuthService {
  userRepository: Repository<User>;
  userRoleRepository: Repository<any>;
  roleRepository: Repository<Role>;
  deptRepository: Repository<Dept>;
  constructor() {
    this.userRepository = AppDataSource.manager.getRepository(User);
    this.userRoleRepository = AppDataSource.manager.getRepository(UserRole);
    this.roleRepository = AppDataSource.manager.getRepository(Role);
    this.deptRepository = AppDataSource.manager.getRepository(Dept);
  }

  async login(param: LoginParam): Promise<LoginTokenVO> {
    const user = await this.userRepository.findOne({
      where: {
        userName: param.userName,
      }
    })
    if(!user){
        ServiceException.throwBiz(10000001, '用户名或密码错误');
    }
    // 判断是否锁定
    if(user.isLocked === 1){
        ServiceException.throwBiz(10041003, '您的账号已被锁定，请联系管理员！');
    }
    if(user.password !== md5Password(param.password as string,user.salt as string)){
        ServiceException.throwBiz(10000001, '用户名或密码错误');
    }
    const vo: LoginTokenVO = new LoginTokenVO();

    vo.token = TokenManager.getInstance().createToken(JSON.parse(JSON.stringify(await this.toLoginUser(user))));
    vo.userId = user.id;
    return Promise.resolve(vo);
  }

  async guestLogin(param: any): Promise<any> {
    const {guestId} = param;
    let user = await this.userRepository.findOne({
      where: {
        guestId: guestId,
      }
    })
    if(!user){
      const randomId = guestId.split("_")[1];
      const userInfo = await UserService.createBaseUser({
        sex: 3,
        password: randomId,
        isLocked: 0, // 不锁定
        userName: "youke" + randomId,
        realName: "游客" + randomId,
        mobilePhone: "11111111111",
        deptId: "-",
        guestId: guestId,
        adminType: AdminTypeEnum.COMMON_ADMIN.getCode()
      }, false);
      const roleInfo = await this.roleRepository.findOne({
        where: { code: "guest" }
      });
      if (userInfo && roleInfo) {
        await UserService.grantRole(userInfo.id, [roleInfo.id + '']);
      }
    }
    return true;
  }

  async register(param: any): Promise<any> {
      const {username, password, email} = param;
      // 检查用户名是否已存在
      const existUser = await this.userRepository.findOne({
          where: { userName: username }
      });
      if(existUser) {
        ServiceException.throwBiz(10000002, '用户名已存在');
      }
  
      // 检查邮箱是否已存在
      if(email) {
        const existEmail = await this.userRepository.findOne({
          where: { email }
        });
        if(existEmail) {
          ServiceException.throwBiz(10000003, '邮箱已被注册');
        }
      }

      await UserService.createBaseUser({
        sex: 3,
        password,
        isLocked: 0, // 不锁定
        userName: username,
        realName: username,
        mobilePhone: "",
        email,
        deptId: "-",
        adminType: AdminTypeEnum.COMMON_ADMIN.getCode()
      }, false);
      return true;
  }

  async toLoginUser(user: User): Promise<LoginUserVO> {
    const vo: LoginUserVO = new LoginUserVO();
    vo.id = user.id;
    vo.userName = user.userName;
    vo.adminType = user.adminType;
    vo.realName = user.realName;
    vo.nickName = user.nickName;
    // 查询角色ID
    vo.roleIds = (await this.userRoleRepository.findBy({ userId: user.id }))
      .map(userRole => userRole.roleId)
    vo.superAdmin = user.adminType === AdminTypeEnum.SUPER_ADMIN.getCode()
    if(vo.superAdmin){
      vo.perms = ['admin']
    } else {
      vo.perms = await rbacService.getPermInCache(vo.roleIds, 'platform')
    }
    return Promise.resolve(vo);
  }
  async logout() {
    return Promise.resolve();
  }
  // 扮演用户
  async playUser(userId: string):Promise<LoginTokenVO> {
    const user: User | null = await this.userRepository.findOne({
        where: {
            id: userId
        }
    })
    if(!user){
        ServiceException.throwBiz(10000001, '用户不存在');
    }
    const loginUser: LoginUserVO = await this.toLoginUser(user);
    if(loginUser.superAdmin){
        if(!isSuperAdmin()){
          ServiceException.throwBiz(99999999, '非超级管理员不能扮演超级管理员');
        }
    }
    loginUser.ext['playerToken'] = getToken();
    loginUser.ext['playerUserId'] = getLoginUserId();
    loginUser.ext['playUserAccount'] = getLoginUserName();
    loginUser.ext['isPlayer'] = true;
    const vo: LoginTokenVO = new LoginTokenVO();
    vo.token = TokenManager.getInstance().createToken(JSON.parse(JSON.stringify(loginUser)));
    vo.userId = user.id;
    return Promise.resolve(vo);
  }
  // 取消扮演
  async unPlayUser(){
    const user: any = getLoginUser()
    return Promise.resolve({
      userId: user.id,
      token: user.ext.playerToken
    });
  }

}
export default  new AuthService();