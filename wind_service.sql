/*
Navicat MySQL Data Transfer

Source Server         : 本地测试192.168.141.223
Source Server Version : 50716
Source Host           : 192.168.141.223:3306
Source Database       : wind_service_wxt

Target Server Type    : MYSQL
Target Server Version : 50716
File Encoding         : 65001

Date: 2018-04-18 17:54:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for account_ban_log
-- ----------------------------
DROP TABLE IF EXISTS `account_ban_log`;
CREATE TABLE `account_ban_log` (
  `create_by` varchar(20) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `accounts` text NOT NULL,
  `ban_time` bigint(20) NOT NULL,
  `ban_reason` varchar(255) DEFAULT NULL,
  `response_body` text,
  `game_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for activity
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(64) NOT NULL COMMENT '游戏业务id',
  `flag_num` int(11) DEFAULT NULL COMMENT '活动标识， 每个游戏业务下的flag_num是唯一的。',
  `name` varchar(255) NOT NULL COMMENT '兑换码活动名',
  `start_time` datetime NOT NULL COMMENT '兑换活动开始时间',
  `end_time` datetime NOT NULL COMMENT '兑换活动结束时间',
  `available_number` int(11) NOT NULL DEFAULT '1' COMMENT '可兑换次数',
  `cycle` int(11) DEFAULT NULL COMMENT '周期， 单位为天',
  `min_level` int(11) DEFAULT NULL COMMENT '最小角色等级',
  `max_level` int(11) DEFAULT NULL COMMENT '最大角色等级',
  `server_ids` varchar(512) DEFAULT NULL COMMENT '区服',
  `group_server_ids` varchar(512) DEFAULT NULL COMMENT '分组区服id树，用于报表展示',
  `channels` longtext COMMENT '渠道',
  `mutex_ids` varchar(512) DEFAULT NULL COMMENT '互斥活动ids',
  `gifts` text NOT NULL COMMENT '礼包',
  `create_by` varchar(64) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `last_update_by` varchar(30) DEFAULT NULL,
  `last_updated_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(4) DEFAULT '0' COMMENT '是否删除，默认不删除， 0：不删除，1：删除',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注说明',
  `total_num` int(11) DEFAULT '0' COMMENT '兑换码总条数',
  `used_num` int(11) DEFAULT '0' COMMENT '已使用条数，备用字段',
  `gen_status` int(11) DEFAULT '0' COMMENT '兑换码生成状态 0：完成，1：生成中，2：生成出错',
  `bloom_filter_data` longtext COMMENT '布隆过滤器数据',
  PRIMARY KEY (`id`),
  KEY `idx_ac_gameid` (`game_id`) USING BTREE,
  KEY `idx_ac_flagnum` (`flag_num`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1185 DEFAULT CHARSET=utf8 COMMENT='兑换码活动';

-- ----------------------------
-- Table structure for activity_in_game_config
-- ----------------------------
DROP TABLE IF EXISTS `activity_in_game_config`;
CREATE TABLE `activity_in_game_config` (
  `activity_type` int(255) NOT NULL COMMENT '活动类型',
  `activity_name` varchar(50) DEFAULT NULL COMMENT '活动名称',
  `serial_id` int(11) NOT NULL COMMENT '活动期数',
  `area_server_ids` text NOT NULL COMMENT '区服',
  `start_time` int(11) NOT NULL COMMENT '开始时间，时间戳',
  `end_time` int(11) NOT NULL COMMENT '结束时间，时间戳',
  `game_id` varchar(50) NOT NULL COMMENT '游戏id',
  `create_by` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `last_update_by` varchar(50) DEFAULT NULL,
  `last_updated_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`activity_type`,`serial_id`,`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for activity1
-- ----------------------------
DROP TABLE IF EXISTS `activity1`;
CREATE TABLE `activity1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(64) NOT NULL COMMENT '游戏业务id',
  `name` varchar(255) NOT NULL COMMENT '兑换码活动名',
  `code` varchar(50) NOT NULL COMMENT '兑换码',
  `start_time` datetime NOT NULL COMMENT '兑换活动开始时间',
  `end_time` datetime NOT NULL COMMENT '兑换活动结束时间',
  `min_level` int(11) DEFAULT NULL COMMENT '最小角色等级',
  `max_level` int(11) DEFAULT NULL COMMENT '最大角色等级',
  `server_ids` varchar(512) DEFAULT NULL COMMENT '区服',
  `channels` longtext COMMENT '渠道',
  `gifts` text NOT NULL COMMENT '礼包',
  `create_by` varchar(64) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `last_update_by` varchar(30) DEFAULT NULL,
  `last_updated_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(4) DEFAULT '0' COMMENT '是否删除，默认不删除， 0：不删除，1：删除',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注说明',
  `total_num` int(11) DEFAULT '0' COMMENT '限制兑换次数',
  `used_num` int(11) DEFAULT '0' COMMENT '已使用次数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_ac1_gameid` (`game_id`,`code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1145 DEFAULT CHARSET=utf8 COMMENT='兑换码活动（一码多用）';

-- ----------------------------
-- Table structure for activity1_log
-- ----------------------------
DROP TABLE IF EXISTS `activity1_log`;
CREATE TABLE `activity1_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL COMMENT '兑换码',
  `game_id` varchar(64) NOT NULL COMMENT '游戏业务id',
  `activity_id` int(20) NOT NULL COMMENT '活动id',
  `server_id` varchar(20) DEFAULT NULL COMMENT '兑换区服',
  `role_id` varchar(20) NOT NULL COMMENT '角色id',
  `role_name` varchar(128) CHARACTER SET utf8mb4 DEFAULT NULL,
  `role_level` varchar(12) DEFAULT NULL COMMENT '兑换角色等级',
  `channel` varchar(32) DEFAULT NULL COMMENT '兑换渠道',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_aclog1` (`game_id`,`activity_id`,`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=88942 DEFAULT CHARSET=utf8 COMMENT='兑换码兑换记录（一码多用）';

-- ----------------------------
-- Table structure for after_login_notice
-- ----------------------------
DROP TABLE IF EXISTS `after_login_notice`;
CREATE TABLE `after_login_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(30) NOT NULL,
  `area_server` text NOT NULL,
  `start_time` int(11) NOT NULL,
  `end_time` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `flag` varchar(20) DEFAULT NULL,
  `content` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `run_status` int(11) NOT NULL DEFAULT '0',
  `create_by` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `last_update_by` varchar(255) DEFAULT NULL,
  `last_updated_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0',
  `update_flag` tinyint(1) DEFAULT '0',
  `sort` int(11) NOT NULL,
  `ext_attrs` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for after_login_notice_send_log
-- ----------------------------
DROP TABLE IF EXISTS `after_login_notice_send_log`;
CREATE TABLE `after_login_notice_send_log` (
  `game_id` varchar(50) NOT NULL,
  `url` varchar(255) NOT NULL,
  `params` text,
  `response_body` text,
  `successful` tinyint(4) NOT NULL,
  `error_info` text,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for after_login_notice_send_log2
-- ----------------------------
DROP TABLE IF EXISTS `after_login_notice_send_log2`;
CREATE TABLE `after_login_notice_send_log2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(50) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `params` text,
  `response_body` text,
  `successful` tinyint(4) NOT NULL,
  `error_info` text,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for after_login_notice2
-- ----------------------------
DROP TABLE IF EXISTS `after_login_notice2`;
CREATE TABLE `after_login_notice2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(30) NOT NULL,
  `start_time` datetime NOT NULL,
  `content` text NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `last_update_by` varchar(255) DEFAULT NULL,
  `last_updated_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0',
  `ext_attrs` text,
  `status` int(255) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for area_server
-- ----------------------------
DROP TABLE IF EXISTS `area_server`;
CREATE TABLE `area_server` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `group_id` int(11) DEFAULT NULL,
  `group_name` varchar(255) DEFAULT NULL,
  `origin_id` int(11) NOT NULL,
  `game_id` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for area_server_test
-- ----------------------------
DROP TABLE IF EXISTS `area_server_test`;
CREATE TABLE `area_server_test` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `origin_id` int(11) NOT NULL,
  `game_id` varchar(64) NOT NULL,
  KEY `idx_area_server_test_id_groupid` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='测试环境区服列表';

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `tags` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auto_ban_talk_log
-- ----------------------------
DROP TABLE IF EXISTS `auto_ban_talk_log`;
CREATE TABLE `auto_ban_talk_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_id` int(11) DEFAULT NULL,
  `channel` varchar(50) DEFAULT NULL,
  `role_id` varchar(50) DEFAULT NULL,
  `role_name` varchar(128) CHARACTER SET utf8mb4 DEFAULT NULL,
  `role_level` int(11) DEFAULT NULL,
  `content` text,
  `sensitive_word` varchar(255) DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `game_id` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for batch_mail
-- ----------------------------
DROP TABLE IF EXISTS `batch_mail`;
CREATE TABLE `batch_mail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `excel_file_name` varchar(255) NOT NULL,
  `create_by` varchar(50) DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `game_id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for batch_mail_send_log
-- ----------------------------
DROP TABLE IF EXISTS `batch_mail_send_log`;
CREATE TABLE `batch_mail_send_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(50) NOT NULL,
  `mail_id` int(11) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `params` text,
  `response_body` text,
  `successful` tinyint(4) NOT NULL,
  `error_info` text,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for before_login_notice
-- ----------------------------
DROP TABLE IF EXISTS `before_login_notice`;
CREATE TABLE `before_login_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(30) NOT NULL,
  `area_server` text NOT NULL,
  `start_time` int(11) NOT NULL,
  `end_time` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` text NOT NULL,
  `sign` varchar(50) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `run_status` int(11) NOT NULL DEFAULT '0',
  `create_by` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `last_update_by` varchar(255) DEFAULT NULL,
  `last_updated_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0',
  `update_flag` tinyint(1) DEFAULT '0',
  `ext_attrs` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for before_login_notice_send_log
-- ----------------------------
DROP TABLE IF EXISTS `before_login_notice_send_log`;
CREATE TABLE `before_login_notice_send_log` (
  `game_id` varchar(50) NOT NULL,
  `params` text,
  `successful` tinyint(4) NOT NULL,
  `error_info` text,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for before_login_notice_send_log2
-- ----------------------------
DROP TABLE IF EXISTS `before_login_notice_send_log2`;
CREATE TABLE `before_login_notice_send_log2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(50) NOT NULL,
  `params` text,
  `successful` tinyint(4) NOT NULL,
  `error_info` text,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for before_login_notice2
-- ----------------------------
DROP TABLE IF EXISTS `before_login_notice2`;
CREATE TABLE `before_login_notice2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(30) NOT NULL,
  `start_time` datetime NOT NULL,
  `content` text NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `last_update_by` varchar(255) DEFAULT NULL,
  `last_updated_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0',
  `ext_attrs` text,
  `status` int(255) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cash_activity
-- ----------------------------
DROP TABLE IF EXISTS `cash_activity`;
CREATE TABLE `cash_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '活动ID，也就是五行天的活动序列号',
  `game_id` varchar(64) NOT NULL,
  `activity_type` int(11) DEFAULT NULL COMMENT '活动类型， 活动ID ',
  `activity_name` varchar(255) DEFAULT NULL COMMENT '活动名称',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `show_time` datetime DEFAULT NULL COMMENT '显示时间',
  `tab` varchar(255) DEFAULT NULL COMMENT '活动标签',
  `order` int(11) DEFAULT NULL COMMENT '活动顺序',
  `mark` varchar(255) DEFAULT NULL COMMENT '活动角标',
  `limit_channel` varchar(5000) DEFAULT NULL COMMENT '限制渠道列表',
  `open_serv_act_begin_day` int(11) DEFAULT NULL COMMENT '开服活动-开始天数',
  `open_serv_act_end_day` int(11) DEFAULT NULL COMMENT '开服活动-结束天数',
  `area_server_ids` varchar(255) DEFAULT NULL COMMENT '活动区服列表',
  `group_area_server_ids` varchar(255) DEFAULT NULL COMMENT '分组区服列表，用户前端勾选展示时用',
  `remark` varchar(512) DEFAULT NULL COMMENT '活动说明',
  `is_open` int(11) DEFAULT NULL COMMENT '是否开启活动，0：未开启， 1：开启',
  `is_delete` int(11) DEFAULT '0' COMMENT '是否 删除，0：未删除，1：删除了，默认为0',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10025 DEFAULT CHARSET=utf8 COMMENT='五行天返现/领工资活动';

-- ----------------------------
-- Table structure for cash_activity_load_log
-- ----------------------------
DROP TABLE IF EXISTS `cash_activity_load_log`;
CREATE TABLE `cash_activity_load_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(64) NOT NULL COMMENT '游戏Id',
  `activity_id` int(11) DEFAULT NULL COMMENT '活动id',
  `activity_name` varchar(255) DEFAULT NULL COMMENT '活动名称',
  `area_server_ids` varchar(255) DEFAULT NULL COMMENT '区服列表',
  `url` varchar(255) DEFAULT NULL COMMENT '加载活动请求的url',
  `params` text COMMENT '加载活动的数据',
  `response_body` text COMMENT '加载活动返回的数据',
  `successful` tinyint(4) DEFAULT NULL COMMENT '是否加载成功，0: 加载失败，1：成功',
  `error_info` text COMMENT '错误信息',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_aclog_ctime` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=366 DEFAULT CHARSET=utf8 COMMENT='充值返现/领工资活动加载日志';

-- ----------------------------
-- Table structure for cash_redeem_code
-- ----------------------------
DROP TABLE IF EXISTS `cash_redeem_code`;
CREATE TABLE `cash_redeem_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL COMMENT '兑换码',
  `game_id` varchar(64) NOT NULL COMMENT '游戏业务id',
  `activity_id` int(20) NOT NULL COMMENT '活动id',
  `used` tinyint(32) DEFAULT '0' COMMENT '是否使用，1：是，0：否',
  `send_status` int(11) DEFAULT '0' COMMENT '邮件是否发出，默认0，0：未发出，1：已发出，2：发送失败',
  `used_time` datetime DEFAULT NULL COMMENT '兑换时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_rcm_code` (`code`,`game_id`) USING BTREE,
  KEY `idx_rcm_acid` (`activity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=247 DEFAULT CHARSET=utf8 COMMENT='手动导入的兑换码';

-- ----------------------------
-- Table structure for cash_redeem_log
-- ----------------------------
DROP TABLE IF EXISTS `cash_redeem_log`;
CREATE TABLE `cash_redeem_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL COMMENT '兑换码',
  `game_id` varchar(64) NOT NULL COMMENT '游戏业务id',
  `activity_id` int(20) NOT NULL COMMENT '活动id',
  `activity_type` varchar(12) DEFAULT NULL COMMENT '充值30返15=1，天天领工资=2，充值98返49=3，充值198返99=4，充值328返164=5，充值648返324=6',
  `user_id` varchar(32) DEFAULT NULL COMMENT '兑换账户',
  `user_name` varchar(64) DEFAULT NULL COMMENT '兑换账户名',
  `role_id` varchar(20) DEFAULT NULL COMMENT '角色id',
  `role_name` varchar(128) CHARACTER SET utf8mb4 DEFAULT NULL,
  `role_level` varchar(12) DEFAULT NULL COMMENT '兑换角色',
  `day_num` int(11) DEFAULT NULL COMMENT '活动天数，五行天用',
  `server_id` varchar(20) DEFAULT NULL COMMENT '兑换区服',
  `channel` varchar(32) DEFAULT NULL COMMENT '兑换渠道',
  `used_time` datetime DEFAULT NULL COMMENT '兑换时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`),
  KEY `idx_rm_log_roleid` (`role_id`),
  KEY `idx_rm_log_acid` (`activity_id`),
  KEY `idx_rm_log_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='手动导入的兑换码的获取记录';

-- ----------------------------
-- Table structure for casual_game_channel
-- ----------------------------
DROP TABLE IF EXISTS `casual_game_channel`;
CREATE TABLE `casual_game_channel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` varchar(50) NOT NULL,
  `channel_name` varchar(50) NOT NULL,
  `game_id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for casual_game_notice
-- ----------------------------
DROP TABLE IF EXISTS `casual_game_notice`;
CREATE TABLE `casual_game_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(50) NOT NULL,
  `area_server_ids` text,
  `notice_type` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `start_time` int(11) NOT NULL,
  `end_time` int(11) NOT NULL,
  `goto_type` int(11) DEFAULT NULL,
  `goto_value` varchar(255) DEFAULT NULL,
  `channel` text,
  `version` text,
  `area` text,
  `img_url` varchar(255) DEFAULT NULL,
  `ext_attrs` text,
  `deleted` tinyint(4) DEFAULT '0',
  `create_by` varchar(50) NOT NULL,
  `created_date` datetime DEFAULT NULL,
  `last_update_by` varchar(50) DEFAULT NULL,
  `last_updated_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for casual_game_version
-- ----------------------------
DROP TABLE IF EXISTS `casual_game_version`;
CREATE TABLE `casual_game_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `game_id` varchar(50) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for channel_config
-- ----------------------------
DROP TABLE IF EXISTS `channel_config`;
CREATE TABLE `channel_config` (
  `channel_id` varchar(50) NOT NULL,
  `channel_name` varchar(255) DEFAULT NULL,
  `type_name` varchar(255) DEFAULT NULL,
  `ban_recharge` tinyint(4) DEFAULT '0',
  `ban_login` tinyint(4) DEFAULT '0',
  `create_by` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `last_update_by` varchar(50) DEFAULT NULL,
  `last_updated_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `game_id` varchar(50) NOT NULL,
  `ext_attrs` text,
  PRIMARY KEY (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for channel_local
-- ----------------------------
DROP TABLE IF EXISTS `channel_local`;
CREATE TABLE `channel_local` (
  `name` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for chat_record
-- ----------------------------
DROP TABLE IF EXISTS `chat_record`;
CREATE TABLE `chat_record` (
  `game_id` varchar(30) NOT NULL,
  `server_id` int(11) DEFAULT NULL COMMENT '区服ID',
  `channel` int(11) DEFAULT NULL COMMENT '聊天频道',
  `role_id` varchar(32) DEFAULT NULL COMMENT '角色ID',
  `role_name` varchar(50) DEFAULT NULL COMMENT '角色名',
  `level` int(11) DEFAULT NULL COMMENT '角色等级',
  `recharge_amount` double DEFAULT NULL COMMENT '充值总金额',
  `content` text NOT NULL COMMENT '聊天内容',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for chat_tip_off
-- ----------------------------
DROP TABLE IF EXISTS `chat_tip_off`;
CREATE TABLE `chat_tip_off` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_id` int(11) NOT NULL COMMENT '区服ID',
  `criminal_id` varchar(50) NOT NULL COMMENT '被举报人ID',
  `criminal_name` varchar(50) DEFAULT NULL COMMENT '被举报人名称',
  `criminal_level` int(11) DEFAULT NULL COMMENT '被举报人等级',
  `criminal_pay_num` int(11) DEFAULT NULL COMMENT '被举报人总充值',
  `content` varchar(255) NOT NULL COMMENT '举报内容',
  `informant_id` varchar(50) NOT NULL COMMENT '举报人ID',
  `informant_name` varchar(50) DEFAULT NULL COMMENT '举报人名称',
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '举报时间',
  `status` int(11) DEFAULT '0' COMMENT '状态，0未处理，1已处理',
  `game_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cm_activity
-- ----------------------------
DROP TABLE IF EXISTS `cm_activity`;
CREATE TABLE `cm_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '活动ID',
  `game_id` varchar(64) NOT NULL COMMENT '游戏ID',
  `activity_name` varchar(255) DEFAULT NULL COMMENT '活动名称',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `show_time` datetime DEFAULT NULL COMMENT '显示时间',
  `tab` varchar(255) DEFAULT NULL COMMENT '活动标签',
  `order` int(11) DEFAULT NULL COMMENT '活动顺序',
  `activity_type` int(11) DEFAULT NULL COMMENT '活动类型（每日、开服）， 1：每日， 2：开服',
  `activity_days` int(11) DEFAULT NULL COMMENT '活动天数，只针对开服活动',
  `mark` varchar(255) DEFAULT NULL COMMENT '活动角标',
  `limit_channel` varchar(5000) DEFAULT NULL COMMENT '限制渠道列表',
  `open_serv_act_begin_day` int(11) DEFAULT NULL COMMENT '开服活动-开始天数',
  `open_serv_act_end_day` int(11) DEFAULT NULL COMMENT '开服活动-结束天数',
  `area_server_ids` varchar(5000) DEFAULT NULL COMMENT '活动区服列表',
  `group_area_server_ids` varchar(5000) DEFAULT NULL COMMENT '分组区服列表，用户前端勾选展示时用',
  `note1` varchar(512) DEFAULT NULL COMMENT '活动说明1',
  `note2` varchar(512) DEFAULT NULL COMMENT '活动说明2',
  `is_open` int(11) DEFAULT NULL COMMENT '是否开启活动，0：未开启， 1：开启',
  `is_delete` int(11) DEFAULT '0' COMMENT '是否 删除，0：未删除，1：删除了，默认为0',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1373 DEFAULT CHARSET=utf8 COMMENT='活动';

-- ----------------------------
-- Table structure for cm_activity_load_log
-- ----------------------------
DROP TABLE IF EXISTS `cm_activity_load_log`;
CREATE TABLE `cm_activity_load_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(64) NOT NULL,
  `activity_id` int(11) DEFAULT NULL COMMENT '活动id',
  `activity_name` varchar(255) DEFAULT NULL COMMENT '活动名称',
  `area_server_ids` varchar(255) DEFAULT NULL COMMENT '区服列表',
  `url` varchar(255) DEFAULT NULL COMMENT '加载活动请求的url',
  `params` text COMMENT '加载活动的数据',
  `response_body` text COMMENT '加载活动返回的数据',
  `successful` tinyint(4) DEFAULT NULL COMMENT '是否加载成功，0: 加载失败，1：成功',
  `error_info` text COMMENT '错误信息',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_aclog_ctime` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8 COMMENT='活动加载日志';

-- ----------------------------
-- Table structure for cm_sub_activity
-- ----------------------------
DROP TABLE IF EXISTS `cm_sub_activity`;
CREATE TABLE `cm_sub_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '子活动ID',
  `game_id` varchar(64) NOT NULL,
  `sub_activity_name` varchar(255) DEFAULT NULL COMMENT '活动名称',
  `sub_activity_type` int(11) DEFAULT NULL COMMENT '子活动类型',
  `activity_id` int(11) DEFAULT NULL COMMENT '关联的母活动ID',
  `order` int(11) DEFAULT NULL COMMENT '活动顺序',
  `desc` varchar(512) DEFAULT NULL COMMENT '活动说明',
  `awards` varchar(512) DEFAULT NULL COMMENT '奖励数组 结构体为邮件附件类型',
  `button` varchar(255) DEFAULT NULL COMMENT '按钮类型',
  `skip` varchar(255) DEFAULT NULL COMMENT '跳转界面',
  `award_times` int(11) DEFAULT NULL COMMENT '奖励次数',
  `bind_award` int(11) DEFAULT NULL COMMENT '奖励是否绑定， 0：不绑定，1：绑定',
  `is_hide` int(11) DEFAULT NULL COMMENT '是否显示 - 邮件领奖类新增',
  `server_award_times` int(11) DEFAULT NULL COMMENT '全服领奖次数 默认不填或0',
  `cost_diamond` int(11) DEFAULT NULL COMMENT '通用条件-消耗元宝',
  `cost_diamond_type` int(11) DEFAULT NULL COMMENT '消耗元宝类型 0-绑定 1-非绑定',
  `cost_coin` int(11) DEFAULT NULL COMMENT '通用条件-消耗金币',
  `cost_item` varchar(512) DEFAULT NULL COMMENT '通用条件-消耗道具 结构体为邮件附件类型',
  `above_vip_lev` int(11) DEFAULT NULL COMMENT '通用条件-VIP等级',
  `above_liveness` int(11) DEFAULT NULL COMMENT '通用条件-活力值',
  `above_charm` int(11) DEFAULT NULL COMMENT '通用条件-魅力值',
  `above_level` int(11) DEFAULT NULL COMMENT '通用条件-角色等级',
  `afk_day` int(11) DEFAULT NULL COMMENT '通用条件-流失天数',
  `above_fight_power` int(11) DEFAULT NULL COMMENT '通用条件-角色总战力',
  `above_week_charm` int(11) DEFAULT NULL COMMENT '通用条件-排行榜魅力值',
  `above_honor_lev` int(11) DEFAULT NULL COMMENT '通用条件-军衔等级',
  `need_faction_pos` int(11) DEFAULT NULL COMMENT '通用条件-系统属性类型',
  `module_prop_type` int(11) DEFAULT NULL COMMENT '通用条件-系统属性类型',
  `module_prop_need_value` int(11) DEFAULT NULL COMMENT '通用 条件-系统属性条件值',
  `module_prop_need_num` int(11) DEFAULT NULL COMMENT '通用条件-系统满足条件个数',
  `special_params` varchar(1024) DEFAULT NULL COMMENT '所有个性化参数',
  `is_delete` int(11) DEFAULT '0' COMMENT '是否 删除，0：未删除，1：删除了，默认为0',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5118 DEFAULT CHARSET=utf8 COMMENT='五行天子活动';

-- ----------------------------
-- Table structure for cm_sub_activity_button
-- ----------------------------
DROP TABLE IF EXISTS `cm_sub_activity_button`;
CREATE TABLE `cm_sub_activity_button` (
  `id` int(11) NOT NULL COMMENT '按钮id',
  `game_id` varchar(64) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '按钮名',
  PRIMARY KEY (`id`,`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='子活动按钮';

-- ----------------------------
-- Table structure for cm_sub_activity_module_prop_type
-- ----------------------------
DROP TABLE IF EXISTS `cm_sub_activity_module_prop_type`;
CREATE TABLE `cm_sub_activity_module_prop_type` (
  `id` int(11) NOT NULL COMMENT '系统模块属性类型',
  `game_id` varchar(64) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '系统模块属性类型名',
  PRIMARY KEY (`id`,`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通用调条件--系统模块属性类型\r\n';

-- ----------------------------
-- Table structure for cm_sub_activity_monster
-- ----------------------------
DROP TABLE IF EXISTS `cm_sub_activity_monster`;
CREATE TABLE `cm_sub_activity_monster` (
  `id` int(11) NOT NULL COMMENT '怪物id',
  `game_id` varchar(64) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '怪物',
  PRIMARY KEY (`id`,`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cm_sub_activity_rank_guild
-- ----------------------------
DROP TABLE IF EXISTS `cm_sub_activity_rank_guild`;
CREATE TABLE `cm_sub_activity_rank_guild` (
  `id` int(11) NOT NULL COMMENT '帮派id',
  `game_id` varchar(64) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '帮派名称',
  PRIMARY KEY (`id`,`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='排行榜类型子活动的排行榜类型为帮派时需要的帮派身份';

-- ----------------------------
-- Table structure for cm_sub_activity_rank_type
-- ----------------------------
DROP TABLE IF EXISTS `cm_sub_activity_rank_type`;
CREATE TABLE `cm_sub_activity_rank_type` (
  `id` int(11) NOT NULL COMMENT '排行榜类型id',
  `game_id` varchar(64) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '排行榜名称',
  PRIMARY KEY (`id`,`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='排行榜类型子活动的排行榜类型';

-- ----------------------------
-- Table structure for cm_sub_activity_task
-- ----------------------------
DROP TABLE IF EXISTS `cm_sub_activity_task`;
CREATE TABLE `cm_sub_activity_task` (
  `id` int(11) NOT NULL COMMENT '任务id',
  `game_id` varchar(64) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '任务名称',
  PRIMARY KEY (`id`,`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='需要行为，用于每日任务类型的活动';

-- ----------------------------
-- Table structure for cm_sub_activity_task_play
-- ----------------------------
DROP TABLE IF EXISTS `cm_sub_activity_task_play`;
CREATE TABLE `cm_sub_activity_task_play` (
  `id` int(11) NOT NULL COMMENT '玩法id',
  `game_id` varchar(64) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '玩法名',
  `status` int(11) DEFAULT '1' COMMENT '是否开启， 1:开启， 0:不启用',
  PRIMARY KEY (`id`,`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='每日活动需要行为对应玩法';

-- ----------------------------
-- Table structure for cm_sub_activity_type
-- ----------------------------
DROP TABLE IF EXISTS `cm_sub_activity_type`;
CREATE TABLE `cm_sub_activity_type` (
  `id` int(11) NOT NULL,
  `game_id` varchar(64) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`,`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for first_recharge_double
-- ----------------------------
DROP TABLE IF EXISTS `first_recharge_double`;
CREATE TABLE `first_recharge_double` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_area_server_ids` text COMMENT '分组区服id',
  `server_ids` text NOT NULL,
  `reset_time` datetime NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(11) DEFAULT '0' COMMENT '0:等待中,1:进行中,2:终止中,7:过期,8:终止,9:完成',
  `run_status` int(11) DEFAULT '0' COMMENT '0:正常，1:异常',
  `deleted` tinyint(4) DEFAULT '0',
  `game_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COMMENT='首充双倍重置';

-- ----------------------------
-- Table structure for first_recharge_double_send_log
-- ----------------------------
DROP TABLE IF EXISTS `first_recharge_double_send_log`;
CREATE TABLE `first_recharge_double_send_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fid` int(11) NOT NULL,
  `game_id` varchar(64) DEFAULT NULL,
  `server_ids` text,
  `url` varchar(255) DEFAULT NULL,
  `params` text,
  `response_body` text,
  `successful` tinyint(4) DEFAULT NULL,
  `error_info` text,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for force_update_config
-- ----------------------------
DROP TABLE IF EXISTS `force_update_config`;
CREATE TABLE `force_update_config` (
  `game_id` varchar(50) NOT NULL,
  `channel` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `tac_network` int(11) NOT NULL,
  `tac_tip` int(11) NOT NULL,
  `tac_version` int(11) NOT NULL,
  `package_url` varchar(255) NOT NULL,
  `tips` text NOT NULL,
  `create_by` varchar(50) DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`game_id`,`channel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for gift_config
-- ----------------------------
DROP TABLE IF EXISTS `gift_config`;
CREATE TABLE `gift_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(50) NOT NULL,
  `area_server_ids` text,
  `start_time` int(11) DEFAULT NULL,
  `end_time` int(11) DEFAULT NULL,
  `channel` text,
  `version` varchar(255) DEFAULT NULL,
  `area` text,
  `gift_id` int(11) NOT NULL,
  `gift_name` varchar(255) DEFAULT NULL,
  `gift_type` int(11) DEFAULT NULL,
  `attachment` text,
  `store_id` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `gift_icon` varchar(255) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `red_tip` tinyint(4) DEFAULT NULL,
  `breathe` tinyint(4) DEFAULT NULL,
  `ext_attrs` text,
  `deleted` tinyint(4) DEFAULT '0',
  `create_by` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `last_update_by` varchar(50) DEFAULT NULL,
  `last_updated_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for gm_cmd
-- ----------------------------
DROP TABLE IF EXISTS `gm_cmd`;
CREATE TABLE `gm_cmd` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `area_server_ids` text NOT NULL,
  `cmd_list` text NOT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `game_id` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `goods_id` int(11) NOT NULL COMMENT '物品id',
  `goods_name` varchar(255) NOT NULL COMMENT '物品名',
  `type_id` int(11) NOT NULL COMMENT '类型id',
  `type_name` varchar(255) NOT NULL COMMENT '类型名',
  `max_count` int(11) NOT NULL COMMENT '最大数量',
  `game_id` varchar(30) NOT NULL COMMENT '游戏id',
  PRIMARY KEY (`goods_id`,`type_id`,`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='兑换码礼包';

-- ----------------------------
-- Table structure for goods_test
-- ----------------------------
DROP TABLE IF EXISTS `goods_test`;
CREATE TABLE `goods_test` (
  `goods_id` int(11) NOT NULL COMMENT '物品id',
  `goods_name` varchar(255) NOT NULL COMMENT '物品名',
  `type_id` int(11) NOT NULL COMMENT '类型id',
  `type_name` varchar(255) NOT NULL COMMENT '类型名',
  `max_count` int(11) NOT NULL COMMENT '最大数量',
  `game_id` varchar(30) NOT NULL COMMENT '游戏id',
  PRIMARY KEY (`goods_id`,`type_id`,`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='兑换码礼包';

-- ----------------------------
-- Table structure for green_hand_sign_activity
-- ----------------------------
DROP TABLE IF EXISTS `green_hand_sign_activity`;
CREATE TABLE `green_hand_sign_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `type` tinyint(4) DEFAULT '0' COMMENT '0签到 1新手奖',
  `days` int(11) DEFAULT NULL COMMENT '新手奖励第几天',
  `start_time` int(11) NOT NULL,
  `end_time` int(11) NOT NULL,
  `reset_time` int(11) NOT NULL COMMENT '重置时间，小时整点',
  `channel` text COMMENT '渠道',
  `area_server_ids` text COMMENT '区服',
  `version` text,
  `area` text,
  `is_open` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否开启，1是 0否',
  `awards` text NOT NULL COMMENT '道具附件',
  `create_by` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `last_update_by` varchar(50) DEFAULT NULL,
  `last_updated_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `game_id` varchar(50) NOT NULL,
  `deleted` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for img_notice
-- ----------------------------
DROP TABLE IF EXISTS `img_notice`;
CREATE TABLE `img_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(30) NOT NULL,
  `area_server` text NOT NULL,
  `start_time` int(11) NOT NULL,
  `end_time` int(11) NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `img_url` text,
  `goto_page` varchar(255) DEFAULT NULL COMMENT '跳转界面',
  `status` int(11) NOT NULL DEFAULT '1',
  `run_status` int(11) NOT NULL DEFAULT '0',
  `create_by` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `last_update_by` varchar(255) DEFAULT NULL,
  `last_updated_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(255) DEFAULT '0',
  `ext_attrs` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for img_notice_goto_page
-- ----------------------------
DROP TABLE IF EXISTS `img_notice_goto_page`;
CREATE TABLE `img_notice_goto_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '显示名称',
  `value` varchar(255) NOT NULL COMMENT '链接地址',
  `game_id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for img_notice_send_log
-- ----------------------------
DROP TABLE IF EXISTS `img_notice_send_log`;
CREATE TABLE `img_notice_send_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(50) NOT NULL,
  `notice_id` int(11) NOT NULL,
  `url` varchar(255) NOT NULL,
  `params` text,
  `response_body` text,
  `successful` tinyint(4) NOT NULL,
  `error_info` text,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for login_white_list
-- ----------------------------
DROP TABLE IF EXISTS `login_white_list`;
CREATE TABLE `login_white_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `right_level` int(11) NOT NULL,
  `account` varchar(255) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `game_id` varchar(50) NOT NULL,
  `ext_attrs` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for mail
-- ----------------------------
DROP TABLE IF EXISTS `mail`;
CREATE TABLE `mail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(30) NOT NULL,
  `title` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `send_time` datetime NOT NULL,
  `validity` int(11) DEFAULT NULL,
  `attachment` text,
  `attachment_text` text,
  `sign` varchar(255) NOT NULL,
  `type` int(11) DEFAULT NULL,
  `area_server` text,
  `player_id_excel` varchar(255) DEFAULT NULL,
  `player_id_text` longtext,
  `status` int(11) NOT NULL DEFAULT '1',
  `run_status` int(11) NOT NULL DEFAULT '0',
  `create_by` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `last_update_by` varchar(255) DEFAULT NULL,
  `last_updated_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(4) DEFAULT '0',
  `reg_date` int(11) DEFAULT '0',
  `ext_attrs` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=286 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for mail_send_log
-- ----------------------------
DROP TABLE IF EXISTS `mail_send_log`;
CREATE TABLE `mail_send_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(50) NOT NULL,
  `mail_id` int(11) NOT NULL,
  `area_server_id` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `params` text,
  `response_body` text,
  `successful` tinyint(4) NOT NULL,
  `error_info` text,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1430 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for mail_stat
-- ----------------------------
DROP TABLE IF EXISTS `mail_stat`;
CREATE TABLE `mail_stat` (
  `mail_id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  `num` int(11) DEFAULT NULL,
  PRIMARY KEY (`game_id`,`mail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for maintenance_notice_send_log
-- ----------------------------
DROP TABLE IF EXISTS `maintenance_notice_send_log`;
CREATE TABLE `maintenance_notice_send_log` (
  `game_id` varchar(50) NOT NULL,
  `params` text,
  `successful` tinyint(4) NOT NULL,
  `error_info` text,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for mall_category
-- ----------------------------
DROP TABLE IF EXISTS `mall_category`;
CREATE TABLE `mall_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(64) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `config_level` int(11) DEFAULT NULL COMMENT '1表示一级菜单，2表示二级菜单，3表示商品',
  `belong_to` int(11) DEFAULT NULL COMMENT '父级菜单id',
  `belong_name` varchar(255) DEFAULT NULL COMMENT '父级菜单名',
  `money_type` int(11) DEFAULT NULL COMMENT '货币类型',
  `order` int(11) DEFAULT NULL COMMENT '菜单序号',
  `is_open` tinyint(4) DEFAULT NULL COMMENT '是否开启',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `time_start` datetime DEFAULT NULL,
  `time_end` datetime DEFAULT NULL,
  `is_delete` tinyint(4) DEFAULT '0',
  `last_load_time` datetime DEFAULT NULL COMMENT '最近加载时间',
  `last_publish_time` datetime DEFAULT NULL COMMENT '最近发布时间',
  `create_by` varchar(32) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(32) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COMMENT='商城菜单';

-- ----------------------------
-- Table structure for mall_load_log
-- ----------------------------
DROP TABLE IF EXISTS `mall_load_log`;
CREATE TABLE `mall_load_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(64) NOT NULL COMMENT '游戏Id',
  `config_level` int(11) DEFAULT NULL COMMENT '1表示一级菜单，2表示二级菜单，3表示商品',
  `fid` int(11) DEFAULT NULL COMMENT '关联表id字段，菜单或者是商品id',
  `fname` varchar(255) DEFAULT NULL COMMENT '关联表名称字段，菜单或者商品名称',
  `category_id` int(11) DEFAULT NULL COMMENT '一级分类id',
  `category_name` varchar(255) DEFAULT NULL COMMENT '一级分类名称',
  `server_ids` varchar(255) DEFAULT NULL COMMENT '区服列表',
  `url` varchar(255) DEFAULT NULL COMMENT '请求的url',
  `params` text COMMENT '参数',
  `response_body` text COMMENT '返回的数据',
  `successful` tinyint(4) DEFAULT NULL COMMENT '是否成功，0: 加载失败，1：成功',
  `error_info` text COMMENT '错误信息',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_ml_log_ctime` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=2306 DEFAULT CHARSET=utf8 COMMENT='商城加载日志';

-- ----------------------------
-- Table structure for mall_product
-- ----------------------------
DROP TABLE IF EXISTS `mall_product`;
CREATE TABLE `mall_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `game_id` varchar(64) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL COMMENT '商品名称',
  `price_cur` int(11) DEFAULT NULL COMMENT '交易价格',
  `price_ori` int(11) DEFAULT NULL COMMENT '商品原价格',
  `item_type` int(11) DEFAULT NULL COMMENT '商品类型',
  `item_id` int(11) DEFAULT NULL COMMENT '商品类型对应的物品id',
  `buy_type` int(11) DEFAULT NULL COMMENT '限购类型,0不限购，1日限购，2周限购，3永久限购',
  `buy_count` int(11) DEFAULT NULL COMMENT '限购次数',
  `server_buy_count` int(11) DEFAULT NULL COMMENT '全服限购数量:0不限购，>0表示限购数量',
  `label` int(11) DEFAULT NULL COMMENT '商品标签:3限量，4热销，5新品',
  `is_give` tinyint(2) DEFAULT NULL COMMENT '是否可以赠送',
  `is_bind` tinyint(2) DEFAULT NULL COMMENT '是否绑定',
  `job` int(11) DEFAULT NULL COMMENT '需要职业：0无限制，1落尘，2问水，3青花，4飞羽',
  `vip_level` int(11) DEFAULT NULL COMMENT '需要vip等级',
  `charm` int(11) DEFAULT NULL COMMENT '需要魅力',
  `leave_day` int(11) DEFAULT NULL COMMENT '需要流失天数',
  `fighting` int(11) DEFAULT NULL COMMENT '需要总战力',
  `honor_level` int(11) DEFAULT NULL COMMENT '需要军衔',
  `time_start` datetime DEFAULT NULL COMMENT '商品上架时间戳',
  `time_end` datetime DEFAULT NULL COMMENT '商品下架时间戳',
  `config_level` int(11) DEFAULT NULL COMMENT '1表示一级菜单，2表示二级菜单，3表示商品',
  `belong_to_first` int(11) DEFAULT NULL COMMENT '一级菜单id',
  `belong_to_first_name` varchar(255) DEFAULT NULL,
  `belong_to_second` int(11) DEFAULT NULL COMMENT '二级菜单id',
  `belong_to_second_name` varchar(255) DEFAULT NULL,
  `money_type` int(11) DEFAULT NULL COMMENT '货币类型',
  `order` int(11) DEFAULT NULL COMMENT '商品序号',
  `extra_data` json DEFAULT NULL COMMENT '扩展数据',
  `is_open` tinyint(4) DEFAULT NULL COMMENT '是否开启',
  `is_delete` tinyint(4) DEFAULT '0',
  `remark` varchar(255) DEFAULT NULL,
  `last_load_time` datetime DEFAULT NULL COMMENT '最近加载时间',
  `last_publish_time` datetime DEFAULT NULL COMMENT '最近发布时间',
  `create_by` varchar(32) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(32) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=265 DEFAULT CHARSET=utf8 COMMENT='商城商品';

-- ----------------------------
-- Table structure for mall_publish_log
-- ----------------------------
DROP TABLE IF EXISTS `mall_publish_log`;
CREATE TABLE `mall_publish_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(64) NOT NULL COMMENT '游戏Id',
  `config_level` int(11) DEFAULT NULL COMMENT '1表示一级菜单，2表示二级菜单，3表示商品',
  `server_ids` varchar(255) DEFAULT NULL COMMENT '区服列表',
  `url` varchar(255) DEFAULT NULL COMMENT '请求的url',
  `params` text COMMENT '参数',
  `response_body` text COMMENT '返回的数据',
  `successful` tinyint(4) DEFAULT NULL COMMENT '是否成功，0: 加载失败，1：成功',
  `error_info` text COMMENT '错误信息',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_mp_log_ctime` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=439 DEFAULT CHARSET=utf8 COMMENT='商城发布日志';

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(30) NOT NULL,
  `area_server` text NOT NULL,
  `type` int(11) NOT NULL,
  `play_channel` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `interval` int(11) NOT NULL,
  `interval_type` int(255) NOT NULL,
  `stay_seconds` int(255) NOT NULL,
  `content` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `run_status` int(11) NOT NULL DEFAULT '0',
  `create_by` varchar(50) NOT NULL,
  `created_date` datetime DEFAULT NULL,
  `last_update_by` varchar(255) DEFAULT NULL,
  `last_updated_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(4) DEFAULT '0',
  `ext_attrs` text COMMENT '扩展字段',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for notice_send_log
-- ----------------------------
DROP TABLE IF EXISTS `notice_send_log`;
CREATE TABLE `notice_send_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(50) NOT NULL,
  `notice_id` int(11) NOT NULL,
  `area_server_id` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `params` text,
  `response_body` text,
  `successful` tinyint(4) NOT NULL,
  `error_info` text,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=128776 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for obt
-- ----------------------------
DROP TABLE IF EXISTS `obt`;
CREATE TABLE `obt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(50) DEFAULT NULL,
  `create_by` varchar(50) DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `excel_file_name` varchar(100) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1' COMMENT '1有效 0已终止',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for obt_get_log
-- ----------------------------
DROP TABLE IF EXISTS `obt_get_log`;
CREATE TABLE `obt_get_log` (
  `obt_id` int(11) NOT NULL,
  `server_id` int(11) NOT NULL,
  `open_id` varchar(50) NOT NULL,
  `role_id` varchar(50) DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `game_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for obt_send_log
-- ----------------------------
DROP TABLE IF EXISTS `obt_send_log`;
CREATE TABLE `obt_send_log` (
  `obt_id` int(11) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `params` text,
  `response_body` text,
  `successful` tinyint(4) DEFAULT NULL,
  `error_info` text,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `game_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for promoter
-- ----------------------------
DROP TABLE IF EXISTS `promoter`;
CREATE TABLE `promoter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '标识',
  `status` tinyint(4) NOT NULL COMMENT '状态1开启，0关闭',
  `start_time` datetime NOT NULL COMMENT '有效开始时间',
  `end_time` datetime NOT NULL COMMENT '有效结束时间',
  `card_no` varchar(20) NOT NULL COMMENT '卡号',
  `alipay_id` varchar(50) NOT NULL COMMENT '支付宝账号',
  `alipay_name` varchar(50) NOT NULL COMMENT '支付宝名称',
  `create_by` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `game_id` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_promoter` (`card_no`,`game_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='推广员';

-- ----------------------------
-- Table structure for promoter_bind_record
-- ----------------------------
DROP TABLE IF EXISTS `promoter_bind_record`;
CREATE TABLE `promoter_bind_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(20) NOT NULL,
  `card_no` varchar(20) NOT NULL COMMENT '绑定的卡号',
  `promoter_name` varchar(64) DEFAULT NULL COMMENT '绑定的推广员',
  `open_id` varchar(64) DEFAULT NULL COMMENT '绑定账号id',
  `role_id` varchar(50) NOT NULL COMMENT '绑定角色ID',
  `role_name` varchar(50) DEFAULT NULL COMMENT '绑定角色名',
  `server_id` int(11) NOT NULL COMMENT '区服ID',
  `channel` varchar(50) DEFAULT NULL COMMENT '渠道',
  `first_bind` int(11) DEFAULT '0' COMMENT '是否第一次绑定,1：是，0：不是',
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '绑定时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='绑定记录';

-- ----------------------------
-- Table structure for promoter_channel
-- ----------------------------
DROP TABLE IF EXISTS `promoter_channel`;
CREATE TABLE `promoter_channel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` varchar(30) NOT NULL COMMENT '渠道ID',
  `channel_name` varchar(50) DEFAULT NULL COMMENT '渠道名称',
  `status` tinyint(4) NOT NULL COMMENT '状态1开启，0关闭',
  `create_by` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `game_id` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_promoter_channel` (`channel_id`,`game_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='推广渠道开关';

-- ----------------------------
-- Table structure for promoter_job
-- ----------------------------
DROP TABLE IF EXISTS `promoter_job`;
CREATE TABLE `promoter_job` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(20) NOT NULL COMMENT '游戏id',
  `sched_name` varchar(120) NOT NULL,
  `job_name` varchar(200) NOT NULL,
  `job_group` varchar(200) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `job_class_name` varchar(255) DEFAULT NULL,
  `next_settle_start_time` datetime DEFAULT NULL COMMENT '下次结算开始时间',
  `next_settle_end_time` datetime NOT NULL COMMENT '下次结算结束时间',
  `start_time` datetime NOT NULL COMMENT '任务开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '任务终止时间',
  `repeat_count` int(7) DEFAULT NULL,
  `repeat_interval` int(12) NOT NULL COMMENT '重复间隔，单位秒',
  `times_triggered` int(10) DEFAULT NULL,
  `status` int(11) DEFAULT '1' COMMENT '状态 0：未启用，1：启用',
  `load_status` int(11) DEFAULT '0' COMMENT '加载状态， 0：未加载，1：加载。 添加或修改job后设为0，等等重新加载',
  `description` varchar(250) DEFAULT NULL COMMENT '描述',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_schedname_jobkey` (`sched_name`,`job_name`,`job_group`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='任务触发器';

-- ----------------------------
-- Table structure for promoter_pay
-- ----------------------------
DROP TABLE IF EXISTS `promoter_pay`;
CREATE TABLE `promoter_pay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `card_no` varchar(20) NOT NULL COMMENT '卡号',
  `promoter_name` varchar(50) DEFAULT NULL COMMENT '标识',
  `pay_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '结算时间',
  `start_time` datetime NOT NULL COMMENT '结算时间段，开始时间',
  `end_time` datetime NOT NULL COMMENT '结算时间段，结束时间',
  `amount` decimal(10,2) NOT NULL COMMENT '结算金额',
  `alipay_id` varchar(50) DEFAULT NULL COMMENT '支付宝账号',
  `alipay_name` varchar(50) DEFAULT NULL COMMENT '支付宝名称',
  `pay_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '支付状态0未支付，1已支付',
  `game_id` varchar(20) NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='结算记录';

-- ----------------------------
-- Table structure for promoter_player_bind
-- ----------------------------
DROP TABLE IF EXISTS `promoter_player_bind`;
CREATE TABLE `promoter_player_bind` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(20) NOT NULL,
  `role_id` varchar(50) NOT NULL COMMENT '绑定角色ID',
  `role_name` varchar(50) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '绑定角色名',
  `promoter_name` varchar(64) DEFAULT NULL COMMENT '绑定的推广员',
  `card_no` varchar(20) NOT NULL COMMENT '卡号',
  `last_card_no` varchar(20) DEFAULT NULL COMMENT '前一次绑定卡号',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_gid_roleid` (`game_id`,`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COMMENT='玩家当前绑定的推广码';

-- ----------------------------
-- Table structure for promoter_player_bind_snap
-- ----------------------------
DROP TABLE IF EXISTS `promoter_player_bind_snap`;
CREATE TABLE `promoter_player_bind_snap` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(20) NOT NULL,
  `role_id` varchar(50) NOT NULL COMMENT '绑定角色ID',
  `role_name` varchar(50) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '绑定角色名',
  `promoter_name` varchar(64) DEFAULT NULL COMMENT '绑定的推广员',
  `card_no` varchar(20) NOT NULL COMMENT '卡号',
  `snap_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '绑定状态的快照时间点',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_snaptime_roleid` (`game_id`,`snap_time`,`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4039 DEFAULT CHARSET=utf8 COMMENT='玩家绑定的推广码的快照';

-- ----------------------------
-- Table structure for promoter_recharge
-- ----------------------------
DROP TABLE IF EXISTS `promoter_recharge`;
CREATE TABLE `promoter_recharge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `card_no` varchar(20) NOT NULL,
  `promoter_name` varchar(50) DEFAULT NULL,
  `role_id` varchar(50) NOT NULL,
  `role_name` varchar(128) CHARACTER SET utf8mb4 DEFAULT NULL,
  `server_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `pay_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '结算状态 0未结算，1已结算',
  `game_id` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='充值记录';

-- ----------------------------
-- Table structure for promoter_user
-- ----------------------------
DROP TABLE IF EXISTS `promoter_user`;
CREATE TABLE `promoter_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  `nick_name` varchar(20) NOT NULL,
  `password` varchar(32) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `game_id` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for promoter_user_login_log
-- ----------------------------
DROP TABLE IF EXISTS `promoter_user_login_log`;
CREATE TABLE `promoter_user_login_log` (
  `user_name` varchar(20) NOT NULL,
  `login_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for QRTZ_BLOB_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `SCHED_NAME` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for QRTZ_CALENDARS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for QRTZ_CRON_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(120) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for QRTZ_FIRED_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(200) DEFAULT NULL,
  `JOB_GROUP` varchar(200) DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`),
  KEY `IDX_QRTZ_FT_TRIG_INST_NAME` (`SCHED_NAME`,`INSTANCE_NAME`),
  KEY `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY` (`SCHED_NAME`,`INSTANCE_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_FT_J_G` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_T_G` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_FT_TG` (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for QRTZ_JOB_DETAILS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_NONCONCURRENT` varchar(1) NOT NULL,
  `IS_UPDATE_DATA` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` longblob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_J_REQ_RECOVERY` (`SCHED_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_J_GRP` (`SCHED_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for QRTZ_LOCKS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for QRTZ_SCHEDULER_STATE
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `STR_PROP_1` varchar(512) DEFAULT NULL,
  `STR_PROP_2` varchar(512) DEFAULT NULL,
  `STR_PROP_3` varchar(512) DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for QRTZ_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_J` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_C` (`SCHED_NAME`,`CALENDAR_NAME`),
  KEY `IDX_QRTZ_T_G` (`SCHED_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_STATE` (`SCHED_NAME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_STATE` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_G_STATE` (`SCHED_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NEXT_FIRE_TIME` (`SCHED_NAME`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST` (`SCHED_NAME`,`TRIGGER_STATE`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `QRTZ_JOB_DETAILS` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rank_system
-- ----------------------------
DROP TABLE IF EXISTS `rank_system`;
CREATE TABLE `rank_system` (
  `id` int(11) NOT NULL COMMENT '玩法id',
  `name` varchar(255) NOT NULL COMMENT '玩法名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='每日活动需要行为对应玩法';

-- ----------------------------
-- Table structure for ranking_list
-- ----------------------------
DROP TABLE IF EXISTS `ranking_list`;
CREATE TABLE `ranking_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `start_time` int(11) NOT NULL,
  `end_time` int(11) NOT NULL,
  `area_server_ids` text,
  `channel` text,
  `version` text,
  `area` text,
  `rank_type` int(11) NOT NULL,
  `rank_limit` int(11) NOT NULL,
  `rank_level_limit` int(11) NOT NULL,
  `rank_view_cnt` int(11) NOT NULL,
  `rank_view_rule` int(11) NOT NULL,
  `rank_settle_type` int(11) NOT NULL,
  `rank_settle_method` int(11) DEFAULT NULL,
  `rank_settle_week` int(11) DEFAULT NULL,
  `rank_settle_time` int(11) DEFAULT NULL,
  `rank_award_rule` text,
  `attachment` text,
  `ext_attrs` text,
  `deleted` tinyint(4) DEFAULT '0',
  `create_by` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `last_update_by` varchar(50) DEFAULT NULL,
  `last_updated_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ranking_list_type
-- ----------------------------
DROP TABLE IF EXISTS `ranking_list_type`;
CREATE TABLE `ranking_list_type` (
  `game_id` varchar(50) NOT NULL,
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`game_id`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for redeem_code
-- ----------------------------
DROP TABLE IF EXISTS `redeem_code`;
CREATE TABLE `redeem_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL COMMENT '兑换码',
  `game_id` varchar(64) NOT NULL COMMENT '游戏业务id',
  `activity_id` int(20) NOT NULL COMMENT '活动id',
  `used` tinyint(32) DEFAULT '0' COMMENT '是否使用，1：是，0：否',
  `send_status` int(11) DEFAULT '0' COMMENT '邮件是否发出，默认0，0：未发出，1：已发出，2：发送失败',
  `used_time` datetime DEFAULT NULL COMMENT '兑换时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_rc_code` (`game_id`,`code`) USING BTREE,
  KEY `idx_rc_acid` (`activity_id`),
  KEY `idx_rc_gameid` (`game_id`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=3247989 DEFAULT CHARSET=utf8 COMMENT='兑换码';

-- ----------------------------
-- Table structure for redeem_data
-- ----------------------------
DROP TABLE IF EXISTS `redeem_data`;
CREATE TABLE `redeem_data` (
  `dtstat` date NOT NULL,
  `game_id` varchar(20) NOT NULL,
  `redeem_num` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `gen_num` int(11) DEFAULT NULL,
  `redeem_times` int(11) DEFAULT NULL,
  PRIMARY KEY (`dtstat`,`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for redeem_log
-- ----------------------------
DROP TABLE IF EXISTS `redeem_log`;
CREATE TABLE `redeem_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL COMMENT '兑换码',
  `game_id` varchar(64) NOT NULL COMMENT '游戏业务id',
  `activity_id` int(20) NOT NULL COMMENT '活动id',
  `server_id` varchar(20) DEFAULT NULL COMMENT '兑换区服',
  `user_id` varchar(32) DEFAULT NULL COMMENT '兑换账户',
  `user_name` varchar(64) DEFAULT NULL COMMENT '兑换账户名',
  `role_id` varchar(20) DEFAULT NULL COMMENT '角色id',
  `role_name` varchar(128) CHARACTER SET utf8mb4 DEFAULT NULL,
  `role_level` varchar(12) DEFAULT NULL COMMENT '兑换角色',
  `channel` varchar(32) DEFAULT NULL COMMENT '兑换渠道',
  `used_time` datetime DEFAULT NULL COMMENT '兑换时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`),
  KEY `idx_rlog_roleid` (`role_id`) USING BTREE,
  KEY `idx_rlog_acid` (`activity_id`),
  KEY `idx_rlog_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=88966 DEFAULT CHARSET=utf8 COMMENT='兑换码兑换记录';

-- ----------------------------
-- Table structure for repair_order
-- ----------------------------
DROP TABLE IF EXISTS `repair_order`;
CREATE TABLE `repair_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_id` int(11) DEFAULT NULL,
  `player_id` varchar(50) DEFAULT NULL,
  `amount_id` varchar(50) DEFAULT NULL,
  `order_id` varchar(255) DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(50) DEFAULT NULL,
  `deleted` tinyint(4) DEFAULT '0',
  `game_id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for role_ban_log
-- ----------------------------
DROP TABLE IF EXISTS `role_ban_log`;
CREATE TABLE `role_ban_log` (
  `create_by` varchar(20) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `roles` text NOT NULL,
  `ban_time` bigint(20) NOT NULL,
  `ban_reason` varchar(255) DEFAULT NULL,
  `response_body` text,
  `game_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for role_ban_talk_log
-- ----------------------------
DROP TABLE IF EXISTS `role_ban_talk_log`;
CREATE TABLE `role_ban_talk_log` (
  `create_by` varchar(20) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `role_id` text NOT NULL,
  `ban_time` bigint(20) NOT NULL,
  `ban_reason` varchar(255) DEFAULT NULL,
  `response_body` text,
  `game_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for role_offline_log
-- ----------------------------
DROP TABLE IF EXISTS `role_offline_log`;
CREATE TABLE `role_offline_log` (
  `create_by` varchar(20) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `role_id` bigint(20) NOT NULL,
  `ban_reason` varchar(255) DEFAULT NULL,
  `response_body` text,
  `game_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for server_config
-- ----------------------------
DROP TABLE IF EXISTS `server_config`;
CREATE TABLE `server_config` (
  `name` varchar(255) NOT NULL,
  `value` text,
  `remark` text,
  `game_id` varchar(50) NOT NULL,
  PRIMARY KEY (`name`,`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务器配置';

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
  `create_by` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `last_update_by` varchar(50) DEFAULT NULL,
  `last_updated_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1790 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for system_config
-- ----------------------------
DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` varchar(64) NOT NULL COMMENT '游戏业务id',
  `name` varchar(255) NOT NULL COMMENT 'key',
  `value` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_gameid_name` (`game_id`,`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=219 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for vip_mail_black_list
-- ----------------------------
DROP TABLE IF EXISTS `vip_mail_black_list`;
CREATE TABLE `vip_mail_black_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_id` int(11) NOT NULL COMMENT '区服ID',
  `role_id_or_name` varchar(50) NOT NULL COMMENT '角色ID/角色名',
  `channel` varchar(50) DEFAULT NULL COMMENT '渠道，只做查看用，不做逻辑处理',
  `game_id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for vip_mail_send_log
-- ----------------------------
DROP TABLE IF EXISTS `vip_mail_send_log`;
CREATE TABLE `vip_mail_send_log` (
  `server_id` int(11) NOT NULL COMMENT '区服ID',
  `channel_id` varchar(50) NOT NULL COMMENT '渠道ID',
  `role_id` varchar(50) NOT NULL COMMENT '角色ID',
  `role_name` varchar(50) DEFAULT NULL COMMENT '角色名',
  `vip_level` int(11) NOT NULL,
  `flag` tinyint(4) NOT NULL DEFAULT '1' COMMENT '标识，全服重置时，置为0',
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `game_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
