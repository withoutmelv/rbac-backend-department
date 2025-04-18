import { Entity, PrimaryColumn, Column, CreateDateColumn, UpdateDateColumn } from 'typeorm';
import { Expose } from 'class-transformer';

@Entity({
  name: 'sys_knowledge',
  comment: '知识库'
})
export class Knowledge {
  @PrimaryColumn({
    type: 'bigint',
    name: 'id',
    comment: '主键',
  })
  @Expose()
  id?: string;

  @Column({
    type: 'varchar',
    length: 64,
    nullable: false,
    comment: '知识库类型'
  })
  @Expose()
  type?: string;

  @Column({
    type: 'varchar',
    length: 128,
    nullable: false,
    comment: '名称'
  })
  @Expose()
  name?: string;

  @Column({
    type: 'int',
    default: 0,
    comment: '相关文件数量'
  })
  @Expose()
  fileCount?: number;

  @Column({
    type: 'varchar',
    default: 0,
    comment: '知识库简介'
  })
  @Expose()
  description?: number;

  @Column({
    name: 'dept_id', 
    type: 'varchar',
    length: 64,
    nullable: true,
    comment: '部门ID'
  })
  @Expose()
  deptId?: string;

  @CreateDateColumn({ 
    name: 'create_time', 
    type: 'datetime', 
    precision: 3, 
    nullable: true, 
    comment: '创建时间',
    default: new Date().getTime(),
  })
  createTime?: Date;

  @UpdateDateColumn({ 
    name: 'update_time', 
    type: 'datetime', 
    precision: 3, 
    nullable: true, 
    comment: '更新时间',
    default: new Date().getTime(),
  })
  updateTime?: Date;
}