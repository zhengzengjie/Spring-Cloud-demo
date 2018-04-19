/*
Navicat MySQL Data Transfer

Source Server         : 本地测试192.168.141.223
Source Server Version : 50716
Source Host           : 192.168.141.223:3306
Source Database       : dosp_test

Target Server Type    : MYSQL
Target Server Version : 50716
File Encoding         : 65001

Date: 2018-04-18 17:53:30
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin_app_relation
-- ----------------------------
DROP TABLE IF EXISTS `admin_app_relation`;
CREATE TABLE `admin_app_relation` (
  `user_id` int(11) NOT NULL,
  `app_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for admin_permission
-- ----------------------------
DROP TABLE IF EXISTS `admin_permission`;
CREATE TABLE `admin_permission` (
  `user_id` int(11) NOT NULL,
  `app_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for app
-- ----------------------------
DROP TABLE IF EXISTS `app`;
CREATE TABLE `app` (
  `app_id` int(11) NOT NULL,
  `app_name` varchar(255) NOT NULL COMMENT '应用名称',
  `en_name` varchar(255) NOT NULL COMMENT '应用别名',
  `icon` varchar(50) DEFAULT NULL COMMENT '应用图片名称',
  `online_time` timestamp NULL DEFAULT NULL COMMENT '应用上线时间',
  `data_source` varchar(255) DEFAULT NULL COMMENT '数据源名称',
  `category` int(11) DEFAULT NULL,
  `id_alias` varchar(50) DEFAULT NULL,
  `stat_id` varchar(50) DEFAULT NULL,
  `app_alias` varchar(50) NOT NULL,
  PRIMARY KEY (`app_id`),
  UNIQUE KEY `unique_app_alias` (`app_alias`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业务表';

-- ----------------------------
-- Table structure for app_category
-- ----------------------------
DROP TABLE IF EXISTS `app_category`;
CREATE TABLE `app_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for app_exclude_menu
-- ----------------------------
DROP TABLE IF EXISTS `app_exclude_menu`;
CREATE TABLE `app_exclude_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_id` int(11) NOT NULL COMMENT '菜单id',
  `app_id` int(11) DEFAULT NULL COMMENT 'appid',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8 COMMENT='业务过滤掉的通用报表';

-- ----------------------------
-- Table structure for apply_permission_detail
-- ----------------------------
DROP TABLE IF EXISTS `apply_permission_detail`;
CREATE TABLE `apply_permission_detail` (
  `id` varchar(255) NOT NULL COMMENT '主键，时间戳+随机数',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名，rtx号',
  `app_ids` varchar(255) DEFAULT NULL COMMENT '业务id用逗号分隔',
  `role_id` int(11) DEFAULT NULL COMMENT '报表等级',
  `create_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `status` int(11) DEFAULT '1' COMMENT '1有效，0无效',
  `applyer` varchar(255) DEFAULT NULL COMMENT '申请人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for conf_db
-- ----------------------------
DROP TABLE IF EXISTS `conf_db`;
CREATE TABLE `conf_db` (
  `app_id` int(11) NOT NULL,
  `db_name` varchar(100) NOT NULL COMMENT '数据库名称',
  `db_key` varchar(100) DEFAULT NULL COMMENT '数据库key',
  PRIMARY KEY (`app_id`,`db_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='DB配置表';

-- ----------------------------
-- Table structure for conf_sql
-- ----------------------------
DROP TABLE IF EXISTS `conf_sql`;
CREATE TABLE `conf_sql` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sql_key` varchar(100) DEFAULT NULL,
  `sql_name` varchar(100) DEFAULT NULL,
  `sql_value` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='sql模版配置表';

-- ----------------------------
-- Table structure for data_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `data_dictionary`;
CREATE TABLE `data_dictionary` (
  `name` varchar(255) NOT NULL,
  `value` text,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for datasource
-- ----------------------------
DROP TABLE IF EXISTS `datasource`;
CREATE TABLE `datasource` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `create_by` int(11) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `last_update_by` int(11) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for extend_permission_expire
-- ----------------------------
DROP TABLE IF EXISTS `extend_permission_expire`;
CREATE TABLE `extend_permission_expire` (
  `id` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for game_url_prefix
-- ----------------------------
DROP TABLE IF EXISTS `game_url_prefix`;
CREATE TABLE `game_url_prefix` (
  `game_id` varchar(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `url_prefix` varchar(255) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`game_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for global_id
-- ----------------------------
DROP TABLE IF EXISTS `global_id`;
CREATE TABLE `global_id` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `age` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100962 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for login_log
-- ----------------------------
DROP TABLE IF EXISTS `login_log`;
CREATE TABLE `login_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL,
  `login_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=171 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '菜单id',
  `menu_name` varchar(255) NOT NULL COMMENT '菜单名称',
  `parent_id` int(11) NOT NULL COMMENT '父菜单id',
  `is_leaf` int(11) DEFAULT NULL COMMENT '是否叶子节点',
  `order_index` int(11) DEFAULT NULL COMMENT '在同一个父菜单下的显示顺序',
  `url` varchar(1024) DEFAULT NULL COMMENT 'url',
  `app_id` int(11) DEFAULT NULL COMMENT '所属业务,通用业务为1',
  `role_id` int(11) DEFAULT NULL COMMENT '所属角色',
  `create_by` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '菜单创建时间',
  `last_update_by` int(11) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `description` varchar(1024) DEFAULT NULL COMMENT '菜单描述',
  `icon_name` varchar(255) DEFAULT NULL,
  `is_hidden` int(11) DEFAULT '0' COMMENT '是否隐藏  1隐藏 0显示',
  `deleted` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100961 DEFAULT CHARSET=utf8 COMMENT='菜单';

-- ----------------------------
-- Table structure for menu_button_role_relation
-- ----------------------------
DROP TABLE IF EXISTS `menu_button_role_relation`;
CREATE TABLE `menu_button_role_relation` (
  `menu_id` int(11) NOT NULL,
  `button_role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for operate_log
-- ----------------------------
DROP TABLE IF EXISTS `operate_log`;
CREATE TABLE `operate_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operator` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `params` longtext,
  `ip` varchar(50) DEFAULT NULL,
  `operate_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5570 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for operate_log_app
-- ----------------------------
DROP TABLE IF EXISTS `operate_log_app`;
CREATE TABLE `operate_log_app` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` int(11) DEFAULT NULL,
  `operator` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `params` longtext,
  `ip` varchar(50) DEFAULT NULL,
  `operate_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for permission_expire_date
-- ----------------------------
DROP TABLE IF EXISTS `permission_expire_date`;
CREATE TABLE `permission_expire_date` (
  `user_id` int(11) NOT NULL,
  `app_id` int(11) NOT NULL,
  `expire_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for properties
-- ----------------------------
DROP TABLE IF EXISTS `properties`;
CREATE TABLE `properties` (
  `application` varchar(255) NOT NULL,
  `profile` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for report
-- ----------------------------
DROP TABLE IF EXISTS `report`;
CREATE TABLE `report` (
  `report_id` int(11) NOT NULL,
  `menu_id` int(11) DEFAULT NULL COMMENT '所属菜单',
  `report_value` longtext,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `description` varchar(1024) DEFAULT NULL COMMENT '描述',
  `create_by` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `last_update_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for report_role
-- ----------------------------
DROP TABLE IF EXISTS `report_role`;
CREATE TABLE `report_role` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(255) NOT NULL COMMENT '报表角色名称',
  `app_id` int(11) DEFAULT NULL,
  `type` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='报表角色';

-- ----------------------------
-- Table structure for report_role_url
-- ----------------------------
DROP TABLE IF EXISTS `report_role_url`;
CREATE TABLE `report_role_url` (
  `report_role_id` int(11) NOT NULL,
  `app_id` int(11) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `method` varchar(10) DEFAULT NULL,
  `params` text,
  PRIMARY KEY (`report_role_id`,`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for switch_activity
-- ----------------------------
DROP TABLE IF EXISTS `switch_activity`;
CREATE TABLE `switch_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(50) NOT NULL,
  `event_name` varchar(50) NOT NULL,
  `version_mix` text,
  `channel` text,
  `platform` tinyint(4) DEFAULT NULL,
  `sim_type` tinyint(4) DEFAULT NULL,
  `province` text,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `event_position` varchar(255) NOT NULL,
  `display_order` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `event_ext` text,
  `aid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_msg
-- ----------------------------
DROP TABLE IF EXISTS `sys_msg`;
CREATE TABLE `sys_msg` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `create_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(11) DEFAULT '0' COMMENT '状态，1发布，0未发布',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for system_log
-- ----------------------------
DROP TABLE IF EXISTS `system_log`;
CREATE TABLE `system_log` (
  `user_id` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL,
  `content` text,
  `params` text,
  `successful` tinyint(4) NOT NULL,
  `error_info` text,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `execute_time` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `height` double DEFAULT NULL,
  `weight` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for test_account
-- ----------------------------
DROP TABLE IF EXISTS `test_account`;
CREATE TABLE `test_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ld_id` varchar(255) DEFAULT NULL,
  `game_id` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `reg_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for test_account_role
-- ----------------------------
DROP TABLE IF EXISTS `test_account_role`;
CREATE TABLE `test_account_role` (
  `account_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for test_role
-- ----------------------------
DROP TABLE IF EXISTS `test_role`;
CREATE TABLE `test_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL COMMENT '登录用户名',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT '1' COMMENT '状态：1可用，0不可用',
  `guide` int(11) NOT NULL DEFAULT '0' COMMENT '是否启用指引',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加/注册时间',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户';

-- ----------------------------
-- Table structure for user_behavior
-- ----------------------------
DROP TABLE IF EXISTS `user_behavior`;
CREATE TABLE `user_behavior` (
  `view_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `app_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `menu_id` int(11) DEFAULT NULL,
  `menu_name` varchar(255) DEFAULT NULL,
  `params` varchar(255) DEFAULT NULL,
  `is_search_btn` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_behavior2
-- ----------------------------
DROP TABLE IF EXISTS `user_behavior2`;
CREATE TABLE `user_behavior2` (
  `view_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uid` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `fromurl` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_operate_log
-- ----------------------------
DROP TABLE IF EXISTS `user_operate_log`;
CREATE TABLE `user_operate_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `mapper_class` varchar(255) NOT NULL,
  `sql` text NOT NULL,
  `params` longtext,
  `operate_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `publish_date` datetime DEFAULT NULL,
  `operate_alias_name` varchar(50) DEFAULT NULL COMMENT '操作别名，发布时通过user_id和operate发布',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12654 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_permission
-- ----------------------------
DROP TABLE IF EXISTS `user_permission`;
CREATE TABLE `user_permission` (
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  `app_id` int(11) NOT NULL COMMENT '业务ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户权限';

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL DEFAULT '2' COMMENT '角色名称',
  `role_desc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色表';

-- ----------------------------
-- Table structure for user_role_relation
-- ----------------------------
DROP TABLE IF EXISTS `user_role_relation`;
CREATE TABLE `user_role_relation` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
