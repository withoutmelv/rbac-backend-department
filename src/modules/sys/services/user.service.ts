import { In, Repository } from "typeorm";
import { User } from "../entities/user";
import { AppDataSource } from "../../../utils/data-source";
import { getLoginUser, getLoginUserId } from "../../../middlewares/auth-middleware";
import { UserPageParam, UserParam } from "../params/user.param";
import { UserRole } from "../entities/user-role";
import { plainToClass } from "class-transformer";
import { generateId } from "../../../utils/snowflake-id-generator";
import { checkUnique, generateRandomString, hasLogicDeleteColumn, md5Password } from "../../../utils/tool";
import { AdminTypeEnum } from "../enums/admin-type.enum";
import { getConfig } from "../../../config";

class UserService{
    userRepository: Repository<User>;
    userRoleRepository: Repository<UserRole>;
    constructor() {
        this.userRepository = AppDataSource.manager.getRepository(User)
        this.userRoleRepository = AppDataSource.manager.getRepository(UserRole)
    }
    async createBaseUser(param: UserParam, isThrowExp: boolean):Promise<User | undefined>{
        if(isThrowExp){
            await checkUnique(this.userRepository, 'userName', param.userName, undefined, '用户名已存在');
            // await checkUnique(this.userRepository, 'mobilePhone', param.mobilePhone, undefined, '手机号已存在');
        } else {
            try{
                await checkUnique(this.userRepository, 'userName', param.userName, undefined, '用户名已存在');
                // await checkUnique(this.userRepository, 'mobilePhone', param.mobilePhone, undefined, '手机号已存在');
            } catch(e) {
                return Promise.resolve(undefined)
            }
        }
        if(param.adminType === undefined){
            param.adminType = AdminTypeEnum.COMMON_ADMIN.getCode()
        }
            
        // 自动映射到 User 实体
        const entity = plainToClass(User, param, {
            excludeExtraneousValues: true, // 排除多余的属性,
        });
        entity.id = generateId()
        const salt = generateRandomString(8)
        entity.salt = salt
        if(!param.password){
            param.password = getConfig().DEFAULT_PASSWORD
        }
        entity.password = md5Password(param.password as string, salt)
        // 设置密码和salt
        const now = new Date();
        const userId = getLoginUserId();
        if (param.guestId) {
            entity.guestId = param.guestId;
        }
        entity.createTime = now;
        entity.createUser = userId;
        entity.updateTime = now;
        entity.updateUser = userId;
        await this.userRepository.save(entity);
        return Promise.resolve(entity)
    }
    async save(param: UserParam): Promise<void> {
        // 默认普通管理员
        param.adminType = AdminTypeEnum.COMMON_ADMIN.getCode()
        await this.createBaseUser(param, true)
    }
    async remove(ids: Array<string>): Promise<void> {
        // if(hasLogicDeleteColumn(this.userRepository)){
        //     await this.userRepository.update({ id: In(ids) }, { isDeleted: 1 });
        // } else {
            await this.userRepository.remove(await this.userRepository.findBy({ id: In(ids) }));
            await this.userRoleRepository.delete({ userId: In(ids) });
        // }
    }
    async update(param: UserParam): Promise<void> {
        // 自动映射到 User 实体
        const entity = plainToClass(User, param, {
            excludeExtraneousValues: true, // 排除多余的属性,
        });
        entity.password = undefined;
        entity.salt = undefined;
        entity.adminType = undefined;
        const now = new Date();
        const userId = getLoginUserId();
        entity.updateTime = now;
        entity.updateUser = userId;
        await this.userRepository.update({ id: entity.id }, entity);
    }
    async info(){
        const userInfo = getLoginUser();
        console.log(userInfo);
        const userDetail = await this.userRepository.findOneBy({ id: userInfo.id });
        console.log(userDetail);
        return {...userInfo, deptId: userDetail?.deptId, email: userDetail?.email}
    }
    permCode(){
        return getLoginUser().perms || []
    }
    // 分页查询方法
    async page(param: UserPageParam): Promise<{ rows: User[], recordCount: number, totalPage: number }> {
        const { deptId, isAdmin } = param as any;
        if (!isAdmin && deptId) {
            (param as any).deptId = deptId
        }else if (!isAdmin && !deptId) {
            (param as any).deptId = '-'
        }else if (isAdmin){
            delete (param as any).deptId;
        }
        delete (param as any).isAdmin;
        const data = await param.findWithQuery(this.userRepository, async (user: User) => {
            // 追加角色ID
            user.roleIds = (await this.userRoleRepository.findBy({ userId: user.id }))
              .map(userRole => userRole.roleId)
              .join(',');
          },(qb: any)=>{
            // 仅查询普通管理员
            qb.andWhere(`entity.adminType = :adminType`,{adminType: AdminTypeEnum.COMMON_ADMIN.getCode()})
            return qb
          });
        return data;
    }
    // 详情
    async detail(id: string): Promise<User | null> {
        return await this.userRepository.findOneBy({ id });
    }
    // 锁定用户
    async locked(ids: Array<string>): Promise<void> {
        await this.userRepository.update({ id: In(ids) }, { isLocked: 1 });
    }
    // 取消锁定用户
    async unLocked(ids: Array<string>): Promise<void> {
        await this.userRepository.update({ id: In(ids) }, { isLocked: 0 });
    }
    // 重置密码
    async resetPassword(ids: Array<string>): Promise<void> {
        const salt = generateRandomString(8)
        const defaultPassword = getConfig().DEFAULT_PASSWORD;
        await this.userRepository.update({ id: In(ids) }, { password: md5Password(defaultPassword, salt) });
    }
    // 授权角色
    async grantRole(userId: string, roleIdList: Array<string>): Promise<void> {
        await this.userRoleRepository.delete({ userId });
        const userRoleList: UserRole[] = [];
        roleIdList.forEach(roleId => {
            const userRole = new UserRole();
            userRole.id = generateId();
            userRole.userId = userId;
            userRole.roleId = roleId;
            userRoleList.push(userRole);
        });
        await this.userRoleRepository.save(userRoleList);
    }

    async findUserByRoleIds(roleIds: Array<string>): Promise<User[]> {
        return await this.userRepository.createQueryBuilder('user')
            .innerJoin(UserRole, 'userRole', 'user.id = userRole.userId')
            .where('userRole.roleId IN (:...roleIds)', { roleIds })
            .getMany();
    }

    async updatePwd(oldPassword: string, newPassword: string): Promise<void> {
        // 获取当前登录用户
        const userId = getLoginUserId();
        const user = await this.userRepository.findOneBy({ id: userId });
        if (!user) {
            throw new Error('用户不存在');
        }

        // 验证旧密码
        const oldPasswordHash = md5Password(oldPassword, user.salt || '');
        if (oldPasswordHash !== user.password) {
            throw new Error('旧密码不正确');
        }

        // 设置新密码和salt
        const salt = generateRandomString(8);
        const newPasswordHash = md5Password(newPassword, salt);

        // 更新用户信息
        user.password = newPasswordHash;
        user.salt = salt;
        user.updateTime = new Date();
        user.updateUser = userId;

        await this.userRepository.save(user);
    }

    async updateInfo(param: UserParam): Promise<void> {
        // 自动映射到 User 实体
        const entity = plainToClass(User, param, {
            excludeExtraneousValues: true, // 排除多余的属性,
        });
        entity.password = undefined;
        entity.salt = undefined;
        entity.adminType = undefined;
        const now = new Date();
        const userId = getLoginUserId();
        entity.updateTime = now;
        entity.updateUser = userId;
        await this.userRepository.update({ id: userId }, entity);
    }

}
export default new UserService();