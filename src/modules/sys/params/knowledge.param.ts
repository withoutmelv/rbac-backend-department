import { IsNotEmpty } from "class-validator";
import { Role } from "../entities/role";
import { PageParam } from "../../../utils/page-param";

export class KnowledgeParam{
    
}
export class KnowledgePageParam extends PageParam<Role>{
    
}