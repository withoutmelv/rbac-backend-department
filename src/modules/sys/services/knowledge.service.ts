import { Repository, In } from 'typeorm';
import { AppDataSource } from '../../../utils/data-source';
import { Knowledge } from '../entities/knowledge';
import { RoleKnowledge } from '../entities/role-knowledge';
import { plainToClass } from "class-transformer";
import { generateId } from "../../../utils/snowflake-id-generator";
import { KnowledgePageParam } from '../params/knowledge.param';

interface PageQuery {
  current?: number;
  size?: number;
  [key: string]: any;
}

interface PageResult<T> {
  rows: T[];
  totalPage: number;
  recordCount: number;
}

class KnowledgeService {
  private repository: Repository<Knowledge>;
  private roleKnowledgeRepository: Repository<RoleKnowledge>;

  constructor() {
    this.repository = AppDataSource.manager.getRepository(Knowledge);
    this.roleKnowledgeRepository = AppDataSource.manager.getRepository(RoleKnowledge);
  }

  async save(data: Partial<Knowledge>): Promise<Knowledge> {
    const entity = plainToClass(Knowledge, data, {
      excludeExtraneousValues: true, // 排除多余的属性,
    });
    entity.id = generateId()
    entity.createTime = new Date()
    entity.updateTime = new Date()
    return this.repository.save(entity);
  }

  async update(data: Partial<Knowledge>): Promise<Knowledge> {
    const entity = plainToClass(Knowledge, data, {
      excludeExtraneousValues: true, // 排除多余的属性,
    });
    entity.updateTime = new Date()
    return this.repository.save(data);
  }

  async remove(ids: string[]): Promise<void> {
    await this.repository.delete({id: In(ids)});
  }

  async delete(ids: string[]): Promise<void> {
    await this.repository.delete({id: In(ids)});
    await this.roleKnowledgeRepository.delete({knowledgeId: In(ids)}); // 删除角色知识关联
  }

  async detail(id: string): Promise<Knowledge | null> {
    return this.repository.findOneBy({ id });
  }

  async page(param: KnowledgePageParam): Promise<{ rows: Knowledge[], recordCount: number, totalPage: number }> {
    const { deptId, isAdmin } = param as any;
    if (!isAdmin && deptId) {
      (param as any).deptId = deptId
    }else if (!isAdmin && !deptId) {
      (param as any).deptId = '-'
    }else if (isAdmin){
      delete (param as any).deptId;
    }
    delete (param as any).isAdmin;
    return param.findWithQuery(this.repository);
  }

  async list(param: KnowledgePageParam): Promise<{ rows: Knowledge[], recordCount: number, totalPage: number }> {
    const { deptId, isAdmin } = param as any;
    if (!isAdmin && deptId) {
      (param as any).deptId = deptId
    }else if (!isAdmin && !deptId) {
      (param as any).deptId = '-'
    }else if (isAdmin && deptId){
      (param as any).deptId = [deptId, '-']
    }else if (isAdmin && !deptId){
      (param as any).deptId = '-'
    }
    delete (param as any).isAdmin;
    return param.findWithQuery(this.repository);
  }
}

export default new KnowledgeService();