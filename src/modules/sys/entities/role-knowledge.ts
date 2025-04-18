import { Entity, PrimaryColumn, Column } from 'typeorm';
import { Expose } from 'class-transformer';

@Entity({
    name: 'sys_role_knowledge',
    comment: '角色-知识库关联表'
})
export class RoleKnowledge {
    @PrimaryColumn({
        type: 'bigint',
        name: 'id',
        comment: '主键',
    })
    @Expose()
    id?: string;
    
    @Column({
        type: 'bigint',
        name: 'role_id',
        comment: '角色ID'
    })
    @Expose()
    roleId!: string; // 使用确定赋值断言，明确告知TypeScript该属性会被初始化

    @Column({
        type: 'bigint',
        name: 'knowledge_id',
        comment: '知识库ID'
    })
    @Expose()
    knowledgeId!: string;
}