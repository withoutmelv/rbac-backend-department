import { Context, Next } from 'koa';
import { R } from '../../../utils/common-response';
import knowledgeService from '../services/knowledge.service';
import { KnowledgePageParam } from '../params/knowledge.param';
import { plainToClass } from "class-transformer";

class KnowledgeController {
  async save(ctx: Context, next: Next): Promise<void> {
    const data = ctx.request.body;
    const res = await knowledgeService.save(data as any);
    ctx.body = R.ok(res);
    await next();
  }

  async delete(ctx: Context, next: Next): Promise<void> {
    const { ids } = ctx.request.body as any;
    await knowledgeService.delete(ids);
    ctx.body = R.ok();
    await next();
  }

  async update(ctx: Context, next: Next): Promise<void> {
    const data = ctx.request.body;
    const res = await knowledgeService.update(data as any);
    ctx.body = R.ok(res);
    await next();
  }

  async remove(ctx: Context, next: Next): Promise<void> {
    const { ids } = ctx.request.body as any;
    await knowledgeService.remove(ids);
    ctx.body = R.ok();
    await next();
  }

  async detail(ctx: Context, next: Next): Promise<void> {
    const { id } = ctx.params;
    const res = await knowledgeService.detail(id);
    ctx.body = R.ok(res);
    await next();
  }

  async page(ctx: Context, next: Next): Promise<void> {
    const param = plainToClass(KnowledgePageParam, ctx.request.body);
    const res = await knowledgeService.page(param as any);
    ctx.body = R.ok(res);
    await next();
  }
}

export default new KnowledgeController();