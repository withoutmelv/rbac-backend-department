import { In, Repository } from "typeorm";
import { AppDataSource } from "../../../utils/data-source";
import { Role } from "../entities/role";
import { UserRole } from "../entities/user-role";
import { RoleKnowledge } from "../entities/role-knowledge";
import { RoleMenu } from "../entities/role-menu";
import { RolePageParam, RoleParam } from "../params/role.param";
import { plainToClass } from "class-transformer";
import { generateId } from "../../../utils/snowflake-id-generator";
import { getLoginUserId } from "../../../middlewares/auth-middleware";
import { hasLogicDeleteColumn } from "../../../utils/tool";

class RoleService{
    roleRepository: Repository<Role>;
    userRoleRepository: Repository<UserRole>;
    roleKnowledgeRepository: Repository<RoleKnowledge>;
    roleMenuRepository: Repository<RoleMenu>;
    constructor() {
        this.roleRepository = AppDataSource.manager.getRepository(Role)
        this.userRoleRepository = AppDataSource.manager.getRepository(UserRole)
        this.roleKnowledgeRepository = AppDataSource.manager.getRepository(RoleKnowledge) // 新增代码，添加角色知识的存储库
        this.roleMenuRepository = AppDataSource.manager.getRepository(RoleMenu) // 新增代码，添加角色菜单的存储库
    }
    async save(param: RoleParam): Promise<void> {
        // 自动映射到 Role 实体
        const entity = plainToClass(Role, param, {
            excludeExtraneousValues: true, // 排除多余的属性,
        });
        entity.id = generateId()
        entity.appCode = 'platform'
        const now = new Date();
        const userId = getLoginUserId();
        entity.deptId = entity.deptId || '-';
        entity.createTime = now;
        entity.createUser = userId;
        entity.updateTime = now;
        entity.updateUser = userId;
        await this.roleRepository.save(entity);
    }
    async remove(ids: Array<string>): Promise<void> {
        // if(hasLogicDeleteColumn(this.roleRepository)){
        //   await this.roleRepository.update({ id: In(ids) }, { isDeleted: 1 });
        // } else {
          await this.roleRepository.remove(await this.roleRepository.findBy({ id: In(ids) }));
          await this.userRoleRepository.delete({ roleId: In(ids) });
          await this.roleKnowledgeRepository.delete({ roleId: In(ids) }); // 新增代码，删除角色知识
          await this.roleMenuRepository.delete({ roleId: In(ids) }); // 新增代码，删除角色菜单
          // }
    }
    async update(param: RoleParam): Promise<void> {
      // 自动映射到 Role 实体
      const entity = plainToClass(Role, param, {
          excludeExtraneousValues: true, // 排除多余的属性,
      });
      const now = new Date();
      const userId = getLoginUserId();
      entity.deptId = entity.deptId || '-';
      entity.updateTime = now;
      entity.updateUser = userId;
      await this.roleRepository.update({ id: entity.id }, entity);
  }
    // 分页查询方法
    async page(param: RolePageParam): Promise<{ rows: Role[], recordCount: number, totalPage: number }> {
        const { deptId, isAdmin } = param as any;
        if (!isAdmin && deptId) {
            (param as any).deptId = deptId
        }else if (!isAdmin && !deptId) {
            (param as any).deptId = '-'
        }else if (isAdmin){
            delete (param as any).deptId;
        }
        delete (param as any).isAdmin;
        return param.findWithQuery(this.roleRepository);
    }
    // 详情
    async detail(id: string): Promise<Role | null> {
        const data = await this.roleRepository.findOneBy({ id });
        return data;
    }
}
export default  new RoleService();