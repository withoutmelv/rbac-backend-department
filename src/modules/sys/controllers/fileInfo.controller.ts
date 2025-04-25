import { Context, Next } from "koa";
import { R } from "../../../utils/common-response";
import fileInfoService from "../services/fileInfo.service";

class DictController {
    async uploadFile(ctx: Context, next: Next): Promise<void> {
        const res = await fileInfoService.uploadFile(ctx);
        ctx.body = R.ok(res);
        await next();
    }
  }
  export default new DictController();