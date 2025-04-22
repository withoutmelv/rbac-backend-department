/*
 Navicat Premium Data Transfer

 Source Server         : dev
 Source Server Type    : MySQL
 Source Server Version : 50728
 Source Host           : 172.16.31.160:3306
 Source Schema         : mldong-plus

 Target Server Type    : MySQL
 Target Server Version : 50728
 File Encoding         : 65001

 Date: 07/12/2023 17:30:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `id` bigint(20) NOT NULL COMMENT '配置ID',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置名称',
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '唯一编码',
  `group_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分组编码',
  `content` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '配置内容',
  `is_sys` tinyint(1) NULL DEFAULT 0 COMMENT '是否系统',
  `enabled` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(3) NULL DEFAULT NULL COMMENT '创建时间',
  `create_user` bigint(20) NULL DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(3) NULL DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) NULL DEFAULT NULL COMMENT '更新用户',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_config_code`(`code`) USING BTREE,
  INDEX `idx_config_group_code`(`group_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `id` bigint(20) NOT NULL COMMENT '部门ID',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父ID',
  `pids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '父ID集合',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '部门名称',
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '唯一编码',
  `sort` bigint(20) NULL DEFAULT 999 COMMENT '排序',
  `enabled` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用',
  `leader_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门负责人ID集合',
  `main_leader_id` bigint(20) NULL DEFAULT NULL COMMENT '分管领导ID',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(3) NULL DEFAULT NULL COMMENT '创建时间',
  `create_user` bigint(20) NULL DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(3) NULL DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) NULL DEFAULT NULL COMMENT '更新用户',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sys_dept_code`(`code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (1704769507461627905, 0, NULL, '一级部门', 'dept_10', 10, 1, '1686404946814533633', 1686404946814533633, NULL, '2023-09-21 16:08:18.321', 1567738052492341249, '2023-09-21 16:08:18.321', 1567738052492341249, 0);
INSERT INTO `sys_dept` VALUES (1704792169135079426, 1704769507461627905, NULL, '部门A', 'dept_A', 10, 1, '1686404946814533633', 1686404946814533633, NULL, '2023-09-21 17:38:21.286', 1567738052492341249, '2023-09-28 15:06:32.374', 1567738052492341249, 0);
INSERT INTO `sys_dept` VALUES (1711659720523776002, 1704769507461627905, NULL, '部门B', 'dept_B', 10, 1, '1711659551216500738', 1711659551216500738, NULL, '2023-10-10 16:27:33.130', 1567738052492341249, '2023-10-10 16:27:33.130', 1567738052492341249, 0);

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` bigint(20) NOT NULL COMMENT '字典ID',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典名称',
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '唯一编码',
  `data_type` int(11) NULL DEFAULT 1 COMMENT '数据类型(1:字符串；2：整型)',
  `group_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分组编码',
  `sort` bigint(20) NULL DEFAULT 999 COMMENT '排序',
  `enabled` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(3) NULL DEFAULT NULL COMMENT '创建时间',
  `create_user` bigint(20) NULL DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(3) NULL DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) NULL DEFAULT NULL COMMENT '更新用户',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_dict_code`(`code`) USING BTREE,
  INDEX `idx_dict_group_code`(`group_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES (1712269710221545473, '流程分类', 'wf_process_type', 1, 'default', 1, 1, NULL, '2023-10-12 08:51:26.006', 1567738052492341249, '2023-10-12 10:10:53.906', 1567738052492341249, 0);

-- ----------------------------
-- Table structure for sys_dict_item
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_item`;
CREATE TABLE `sys_dict_item`  (
  `id` bigint(20) NOT NULL COMMENT '字典项ID',
  `dict_id` bigint(20) NOT NULL COMMENT '字典ID',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典项名称',
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '唯一编码',
  `sort` bigint(20) NULL DEFAULT 999 COMMENT '排序',
  `enabled` tinyint(1) NULL DEFAULT NULL COMMENT '是否启用',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(3) NULL DEFAULT NULL COMMENT '创建时间',
  `create_user` bigint(20) NULL DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(3) NULL DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) NULL DEFAULT NULL COMMENT '更新用户',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_dict_item_dict_id`(`dict_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典项' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_item
-- ----------------------------
INSERT INTO `sys_dict_item` VALUES (1712269898998779906, 1712269710221545473, '假勤管理', '1', 1, 1, NULL, '2023-10-12 08:52:11.015', 1567738052492341249, '2023-10-12 08:52:11.015', 1567738052492341249, 0);
INSERT INTO `sys_dict_item` VALUES (1712269964610277377, 1712269710221545473, '人事管理', '2', 2, 1, NULL, '2023-10-12 08:52:26.658', 1567738052492341249, '2023-10-12 08:52:26.658', 1567738052492341249, 0);
INSERT INTO `sys_dict_item` VALUES (1712270042536251394, 1712269710221545473, '智能财务', '3', 3, 1, NULL, '2023-10-12 08:52:45.249', 1567738052492341249, '2023-10-12 08:52:45.249', 1567738052492341249, 0);
INSERT INTO `sys_dict_item` VALUES (1712270124698472450, 1712269710221545473, '法务管理', '4', 4, 1, NULL, '2023-10-12 08:53:04.825', 1567738052492341249, '2023-10-12 08:53:04.825', 1567738052492341249, 0);
INSERT INTO `sys_dict_item` VALUES (1712270179962621953, 1712269710221545473, '行政管理', '5', 5, 1, NULL, '2023-10-12 08:53:18.001', 1567738052492341249, '2023-10-12 08:53:18.001', 1567738052492341249, 0);
INSERT INTO `sys_dict_item` VALUES (1712270257162981377, 1712269710221545473, '业务管理', '6', 6, 1, NULL, '2023-10-12 08:53:36.408', 1567738052492341249, '2023-10-12 08:53:36.408', 1567738052492341249, 0);
INSERT INTO `sys_dict_item` VALUES (1712270314243264513, 1712269710221545473, '其他', '99', 99, 1, NULL, '2023-10-12 08:53:50.016', 1567738052492341249, '2023-10-12 08:53:50.016', 1567738052492341249, 0);

-- ----------------------------
-- Table structure for sys_file_info
-- ----------------------------
DROP TABLE IF EXISTS `sys_file_info`;
CREATE TABLE `sys_file_info`  (
  `id` bigint(20) NOT NULL COMMENT '文件信息ID',
  `url` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件访问地址',
  `size` bigint(20) NULL DEFAULT NULL COMMENT '文件大小，单位字节',
  `size_info` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件大小，有单位',
  `filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `original_filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '原始文件名',
  `base_path` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '基础存储路径',
  `path` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '存储路径',
  `ext` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件扩展名',
  `content_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'MIME类型',
  `platform` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '存储平台',
  `th_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '缩略图访问路径',
  `th_filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '缩略图大小，单位字节',
  `th_size` bigint(20) NULL DEFAULT NULL COMMENT '缩略图大小，单位字节',
  `th_size_info` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '缩略图大小，有单位',
  `th_content_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '缩略图MIME类型',
  `object_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件所属对象id',
  `object_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件所属对象类型，例如用户头像，评价图片',
  `attr` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '附加属性',
  `create_time` datetime(3) NULL DEFAULT NULL COMMENT '创建时间',
  `create_user` bigint(20) NULL DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(3) NULL DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) NULL DEFAULT NULL COMMENT '更新用户',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文件信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_file_info
-- ----------------------------

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` bigint(20) NOT NULL COMMENT '菜单ID',
  `app_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '应用编码',
  `parent_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '父ID',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '唯一编码',
  `pids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '父ID集合',
  `type` int(11) NULL DEFAULT NULL COMMENT '菜单类型<sys_menu_type>',
  `sort` bigint(20) NULL DEFAULT 999 COMMENT '排序',
  `path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由地址',
  `component` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件地址',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `is_show` tinyint(1) NULL DEFAULT 1 COMMENT '是否显示',
  `is_link` tinyint(1) NULL DEFAULT NULL COMMENT '是否链接',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '外部链接地址',
  `enabled` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用',
  `open_type` int(11) NULL DEFAULT NULL COMMENT '打开方式<sys_menu_open_type>',
  `is_cache` tinyint(1) NULL DEFAULT NULL COMMENT '是否缓存',
  `is_sync` tinyint(1) NULL DEFAULT 1 COMMENT '是否同步',
  `variable` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '额外参数JSON',
  `create_time` datetime(3) NULL DEFAULT NULL COMMENT '创建时间',
  `create_user` bigint(20) NULL DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(3) NULL DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) NULL DEFAULT NULL COMMENT '更新用户',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sys_menu_code`(`code`) USING BTREE,
  INDEX `idx_sys_menu_app_code`(`app_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1704792844271271937, 'platform', 0, '系统设置', 'sys:manager', '[0],', 1, 100, '/sys/manager', 'LAYOUT', 'icon-qietu-shezhi', 0, 0, NULL, 1, 1, 0, 1, '{}', '2023-09-21 17:41:02.250', 1567738052492341249, '2023-12-06 16:13:32.062', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844296437762, 'platform', 1704792844271271937, '用户管理', 'sys:user', '[0],[1704792844271271937],', 2, 210, '/sys/user/index', '/sys/user/index', 'ion:grid-outline', 0, 0, NULL, 1, 1, 0, 1, '{}', '2023-09-21 17:41:02.256', 1567738052492341249, '2023-12-06 16:13:32.066', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844317409281, 'platform', 1704792844296437762, '分页查询用户', 'sys:user:page', '[0],[1704792844271271937],[1704792844296437762],', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-21 17:41:02.261', 1567738052492341249, '2023-12-06 16:13:32.069', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844346769410, 'platform', 1704792844296437762, '查看用户详情', 'sys:user:detail', '[0],[1704792844271271937],[1704792844296437762],', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-21 17:41:02.269', 1567738052492341249, '2023-12-06 16:13:32.073', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844371935233, 'platform', 1704792844296437762, '添加用户', 'sys:user:save', '[0],[1704792844271271937],[1704792844296437762],', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-21 17:41:02.275', 1567738052492341249, '2023-12-06 16:13:32.077', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844392906754, 'platform', 1704792844296437762, '修改用户', 'sys:user:update', '[0],[1704792844271271937],[1704792844296437762],', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-21 17:41:02.279', 1567738052492341249, '2023-12-06 16:13:32.080', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844426461186, 'platform', 1704792844296437762, '删除用户', 'sys:user:remove', '[0],[1704792844271271937],[1704792844296437762],', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-21 17:41:02.287', 1567738052492341249, '2023-12-06 16:13:32.084', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1705121465989025793, 'platform', 1704792844296437762, '扮演用户', 'sys:playUser', '[0],[1704792844271271937],[1704792844296437762],', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-22 15:26:51.773', 1567738052492341249, '2023-12-06 16:13:32.088', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1732214793536491522, 'platform', 1704792844296437762, '授权角色', 'sys:user:grantRole', '[0],[1704792844271271937],[1704792844296437762],', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-12-06 09:46:04.431', 1567738052492341249, '2023-12-06 16:13:32.092', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844447432706, 'platform', 1704792844271271937, '角色管理', 'sys:role', '[0],[1704792844271271937],', 2, 220, '/sys/role/index', '/sys/role/index', 'ion:grid-outline', 0, 0, NULL, 1, 1, 0, 1, '{}', '2023-09-21 17:41:02.292', 1567738052492341249, '2023-12-06 16:13:32.096', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844464209922, 'platform', 1704792844447432706, '分页查询角色', 'sys:role:page', '[0],[1704792844271271937],[1704792844447432706],', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-21 17:41:02.296', 1567738052492341249, '2023-12-06 16:13:32.101', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844480987137, 'platform', 1704792844447432706, '查看角色详情', 'sys:role:detail', '[0],[1704792844271271937],[1704792844447432706],', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-21 17:41:02.300', 1567738052492341249, '2023-12-06 16:13:32.106', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844497764353, 'platform', 1704792844447432706, '添加角色', 'sys:role:save', '[0],[1704792844271271937],[1704792844447432706],', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-21 17:41:02.305', 1567738052492341249, '2023-12-06 16:13:32.109', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844518735873, 'platform', 1704792844447432706, '修改角色', 'sys:role:update', '[0],[1704792844271271937],[1704792844447432706],', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-21 17:41:02.309', 1567738052492341249, '2023-12-06 16:13:32.115', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844535513089, 'platform', 1704792844447432706, '删除角色', 'sys:role:remove', '[0],[1704792844271271937],[1704792844447432706],', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-21 17:41:02.313', 1567738052492341249, '2023-12-06 16:13:32.119', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844556484610, 'platform', 1704792844447432706, '设置权限（保存角色菜单关系）', 'sys:rbac:saveRoleMenu', '[0],[1704792844271271937],[1704792844447432706],', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-21 17:41:02.318', 1567738052492341249, '2023-12-06 16:13:32.123', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844573261826, 'platform', 1704792844447432706, '成员管理（通过角色ID获取用户列表）', 'sys:rbac:userListByRoleId', '[0],[1704792844271271937],[1704792844447432706],', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-21 17:41:02.322', 1567738052492341249, '2023-12-06 16:13:32.127', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844590039042, 'platform', 1704792844447432706, '成员管理（添加用户角色关系）', 'sys:rbac:saveUserRole', '[0],[1704792844271271937],[1704792844447432706],', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-21 17:41:02.326', 1567738052492341249, '2023-12-06 16:13:32.131', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844602621953, 'platform', 1704792844447432706, '成员管理（获取用户列表-排除指定角色）', 'sys:rbac:userListExcludeRoleId', '[0],[1704792844271271937],[1704792844447432706],', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-21 17:41:02.329', 1567738052492341249, '2023-12-06 16:13:32.134', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844611010562, 'platform', 1704792844447432706, '成员管理（删除用户角色关系）', 'sys:rbac:removeUserRole', '[0],[1704792844271271937],[1704792844447432706],', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-21 17:41:02.333', 1567738052492341249, '2023-12-06 16:13:32.137', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844611010564, 'platform', 1704792844447432706, '知识库授权', 'sys:rbac:saveRoleKnowledge', '[0],[1704792844271271937],[1704792844447432706],', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-21 17:41:02.333', 1567738052492341249, '2023-12-06 16:13:32.137', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844611010568, 'platform', 1704792844447432706, '部门树', 'sys:dept:tree', '[0],[1704792844271271937],[1704792844447432706],', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-21 17:41:02.333', 1567738052492341249, '2023-12-06 16:13:32.137', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844787171329, 'platform', 1704792844271271937, '部门管理', 'sys:dept', '[0],[1704792844271271937],', 2, 230, '/sys/dept/index', '/sys/dept/index', 'ion:grid-outline', 0, 0, NULL, 1, 1, 0, 1, '{}', '2023-09-21 17:41:02.373', 1567738052492341249, '2023-12-06 16:13:32.179', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844795559938, 'platform', 1704792844787171329, '部门列表', 'sys:dept:list', '[0],[1704792844271271937],[1704792844787171329],', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-21 17:41:02.376', 1567738052492341249, '2023-12-06 16:13:32.182', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844812337154, 'platform', 1704792844787171329, '查看部门详情', 'sys:dept:detail', '[0],[1704792844271271937],[1704792844787171329],', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-21 17:41:02.379', 1567738052492341249, '2023-12-06 16:13:32.188', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844820725761, 'platform', 1704792844787171329, '添加部门', 'sys:dept:save', '[0],[1704792844271271937],[1704792844787171329],', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-21 17:41:02.383', 1567738052492341249, '2023-12-06 16:13:32.192', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844837502977, 'platform', 1704792844787171329, '修改部门', 'sys:dept:update', '[0],[1704792844271271937],[1704792844787171329],', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-21 17:41:02.386', 1567738052492341249, '2023-12-06 16:13:32.195', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844854280193, 'platform', 1704792844787171329, '删除部门', 'sys:dept:remove', '[0],[1704792844271271937],[1704792844787171329],', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-21 17:41:02.390', 1567738052492341249, '2023-12-06 16:13:32.198', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844787171328, 'platform', 1704792844271271937, '知识库管理', 'sys:knowledge', '[0],[1704792844271271937],', 2, 233, '/sys/knowledge/index', '/sys/knowledge/index', 'ion:grid-outline', 0, 0, NULL, 1, 1, 0, 1, '{}', '2023-09-21 17:41:02.373', 1567738052492341249, '2023-12-06 16:13:32.179', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844787171333, 'platform', 1704792844787171328, '知识库新增', 'sys:knowledge:save', '[0],[1704792844271271937],[1704792844787171328]', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-21 17:41:02.373', 1567738052492341249, '2023-12-06 16:13:32.179', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844787171330, 'platform', 1704792844787171328, '知识库删除', 'sys:knowledge:remove', '[0],[1704792844271271937],[1704792844787171328]', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-21 17:41:02.373', 1567738052492341249, '2023-12-06 16:13:32.179', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844787171331, 'platform', 1704792844787171328, '知识库详情', 'sys:knowledge:detail', '[0],[1704792844271271937],[1704792844787171328]', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-21 17:41:02.373', 1567738052492341249, '2023-12-06 16:13:32.179', 1567738052492341249, 0);
INSERT INTO `sys_menu` VALUES (1704792844787171332, 'platform', 1704792844787171328, '知识库更新', 'sys:knowledge:update', '[0],[1704792844271271937],[1704792844787171328]', 4, 999, NULL, NULL, NULL, 1, NULL, NULL, 1, 0, NULL, 1, '{}', '2023-09-21 17:41:02.373', 1567738052492341249, '2023-12-06 16:13:32.179', 1567738052492341249, 0);


-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `id` bigint(20) NOT NULL COMMENT '通知公告ID',
  `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '标题',
  `content` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '内容',
  `type` int(11) NOT NULL COMMENT '类型<sys_notice_type>',
  `publish_time` datetime(3) NULL DEFAULT NULL COMMENT '发布时间',
  `state` int(11) NULL DEFAULT NULL COMMENT '发布状态<sys_notice_state>',
  `variable` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '扩展参数JSON',
  `create_time` datetime(3) NULL DEFAULT NULL COMMENT '创建时间',
  `create_user` bigint(20) NULL DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(3) NULL DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) NULL DEFAULT NULL COMMENT '更新用户',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------

-- ----------------------------
-- Table structure for sys_notice_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice_user`;
CREATE TABLE `sys_notice_user`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `notice_id` bigint(20) NOT NULL COMMENT '通知公告ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `is_read` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否已读',
  `create_time` datetime(3) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(3) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_notice_user_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'r_通知公告用户关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice_user
-- ----------------------------

-- ----------------------------
-- Table structure for sys_op_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_op_log`;
CREATE TABLE `sys_op_log`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `op_type` tinyint(4) NULL DEFAULT NULL COMMENT '操作类型',
  `success` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否执行成功（Y-是，N-否）',
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '具体消息',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip',
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '浏览器',
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作系统',
  `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求地址',
  `class_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类名称',
  `method_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '方法名称',
  `req_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求方式（GET POST PUT DELETE)',
  `param` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '请求参数',
  `result` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '返回结果',
  `op_time` datetime(0) NULL DEFAULT NULL COMMENT '操作时间',
  `account` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作账号',
  `play_user_account` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '扮演者账号',
  `request_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求编号',
  `sign_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '签名数据（除ID外）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sys_op_log_request_no`(`request_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统操作日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_op_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `id` bigint(20) NOT NULL COMMENT '岗位ID',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '唯一编码',
  `sort` bigint(20) NULL DEFAULT 999 COMMENT '排序',
  `enabled` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(3) NULL DEFAULT NULL COMMENT '创建时间',
  `create_user` bigint(20) NULL DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(3) NULL DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) NULL DEFAULT NULL COMMENT '更新用户',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sys_post_code`(`code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1705025204485042177, '架构师', 'architect', 30, 1, NULL, '2023-09-22 09:04:21.243', 1567738052492341249, '2023-10-12 08:57:47.461', 1567738052492341249, 0);
INSERT INTO `sys_post` VALUES (1705025270398529538, '后端开发', 'back_dev', 40, 1, NULL, '2023-09-22 09:04:36.957', 1567738052492341249, '2023-10-12 08:58:17.706', 1567738052492341249, 0);
INSERT INTO `sys_post` VALUES (1705025362337673217, '前端开发', 'front_dev', 50, 1, NULL, '2023-09-22 09:04:58.878', 1567738052492341249, '2023-10-12 08:58:31.035', 1567738052492341249, 0);
INSERT INTO `sys_post` VALUES (1705025419610894338, '业务员', 'biz', 60, 1, NULL, '2023-09-22 09:05:12.532', 1567738052492341249, '2023-10-12 08:58:38.544', 1567738052492341249, 0);
INSERT INTO `sys_post` VALUES (1712270597442670593, '总经理', 'general_manager', 10, 1, NULL, '2023-10-12 08:54:57.537', 1567738052492341249, '2023-10-12 08:57:40.250', 1567738052492341249, 0);
INSERT INTO `sys_post` VALUES (1712271151770308609, '部门经理', 'dept_manager', 20, 1, NULL, '2023-10-12 08:57:09.699', 1567738052492341249, '2023-10-12 08:57:32.487', 1567738052492341249, 0);
INSERT INTO `sys_post` VALUES (1712271647297966081, '董事长', 'chairman', 1, 1, NULL, '2023-10-12 08:59:07.842', 1567738052492341249, '2023-10-12 08:59:07.842', 1567738052492341249, 0);

-- ----------------------------
-- Table structure for sys_knowledge
-- ----------------------------
DROP TABLE IF EXISTS `sys_knowledge`;
CREATE TABLE `sys_knowledge`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '知识库类型',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `fileCount` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '相关文件数量',
  `dept_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '部门ID',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '知识库简介',
  `create_time` datetime(3) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(3) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sys_knowledge_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '知识库' ROW_FORMAT = Dynamic;
-- ----------------------------
-- Records of sys_knowledge_base
-- ----------------------------
-- INSERT INTO `sys_knowledge` VALUES (1, 'public', '公共知识库', 0, '-', '', NOW(), NOW());
-- INSERT INTO `sys_knowledge` VALUES (2, 'public', '科普知识库', 0, '-', '', NOW(), NOW());
-- INSERT INTO `sys_knowledge` VALUES (3, 'department', '部门A知识库', 0, '1704792169135079426', '', NOW(), NOW());
-- INSERT INTO `sys_knowledge` VALUES (4, 'department', '部门B知识库', 0, '1711659720523776002', '', NOW(), NOW());
-- ----------------------------
-- Table structure for sys_role_knowledge
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_knowledge`;
CREATE TABLE `sys_role_knowledge`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `knowledge_id` bigint(20) NOT NULL COMMENT '知识库ID',
  `create_time` datetime(3) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(3) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sys_knowledge_id`(`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色知识库关系表' ROW_FORMAT = Dynamic;
-- ----------------------------
-- Records of sys_knowledge_base
-- ----------------------------
INSERT INTO `sys_role_knowledge` (`id`, `role_id`, `knowledge_id`, `create_time`, `update_time`) 
VALUES 
(1, 1705019929250172930, 1, NOW(), NOW()),
(2, 1705019929250172930, 2, NOW(), NOW()),
(3, 1705019929250172930, 3, NOW(), NOW()),
(4, 1705019929250172930, 4, NOW(), NOW());

-- ----------------------------
-- Table structure for sys_rel_third_account
-- ----------------------------
DROP TABLE IF EXISTS `sys_rel_third_account`;
CREATE TABLE `sys_rel_third_account`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `third_account` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方账号',
  `third_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第三方账号类型',
  `create_time` datetime(3) NULL DEFAULT NULL COMMENT '创建时间',
  `create_user` bigint(20) NULL DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(3) NULL DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) NULL DEFAULT NULL COMMENT '更新用户',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_rel_third_account_uid`(`user_id`) USING BTREE,
  INDEX `idx_rel_third_account_aid`(`third_account`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '关联的第三方账号' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_rel_third_account
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint(20) NOT NULL COMMENT '角色ID',
  `app_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '应用编码',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '唯一编码',
  `dept_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门ID',
  `role_type` int(11) NOT NULL COMMENT '角色类型<sys_role_type>',
  `enabled` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否启用',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(3) NULL DEFAULT NULL COMMENT '创建时间',
  `create_user` bigint(20) NULL DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(3) NULL DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) NULL DEFAULT NULL COMMENT '更新用户',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sys_role_name`(`name`) USING BTREE,
  INDEX `idx_sys_role_code`(`code`) USING BTREE,
  INDEX `idx_sys_role_app_code`(`app_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1705019929250172930, 'platform', 'A部门管理员', 'manageA', '1704792169135079426', 1, 1, NULL, NOW(), 1567738052492341249, NOW(), 1567738052492341249, 0);
INSERT INTO `sys_role` VALUES (1705019929250172931, 'platform', 'B部门管理员', 'manageB', '1711659720523776002', 1, 1, NULL, NOW(), 1567738052492341249, NOW(), 1567738052492341249, 0);
INSERT INTO `sys_role` VALUES (1705019929250172929, 'platform', '游客', 'guest', '-', 1, 1, NULL, NOW(), 1567738052492341249, NOW(), 1567738052492341249, 0);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_role_menu_rid`(`role_id`) USING BTREE,
  INDEX `idx_role_menu_mid`(`menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'r_角色菜单关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------

-- ----------------------------
-- Table structure for sys_task_run_history_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_task_run_history_data`;
CREATE TABLE `sys_task_run_history_data`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `task_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `spring_bean_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'springbean名称',
  `biz_id` bigint(20) NOT NULL COMMENT '业务ID',
  `task_state` int(11) NULL DEFAULT 1 COMMENT '任务状态(0：结束；1：活动)',
  `variable` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '扩展属性JSON',
  `result` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '执行结果',
  `create_time` datetime(3) NULL DEFAULT NULL COMMENT '创建时间',
  `create_user` bigint(20) NULL DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(3) NULL DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) NULL DEFAULT NULL COMMENT '更新用户',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '任务运行的历史数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_task_run_history_data
-- ----------------------------

-- ----------------------------
-- Table structure for sys_task_running_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_task_running_data`;
CREATE TABLE `sys_task_running_data`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `task_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `spring_bean_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'springbean名称',
  `biz_id` bigint(20) NOT NULL COMMENT '业务ID',
  `variable` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '扩展属性JSON',
  `allow_max_error_count` int(11) NULL DEFAULT 1000 COMMENT '允许最大失败次数',
  `error_count` int(11) NULL DEFAULT 0 COMMENT '运行失败次数',
  `create_time` datetime(3) NULL DEFAULT NULL COMMENT '创建时间',
  `create_user` bigint(20) NULL DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(3) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '任务运行中的数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_task_running_data
-- ----------------------------

-- ----------------------------
-- Table structure for sys_third_party_callback
-- ----------------------------
DROP TABLE IF EXISTS `sys_third_party_callback`;
CREATE TABLE `sys_third_party_callback`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `channel_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '回调渠道(wx：微信；ali：支付宝；union银联)',
  `service_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '回调业务ID',
  `service_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '回调服务类型(wx_pay：微信支付回调，wx_refund微信退款回调)',
  `body` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '回调请求正文',
  `handle_status` int(11) NULL DEFAULT 0 COMMENT '处理状态（0：未处理；1：处理成功：2：处理失败）',
  `handle_result` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '处理结果数据',
  `create_time` datetime(3) NULL DEFAULT NULL COMMENT '创建时间',
  `create_user` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(3) NULL DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) NULL DEFAULT NULL COMMENT '更新用户',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_third_party_callback_sid`(`service_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '第三方回调处理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_third_party_callback
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint(20) NOT NULL COMMENT '用户ID',
  `user_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `real_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '姓名',
  `nick_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户密码',
  `salt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码加盐',
  `mobile_phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '手机号',
  `tel` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `admin_type` int(11) NULL DEFAULT NULL COMMENT '管理员类型<sys_admin_type>',
  `sex` int(11) NULL DEFAULT 3 COMMENT '性别<sys_sex>',
  `is_locked` tinyint(1) NULL DEFAULT 0 COMMENT '是否锁定',
  `dept_id` varchar(255) NULL DEFAULT NULL COMMENT '所属部门',
  `post_id` bigint(20) NULL DEFAULT NULL COMMENT '所属岗位',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(3) NULL DEFAULT NULL COMMENT '创建时间',
  `create_user` bigint(20) NULL DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(3) NULL DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) NULL DEFAULT NULL COMMENT '更新用户',
  `guest_id` varchar(255) NULL DEFAULT 0 COMMENT '游客ID',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sys_user_user_name`(`user_name`) USING BTREE,
  INDEX `idx_sys_user_real_name`(`real_name`) USING BTREE,
  INDEX `idx_sys_user_mobile_phone`(`mobile_phone`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1567738052492341249, 'superAdmin', '超级管理员', NULL, NULL, '211a86bdebe70443aa2e567bfc1e4d6e', 'tyszoxth', '18600000000', '18276163680', 't.bqoqwhoo@kcshc.nc', 1, 1, 0, 1704792169135079426, 1705025204485042177, NULL, '2022-09-08 12:54:13.535', 0, '2023-09-22 09:08:49.157', 1567738052492341249, NULL, 0);
INSERT INTO `sys_user` VALUES (1686404946814533633, 'admin', '蒙立东', NULL, NULL, '211a86bdebe70443aa2e567bfc1e4d6e', 'tyszoxth', '18276163688', NULL, NULL, 2, 1, 0, 1704792169135079426, 1705025419610894338, NULL, '2023-08-01 23:54:05.866', 1567738052492341249, '2023-09-25 17:01:02.723', 1567738052492341249, NULL, 0);
INSERT INTO `sys_user` VALUES (1711659551216500738, 'u0010', '黄红', '', NULL, '2f4896ecef0ce948d9340ab895f72159', 'vqylahu6', '13800000020', NULL, NULL, 2, 2, 0, 1711659720523776002, 1712271151770308609, NULL, '2023-10-10 16:26:52.774', 1567738052492341249, '2023-10-12 08:59:31.794', 1567738052492341249, NULL, 0);
INSERT INTO `sys_user` VALUES (1711661958608584706, 'u0011', '王强', NULL, NULL, '1166408769777440bc33d42583712929', 'heco3yr0', '13602312301', NULL, NULL, 2, 1, 0, 1704792169135079426, 1712270597442670593, NULL, '2023-10-10 16:36:26.740', 1567738052492341249, '2023-10-12 08:59:40.703', 1567738052492341249, NULL, 0);
INSERT INTO `sys_user` VALUES (1714545752097366017, 'u0012', '李青', NULL, NULL, 'a2575ec4a1f33a8f8ad40d2acd9bb5cb', 'a56uxlm2', '18264232652', NULL, NULL, 2, 2, 0, 1711659720523776002, 1705025419610894338, NULL, '2023-10-18 15:35:36.676', 1567738052492341249, '2023-10-18 15:35:44.231', 1567738052492341249, NULL, 0);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sys_user_role_uid`(`user_id`) USING BTREE,
  INDEX `idx_sys_user_role_rid`(`role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'r_用户角色关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1705027977171644418, 1686404946814533633, 1705019929250172930);
INSERT INTO `sys_user_role` VALUES (1714545862755688449, 1711659551216500738, 1705019929250172931);
INSERT INTO `sys_user_role` VALUES (1714545862759882754, 1711661958608584706, 1705019929250172930);
INSERT INTO `sys_user_role` VALUES (1714545862797631489, 1714545752097366017, 1705019929250172931);

-- ----------------------------
-- Table structure for sys_vis_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_vis_log`;
CREATE TABLE `sys_vis_log`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `success` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否执行成功（Y-是，N-否）',
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '具体消息',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip',
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '浏览器',
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作系统',
  `vis_type` tinyint(4) NOT NULL COMMENT '操作类型（字典 1登入 2登出）',
  `vis_time` datetime(0) NULL DEFAULT NULL COMMENT '访问时间',
  `account` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问账号',
  `sign_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '签名数据（除ID外）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问日志表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_vis_log
-- ----------------------------
SET FOREIGN_KEY_CHECKS = 1;
