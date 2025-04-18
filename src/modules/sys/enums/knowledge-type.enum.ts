
import { DictEnum } from "../../../decorators/dict-enum.decorator";
import { CodedEnum } from "../../../types/coded-enum";

@DictEnum({ key: 'knowledge_type', name: '知识库类型' })
export class KnowledgeEnum implements CodedEnum {
  static PUBLIC = new KnowledgeEnum('public', '公共知识库');
  static DEPARTMENT = new KnowledgeEnum('department', '部门知识库');

  private constructor(private code: string, private message: string) {}

  getCode(): any {
    return this.code;
  }

  getMessage(): string {
    return this.message;
  }
}