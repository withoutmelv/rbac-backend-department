import { Context, Next } from 'koa';
import { R } from '../../../utils/common-response';
import roleKnowledgeService from '../services/role-knowledge.service';

class RoleKnowledgeController {
  async create(ctx: Context, next: Next): Promise<void> {
    const data = ctx.request.body;
    const res = await roleKnowledgeService.save(data as any);
    ctx.body = R.ok(res);
    await next();
  }

  async update(ctx: Context, next: Next): Promise<void> {
    const data = ctx.request.body as any;
    await roleKnowledgeService.update(data.roleId, data.knowledgeIds);
    ctx.body = R.ok();
    await next();
  }

  async removeByRoleId(ctx: Context, next: Next): Promise<void> {
    const { roleId } = ctx.params;
    await roleKnowledgeService.removeByRoleId(roleId);
    ctx.body = R.ok();
    await next();
  }

  async findByRoleId(ctx: Context, next: Next): Promise<void> {
    const { roleId } = ctx.params;
    const res = await roleKnowledgeService.findByRoleId(roleId);
    ctx.body = R.ok(res);
    await next();
  }

  async findByKnowledgeId(ctx: Context, next: Next): Promise<void> {
    const { knowledgeId } = ctx.params;
    const res = await roleKnowledgeService.findByKnowledgeId(knowledgeId);
    ctx.body = R.ok(res);
    await next();
  }
}

export default new RoleKnowledgeController();