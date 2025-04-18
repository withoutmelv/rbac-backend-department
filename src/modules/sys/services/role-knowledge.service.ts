import { Repository, In } from 'typeorm';
import { AppDataSource } from '../../../utils/data-source';
import { RoleKnowledge } from '../entities/role-knowledge';
import { Knowledge } from '../entities/knowledge';
import { generateId } from "../../../utils/snowflake-id-generator";

class RoleKnowledgeService {
  private repository: Repository<RoleKnowledge>;
  private knowledgeRepository: Repository<Knowledge>;
  constructor() {
    this.repository = AppDataSource.manager.getRepository(RoleKnowledge);
    this.knowledgeRepository = AppDataSource.manager.getRepository(Knowledge);
  }

  async save(data: Partial<RoleKnowledge>): Promise<RoleKnowledge> {
    return this.repository.save(data);
  }

  async update(id: string, knowledgeIds: any): Promise<any> {
    await this.removeByRoleId(id);
    if (!knowledgeIds || knowledgeIds.length === 0) {
      return;
    }
    await this.save(knowledgeIds.map((knowledgeId: string) => ({ id: generateId(), roleId: id, knowledgeId, createTime: new Date(), updateTime: new Date() })));
  }

  async removeByRoleId(roleId: string): Promise<void> {
    await this.repository.delete({ roleId });
  }

  async findByRoleId(roleId: string): Promise<Knowledge[]> {
    const roleKnowledgeList = await this.repository.find({ where: { roleId } });
    return this.knowledgeRepository.find({ where: { id: In(roleKnowledgeList.map(item => item.knowledgeId)) } });
  }

  async findByKnowledgeId(knowledgeId: string): Promise<RoleKnowledge[]> {
    return this.repository.find({ where: { knowledgeId } });
  }
}

export default new RoleKnowledgeService();