/*
Navicat MySQL Data Transfer

Source Server         : 本地测试192.168.141.223
Source Server Version : 50716
Source Host           : 192.168.141.223:3306
Source Database       : rainbow_v3

Target Server Type    : MYSQL
Target Server Version : 50716
File Encoding         : 65001

Date: 2018-04-19 16:08:22
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(10) NOT NULL,
  `title` varchar(128) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `product` varchar(50) NOT NULL,
  `customer_id` varchar(20) NOT NULL,
  `picturename` varchar(50) DEFAULT NULL,
  `createdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for game_rpt_tbstoregamepoints
-- ----------------------------
DROP TABLE IF EXISTS `game_rpt_tbstoregamepoints`;
CREATE TABLE `game_rpt_tbstoregamepoints` (
  `dtstatdate` date DEFAULT NULL,
  `vgameid` varchar(64) DEFAULT NULL,
  `channelid` varchar(64) DEFAULT NULL,
  `zoneid` varchar(64) DEFAULT NULL,
  `iusernum` bigint(20) DEFAULT NULL,
  `istoretimes` bigint(20) DEFAULT NULL,
  `istore` double(12,4) DEFAULT NULL,
  KEY `idx_tbstoregamepoints_id_key_chid` (`vgameid`,`zoneid`,`channelid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CONNECTION='mysql://rptgame:Game#Rpt@172.16.150.33:3306/dsky_dw_reports/game_rpt_tbStoreGamePoints';

-- ----------------------------
-- Table structure for jason_test1
-- ----------------------------
DROP TABLE IF EXISTS `jason_test1`;
CREATE TABLE `jason_test1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13537 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for page_status
-- ----------------------------
DROP TABLE IF EXISTS `page_status`;
CREATE TABLE `page_status` (
  `aid` int(11) NOT NULL,
  `page_id` int(11) NOT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`aid`,`page_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for page_status_log
-- ----------------------------
DROP TABLE IF EXISTS `page_status_log`;
CREATE TABLE `page_status_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aid` int(11) NOT NULL COMMENT 'app id',
  `page_id` int(11) NOT NULL COMMENT '页面id',
  `status` int(11) DEFAULT NULL COMMENT '页面状态',
  `user_id` int(11) DEFAULT NULL COMMENT '获取用户id',
  `user_name` varchar(64) DEFAULT NULL COMMENT '获取人',
  `type` int(11) DEFAULT '1' COMMENT '日志类型， 目前就一种 获取日志',
  `create_time` datetime DEFAULT NULL COMMENT '插入时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rainbow_user
-- ----------------------------
DROP TABLE IF EXISTS `rainbow_user`;
CREATE TABLE `rainbow_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT '0',
  `allchannel` int(11) DEFAULT '0',
  `allgame` int(11) DEFAULT '0',
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rainbow_user_channel
-- ----------------------------
DROP TABLE IF EXISTS `rainbow_user_channel`;
CREATE TABLE `rainbow_user_channel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `channel_id` varchar(255) DEFAULT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rainbow_user_game
-- ----------------------------
DROP TABLE IF EXISTS `rainbow_user_game`;
CREATE TABLE `rainbow_user_game` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `game_id` varchar(255) DEFAULT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_alert_job
-- ----------------------------
DROP TABLE IF EXISTS `rb_alert_job`;
CREATE TABLE `rb_alert_job` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(255) NOT NULL COMMENT '任务名称',
  `app_id` int(11) NOT NULL COMMENT '所属业务',
  `app_key` varchar(255) NOT NULL COMMENT '所属业务版本',
  `app_version` varchar(255) DEFAULT NULL COMMENT '版本号',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态,1:正常，-1：暂停',
  `pre_condition` int(11) NOT NULL DEFAULT '1' COMMENT '前置条件,0：无前置条件，1：有前置条件',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `user_id` int(11) NOT NULL COMMENT '创建用户ID',
  `job_desc` varchar(50) DEFAULT NULL COMMENT '描述信息',
  `first_cycle` timestamp NULL DEFAULT NULL COMMENT '首次周期',
  `curr_cycle` timestamp NULL DEFAULT NULL COMMENT '当前周期',
  `cycle_type` int(11) DEFAULT NULL COMMENT '周期类型:默认为2，以天为单位',
  `cycle_step` int(11) DEFAULT NULL COMMENT '周期步长，默认为1',
  `cron_expression` varchar(255) DEFAULT NULL COMMENT 'cron表达式',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='指标预警任务表';

-- ----------------------------
-- Table structure for rb_alert_job_detail
-- ----------------------------
DROP TABLE IF EXISTS `rb_alert_job_detail`;
CREATE TABLE `rb_alert_job_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) NOT NULL DEFAULT '0' COMMENT '任务id',
  `target_id` int(11) NOT NULL DEFAULT '0' COMMENT '指标id',
  `latitude_id` int(11) NOT NULL DEFAULT '0' COMMENT '纬度id',
  `upper_limit` int(11) DEFAULT '0' COMMENT '预警上限',
  `lower_limit` int(11) DEFAULT '0' COMMENT '预警下限',
  `alert_condition` int(11) NOT NULL DEFAULT '0' COMMENT '预警触发条件，1：上下限范围之外:X>max||X<min；2：上下限范围之内:X<max&&X>min',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预警任务详细配置';

-- ----------------------------
-- Table structure for rb_alert_job_instance
-- ----------------------------
DROP TABLE IF EXISTS `rb_alert_job_instance`;
CREATE TABLE `rb_alert_job_instance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) NOT NULL DEFAULT '0' COMMENT '任务ID',
  `curr_cycle` timestamp NULL DEFAULT NULL COMMENT '任务周期',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '实例状态，0:待执行,1:执行成功,-1:执行失败',
  `mail_content` text NOT NULL COMMENT '邮件预警内容',
  `sms_content` text NOT NULL COMMENT '短信预警内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='指标预警任务实例表';

-- ----------------------------
-- Table structure for rb_alert_job_instance_log
-- ----------------------------
DROP TABLE IF EXISTS `rb_alert_job_instance_log`;
CREATE TABLE `rb_alert_job_instance_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) DEFAULT '0',
  `curr_cycle` timestamp NULL DEFAULT NULL,
  `instance_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `instance_result` int(11) DEFAULT '0' COMMENT '1:成功,-1:失败',
  `instance_desc` text COMMENT '实例化结果描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预警任务实例化记录表';

-- ----------------------------
-- Table structure for rb_alert_job_receiver
-- ----------------------------
DROP TABLE IF EXISTS `rb_alert_job_receiver`;
CREATE TABLE `rb_alert_job_receiver` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) NOT NULL COMMENT '任务ID',
  `receiver_type` int(11) NOT NULL COMMENT '收件类型，1：邮件,2:短信,3:邮件+短信',
  `receiver_name` varchar(255) NOT NULL COMMENT '接收者名字',
  `mail` varchar(255) DEFAULT NULL COMMENT '邮件地址,receiveType为1或3时,必填',
  `mobile_number` varchar(255) DEFAULT NULL COMMENT '电话号码,receiveType为2或3时,必填',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预警接收人';

-- ----------------------------
-- Table structure for rb_alert_job_send_log
-- ----------------------------
DROP TABLE IF EXISTS `rb_alert_job_send_log`;
CREATE TABLE `rb_alert_job_send_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) DEFAULT '0',
  `curr_cycle` timestamp NULL DEFAULT NULL,
  `send_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `send_result` int(11) DEFAULT '0' COMMENT '1:成功,-1:失败',
  `result_desc` text COMMENT '发送结果描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预警任务发送记录表';

-- ----------------------------
-- Table structure for rb_app
-- ----------------------------
DROP TABLE IF EXISTS `rb_app`;
CREATE TABLE `rb_app` (
  `app_id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(255) NOT NULL COMMENT '应用名称',
  `en_name` varchar(255) NOT NULL COMMENT '应用别名',
  `icon` varchar(50) DEFAULT NULL COMMENT '应用图片名称',
  `online_time` timestamp NULL DEFAULT NULL COMMENT '应用上线时间',
  `data_source` varchar(255) DEFAULT NULL COMMENT '数据源名称',
  `category` int(11) DEFAULT NULL,
  `id_alias` varchar(50) DEFAULT NULL,
  `stat_id` varchar(50) DEFAULT NULL,
  `atype` int(11) DEFAULT '0',
  `os_type` tinyint(4) NOT NULL DEFAULT '0',
  `add_permission_admin` tinyint(4) DEFAULT '0' COMMENT '添加权限给管理者 1:true/0:false',
  PRIMARY KEY (`app_id`)
) ENGINE=InnoDB AUTO_INCREMENT=417 DEFAULT CHARSET=utf8 COMMENT='业务表';

-- ----------------------------
-- Table structure for rb_app_category
-- ----------------------------
DROP TABLE IF EXISTS `rb_app_category`;
CREATE TABLE `rb_app_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_app_exclude_menu
-- ----------------------------
DROP TABLE IF EXISTS `rb_app_exclude_menu`;
CREATE TABLE `rb_app_exclude_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_id` int(11) NOT NULL COMMENT '菜单id',
  `app_id` int(11) DEFAULT NULL COMMENT 'appid',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49502 DEFAULT CHARSET=utf8 COMMENT='业务过滤掉的通用报表';

-- ----------------------------
-- Table structure for rb_app_istore
-- ----------------------------
DROP TABLE IF EXISTS `rb_app_istore`;
CREATE TABLE `rb_app_istore` (
  `app_en_name` varchar(255) NOT NULL,
  `istore` double DEFAULT NULL,
  PRIMARY KEY (`app_en_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='APP收入表';

-- ----------------------------
-- Table structure for rb_apply_permission_detail
-- ----------------------------
DROP TABLE IF EXISTS `rb_apply_permission_detail`;
CREATE TABLE `rb_apply_permission_detail` (
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
-- Table structure for rb_conf_db
-- ----------------------------
DROP TABLE IF EXISTS `rb_conf_db`;
CREATE TABLE `rb_conf_db` (
  `app_id` int(11) NOT NULL,
  `db_name` varchar(100) NOT NULL COMMENT '数据库名称',
  `db_key` varchar(100) DEFAULT NULL COMMENT '数据库key',
  PRIMARY KEY (`app_id`,`db_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='DB配置表';

-- ----------------------------
-- Table structure for rb_conf_sql
-- ----------------------------
DROP TABLE IF EXISTS `rb_conf_sql`;
CREATE TABLE `rb_conf_sql` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sql_key` varchar(100) DEFAULT NULL,
  `sql_name` varchar(100) DEFAULT NULL,
  `sql_value` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='sql模版配置表';

-- ----------------------------
-- Table structure for rb_data_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `rb_data_dictionary`;
CREATE TABLE `rb_data_dictionary` (
  `name` varchar(255) NOT NULL,
  `value` text,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_datasource
-- ----------------------------
DROP TABLE IF EXISTS `rb_datasource`;
CREATE TABLE `rb_datasource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `create_by` int(11) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `last_update_by` int(11) DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_error_sql
-- ----------------------------
DROP TABLE IF EXISTS `rb_error_sql`;
CREATE TABLE `rb_error_sql` (
  `menu_id` int(11) NOT NULL,
  `app_id` varchar(50) NOT NULL,
  `sql` text NOT NULL,
  `error_info` text NOT NULL,
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_extend_permission_expire
-- ----------------------------
DROP TABLE IF EXISTS `rb_extend_permission_expire`;
CREATE TABLE `rb_extend_permission_expire` (
  `id` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_favorite
-- ----------------------------
DROP TABLE IF EXISTS `rb_favorite`;
CREATE TABLE `rb_favorite` (
  `user_id` int(11) NOT NULL,
  `app_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`,`app_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_global_app_order
-- ----------------------------
DROP TABLE IF EXISTS `rb_global_app_order`;
CREATE TABLE `rb_global_app_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` int(11) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_host
-- ----------------------------
DROP TABLE IF EXISTS `rb_host`;
CREATE TABLE `rb_host` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host_name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_lang_code
-- ----------------------------
DROP TABLE IF EXISTS `rb_lang_code`;
CREATE TABLE `rb_lang_code` (
  `code` varchar(50) NOT NULL,
  `title` varchar(80) NOT NULL,
  `displayorder` smallint(6) NOT NULL DEFAULT '0' COMMENT '数值越大排名靠前',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_lang_map
-- ----------------------------
DROP TABLE IF EXISTS `rb_lang_map`;
CREATE TABLE `rb_lang_map` (
  `code` varchar(50) NOT NULL,
  `key` varchar(2048) NOT NULL,
  `value` mediumtext,
  `hash_key` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'common',
  PRIMARY KEY (`code`,`hash_key`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_login_log
-- ----------------------------
DROP TABLE IF EXISTS `rb_login_log`;
CREATE TABLE `rb_login_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL,
  `login_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50116 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_mail
-- ----------------------------
DROP TABLE IF EXISTS `rb_mail`;
CREATE TABLE `rb_mail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '邮件创建者',
  `app_id` int(11) DEFAULT NULL COMMENT '业务id',
  `subject` varchar(255) DEFAULT NULL COMMENT '邮件主题',
  `mail_status` int(11) DEFAULT NULL COMMENT '0:可发送,-1:不可发送',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `init_delay` int(11) NOT NULL DEFAULT '0',
  `first_cycle` timestamp NULL DEFAULT NULL COMMENT '首次周期',
  `curr_cycle` timestamp NULL DEFAULT NULL COMMENT '当前周期',
  `cycle_type` int(11) DEFAULT NULL COMMENT '周期类型:1:小时,2:天,3:周,4:月',
  `cycle_step` int(11) DEFAULT '1' COMMENT '周期步长',
  `cron_expression` varchar(255) DEFAULT NULL COMMENT 'cron表达式',
  `mail_content` text,
  `remark` text NOT NULL,
  `pre_condition` int(11) DEFAULT '0' COMMENT '邮件发送前置条件,0:无前置条件,1:渠道商数据入库,...其他可扩展',
  `mail_text` text COMMENT '文案',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_mail_instance
-- ----------------------------
DROP TABLE IF EXISTS `rb_mail_instance`;
CREATE TABLE `rb_mail_instance` (
  `mail_id` int(11) NOT NULL,
  `curr_cycle` datetime NOT NULL,
  `message_body` longtext,
  `mail_status` int(11) DEFAULT NULL COMMENT '0:待发送,1:发送成功,9:暂停发送',
  `create_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`mail_id`,`curr_cycle`),
  KEY `idx_rbi_ms` (`mail_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='邮件实例表';

-- ----------------------------
-- Table structure for rb_mail_log
-- ----------------------------
DROP TABLE IF EXISTS `rb_mail_log`;
CREATE TABLE `rb_mail_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail_id` int(11) DEFAULT NULL,
  `curr_cycle` timestamp NULL DEFAULT NULL,
  `times` int(11) DEFAULT NULL,
  `sent_status` int(11) DEFAULT NULL,
  `sent_time` timestamp NULL DEFAULT NULL,
  `remark` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18509 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_mail_receiver
-- ----------------------------
DROP TABLE IF EXISTS `rb_mail_receiver`;
CREATE TABLE `rb_mail_receiver` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail_id` int(11) NOT NULL DEFAULT '0',
  `mail_address` varchar(255) DEFAULT NULL,
  `receiver_type` int(11) DEFAULT NULL COMMENT '1:主收件人2:抄送人员3:密送人员',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=460 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_mail_retry
-- ----------------------------
DROP TABLE IF EXISTS `rb_mail_retry`;
CREATE TABLE `rb_mail_retry` (
  `mail_id` int(11) NOT NULL,
  `curr_cycle` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`mail_id`,`curr_cycle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='重发数据表';

-- ----------------------------
-- Table structure for rb_menu
-- ----------------------------
DROP TABLE IF EXISTS `rb_menu`;
CREATE TABLE `rb_menu` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '菜单id',
  `menu_name` varchar(255) NOT NULL COMMENT '菜单名称',
  `parent_id` int(11) NOT NULL COMMENT '父菜单id',
  `is_leaf` int(11) DEFAULT NULL COMMENT '是否叶子节点',
  `order_index` double(16,8) DEFAULT NULL COMMENT '在同一个父菜单下的显示顺序',
  `url` varchar(1024) DEFAULT NULL COMMENT 'url',
  `app_id` int(11) DEFAULT NULL COMMENT '所属业务,通用业务为1',
  `role_id` int(11) DEFAULT NULL COMMENT '所属角色',
  `is_mobile` int(2) DEFAULT '0' COMMENT '是否是手机端，1：是，0：不是',
  `create_time` datetime DEFAULT NULL COMMENT '菜单创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  `description` varchar(1024) DEFAULT NULL COMMENT '菜单描述',
  `icon_name` varchar(255) DEFAULT NULL,
  `is_hidden` int(11) DEFAULT '0' COMMENT '是否隐藏  1隐藏 0显示',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2094 DEFAULT CHARSET=utf8 COMMENT='菜单';

-- ----------------------------
-- Table structure for rb_menutest
-- ----------------------------
DROP TABLE IF EXISTS `rb_menutest`;
CREATE TABLE `rb_menutest` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '菜单id',
  `menu_name` varchar(255) NOT NULL COMMENT '菜单名称',
  `parent_id` int(11) NOT NULL COMMENT '父菜单id',
  `is_leaf` int(11) DEFAULT NULL COMMENT '是否叶子节点',
  `order_index` double(16,8) DEFAULT NULL COMMENT '在同一个父菜单下的显示顺序',
  `url` varchar(1024) DEFAULT NULL COMMENT 'url',
  `app_id` int(11) DEFAULT NULL COMMENT '所属业务,通用业务为1',
  `role_id` int(11) DEFAULT NULL COMMENT '所属角色',
  `is_mobile` int(2) DEFAULT '0' COMMENT '是否是手机端，1：是，0：不是',
  `create_time` datetime DEFAULT NULL COMMENT '菜单创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  `description` varchar(1024) DEFAULT NULL COMMENT '菜单描述',
  `icon_name` varchar(255) DEFAULT NULL,
  `is_hidden` int(11) DEFAULT '0' COMMENT '是否隐藏  1隐藏 0显示',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2085 DEFAULT CHARSET=utf8 COMMENT='菜单';

-- ----------------------------
-- Table structure for rb_operate_log
-- ----------------------------
DROP TABLE IF EXISTS `rb_operate_log`;
CREATE TABLE `rb_operate_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operator` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `params` text,
  `ip` varchar(50) DEFAULT NULL,
  `operate_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20479 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_permission_expire_date
-- ----------------------------
DROP TABLE IF EXISTS `rb_permission_expire_date`;
CREATE TABLE `rb_permission_expire_date` (
  `user_id` int(11) NOT NULL,
  `app_id` int(11) NOT NULL,
  `expire_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_profile_data
-- ----------------------------
DROP TABLE IF EXISTS `rb_profile_data`;
CREATE TABLE `rb_profile_data` (
  `key` varchar(255) NOT NULL,
  `value` longtext,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_report
-- ----------------------------
DROP TABLE IF EXISTS `rb_report`;
CREATE TABLE `rb_report` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_id` int(11) DEFAULT NULL COMMENT '所属菜单',
  `report_value` longtext,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  `description` varchar(1024) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`report_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1941 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_report_analyse
-- ----------------------------
DROP TABLE IF EXISTS `rb_report_analyse`;
CREATE TABLE `rb_report_analyse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aid` int(11) NOT NULL COMMENT '报表所属业务id',
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `app_id` varchar(255) DEFAULT NULL,
  `menu_id` int(11) NOT NULL,
  `menu_name` varchar(255) DEFAULT NULL,
  `tab_id` varchar(255) NOT NULL,
  `tab_name` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `status` int(11) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `last_update_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_report_cart
-- ----------------------------
DROP TABLE IF EXISTS `rb_report_cart`;
CREATE TABLE `rb_report_cart` (
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '创建者,存储用户id',
  `app_id` int(11) NOT NULL DEFAULT '0' COMMENT '报表关联的业务ID',
  `report_identify` text COMMENT '报表标识,用于记录订阅的报表全路径:菜单id+报表在页面中的标识',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `remark` text COMMENT '备注',
  PRIMARY KEY (`user_id`,`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_report_download
-- ----------------------------
DROP TABLE IF EXISTS `rb_report_download`;
CREATE TABLE `rb_report_download` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `user_name` varchar(32) DEFAULT NULL,
  `app_id` int(11) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL COMMENT '文件名称',
  `pageid` int(11) DEFAULT NULL,
  `fieldid` varchar(255) DEFAULT NULL,
  `download_date` datetime NOT NULL COMMENT '下载时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_report_role
-- ----------------------------
DROP TABLE IF EXISTS `rb_report_role`;
CREATE TABLE `rb_report_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) NOT NULL COMMENT '报表角色名称',
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='报表角色';

-- ----------------------------
-- Table structure for rb_screenshot_error
-- ----------------------------
DROP TABLE IF EXISTS `rb_screenshot_error`;
CREATE TABLE `rb_screenshot_error` (
  `id` int(11) NOT NULL COMMENT 'mailId或smsId',
  `type` varchar(255) NOT NULL COMMENT '类型mail或sms',
  `current_cycle` varchar(255) NOT NULL COMMENT '当前周期',
  `content` text COMMENT '告警邮件内容',
  `status` int(11) DEFAULT '1' COMMENT '状态，1待告警，0已告警'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_screenshot_log
-- ----------------------------
DROP TABLE IF EXISTS `rb_screenshot_log`;
CREATE TABLE `rb_screenshot_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `log_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `log_content` text,
  `type` varchar(255) DEFAULT NULL,
  `log_ip` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3729553 DEFAULT CHARSET=utf8 COMMENT='页面截图日志表';

-- ----------------------------
-- Table structure for rb_sms
-- ----------------------------
DROP TABLE IF EXISTS `rb_sms`;
CREATE TABLE `rb_sms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '短信创建者',
  `app_id` int(11) DEFAULT NULL COMMENT '业务id',
  `subject` varchar(255) DEFAULT NULL COMMENT '短信主题',
  `sms_status` int(11) DEFAULT NULL COMMENT '0:可发送,-1:不可发送',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `init_delay` int(11) DEFAULT '0',
  `first_cycle` timestamp NULL DEFAULT '0000-00-00 00:00:00' COMMENT '首次周期',
  `curr_cycle` timestamp NULL DEFAULT '0000-00-00 00:00:00' COMMENT '当前周期',
  `time1` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '第一次发送时间',
  `time2` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '第二次发送时间',
  `cycle_type` int(11) DEFAULT NULL COMMENT '周期类型:1:小时,2:天,3:周,4:月',
  `cycle_step` int(11) DEFAULT '1' COMMENT '周期步长',
  `cron_expression` varchar(255) DEFAULT NULL COMMENT 'cron表达式',
  `sms_content` text,
  `sms_type` int(11) DEFAULT '1' COMMENT '短信类型,1:定制报表短信(需抓取页面数据生成短信内容),2:自定义短信(一次性短信，通过页面编辑短信内容)',
  `remark` text,
  `pre_condition` int(11) DEFAULT '0' COMMENT '短信发送前置条件',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=5461;

-- ----------------------------
-- Table structure for rb_sms_instance
-- ----------------------------
DROP TABLE IF EXISTS `rb_sms_instance`;
CREATE TABLE `rb_sms_instance` (
  `sms_id` int(11) NOT NULL DEFAULT '0',
  `curr_cycle` datetime NOT NULL,
  `time_id` int(11) DEFAULT NULL,
  `message_body` longtext,
  `sms_status` int(11) DEFAULT NULL,
  `create_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sms_id`,`curr_cycle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=28398 COMMENT='邮件实例表';

-- ----------------------------
-- Table structure for rb_sms_log
-- ----------------------------
DROP TABLE IF EXISTS `rb_sms_log`;
CREATE TABLE `rb_sms_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sms_id` int(11) DEFAULT NULL,
  `curr_cycle` timestamp NULL DEFAULT NULL,
  `time_id` int(11) DEFAULT NULL,
  `times` int(11) DEFAULT NULL,
  `sent_status` int(11) DEFAULT NULL,
  `sent_time` timestamp NULL DEFAULT NULL,
  `remark` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=481;

-- ----------------------------
-- Table structure for rb_sms_receiver
-- ----------------------------
DROP TABLE IF EXISTS `rb_sms_receiver`;
CREATE TABLE `rb_sms_receiver` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sms_id` int(11) NOT NULL DEFAULT '0',
  `phone_number` varchar(255) DEFAULT NULL,
  `timer_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=2730;

-- ----------------------------
-- Table structure for rb_sms_retry
-- ----------------------------
DROP TABLE IF EXISTS `rb_sms_retry`;
CREATE TABLE `rb_sms_retry` (
  `sms_id` int(11) NOT NULL,
  `curr_cycle` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `time_id` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`sms_id`,`curr_cycle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='短信重发数据表';

-- ----------------------------
-- Table structure for rb_stat_latitude
-- ----------------------------
DROP TABLE IF EXISTS `rb_stat_latitude`;
CREATE TABLE `rb_stat_latitude` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `latitude_name` varchar(255) NOT NULL DEFAULT '0' COMMENT '纬度名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='指标统计纬度定义表';

-- ----------------------------
-- Table structure for rb_sys_msg
-- ----------------------------
DROP TABLE IF EXISTS `rb_sys_msg`;
CREATE TABLE `rb_sys_msg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `create_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(11) DEFAULT '0' COMMENT '状态，1发布，0未发布',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_target
-- ----------------------------
DROP TABLE IF EXISTS `rb_target`;
CREATE TABLE `rb_target` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `target_name` varchar(255) NOT NULL DEFAULT '0' COMMENT '指标名称',
  `privilege_level` int(11) NOT NULL DEFAULT '0' COMMENT '指标权限级别',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预警指标定义表';

-- ----------------------------
-- Table structure for rb_target_latitude_relation
-- ----------------------------
DROP TABLE IF EXISTS `rb_target_latitude_relation`;
CREATE TABLE `rb_target_latitude_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `target_id` int(11) NOT NULL DEFAULT '0' COMMENT '指标ID',
  `latitude_id` int(11) NOT NULL DEFAULT '0' COMMENT '纬度ID',
  `query_sql` text NOT NULL COMMENT '指标查询sql',
  `data_source` varchar(255) NOT NULL DEFAULT '0' COMMENT '所属数据源',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='指标纬度关系表';

-- ----------------------------
-- Table structure for rb_user
-- ----------------------------
DROP TABLE IF EXISTS `rb_user`;
CREATE TABLE `rb_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL COMMENT '登录用户名',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT '1' COMMENT '状态：1可用，0不可用',
  `guide` int(11) NOT NULL DEFAULT '0' COMMENT '是否启用指引',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加/注册时间',
  `user_type` int(11) DEFAULT NULL,
  `pwd` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=504 DEFAULT CHARSET=utf8 COMMENT='用户';

-- ----------------------------
-- Table structure for rb_user_action
-- ----------------------------
DROP TABLE IF EXISTS `rb_user_action`;
CREATE TABLE `rb_user_action` (
  `action_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `platform_id` int(11) NOT NULL COMMENT 'datax各平台id  1门户 2接入 3彩虹 4提取 ...',
  `path` varchar(512) DEFAULT NULL,
  `action_id` int(11) NOT NULL COMMENT '行为ID 100xx门户 200xx自助接入 300xx彩虹 400xx提取',
  `action_name` varchar(255) DEFAULT NULL COMMENT '行为名称',
  `action_type` varchar(255) DEFAULT NULL COMMENT '行为类型',
  `user_name` varchar(50) DEFAULT NULL COMMENT '操作者',
  `action_pid` int(11) DEFAULT NULL COMMENT '上一个行为ID',
  `browser` varchar(100) DEFAULT NULL COMMENT '浏览器版本',
  `data0` varchar(255) DEFAULT NULL COMMENT '扩展参数1',
  `data1` varchar(255) DEFAULT NULL COMMENT '扩展参数2',
  `data2` varchar(255) DEFAULT NULL COMMENT '扩展参数3',
  `data3` varchar(255) DEFAULT NULL COMMENT '扩展参数4',
  `data4` varchar(255) DEFAULT NULL COMMENT '扩展参数5',
  `desc` varchar(1024) DEFAULT NULL COMMENT '描述'
) ENGINE=InnoDB DEFAULT CHARSET=utf8
/*!50500 PARTITION BY RANGE  COLUMNS(action_date)
(PARTITION p201709 VALUES LESS THAN ('2017-10-01') ENGINE = InnoDB,
 PARTITION p201710 VALUES LESS THAN ('2017-11-01') ENGINE = InnoDB,
 PARTITION p201711 VALUES LESS THAN ('2017-12-01') ENGINE = InnoDB,
 PARTITION p201712 VALUES LESS THAN ('2018-01-01') ENGINE = InnoDB,
 PARTITION p201801 VALUES LESS THAN ('2018-02-01') ENGINE = InnoDB,
 PARTITION p201802 VALUES LESS THAN ('2018-03-01') ENGINE = InnoDB,
 PARTITION p201803 VALUES LESS THAN ('2018-04-01') ENGINE = InnoDB,
 PARTITION p201804 VALUES LESS THAN ('2018-05-01') ENGINE = InnoDB,
 PARTITION p201805 VALUES LESS THAN ('2018-06-01') ENGINE = InnoDB,
 PARTITION p201806 VALUES LESS THAN ('2018-07-01') ENGINE = InnoDB,
 PARTITION p201807 VALUES LESS THAN ('2018-08-01') ENGINE = InnoDB,
 PARTITION p201808 VALUES LESS THAN ('2018-09-01') ENGINE = InnoDB,
 PARTITION p201809 VALUES LESS THAN ('2018-10-01') ENGINE = InnoDB,
 PARTITION p201810 VALUES LESS THAN ('2018-11-01') ENGINE = InnoDB,
 PARTITION p201811 VALUES LESS THAN ('2018-12-01') ENGINE = InnoDB,
 PARTITION p201812 VALUES LESS THAN ('2019-01-01') ENGINE = InnoDB,
 PARTITION p201901 VALUES LESS THAN ('2019-02-01') ENGINE = InnoDB,
 PARTITION p201902 VALUES LESS THAN ('2019-03-01') ENGINE = InnoDB,
 PARTITION p201903 VALUES LESS THAN ('2019-04-01') ENGINE = InnoDB,
 PARTITION p201904 VALUES LESS THAN ('2019-05-01') ENGINE = InnoDB,
 PARTITION p201905 VALUES LESS THAN ('2019-06-01') ENGINE = InnoDB,
 PARTITION p201906 VALUES LESS THAN ('2019-07-01') ENGINE = InnoDB,
 PARTITION p201907 VALUES LESS THAN ('2019-08-01') ENGINE = InnoDB,
 PARTITION p201908 VALUES LESS THAN ('2019-09-01') ENGINE = InnoDB,
 PARTITION p201909 VALUES LESS THAN ('2019-10-01') ENGINE = InnoDB,
 PARTITION p201910 VALUES LESS THAN ('2019-11-01') ENGINE = InnoDB,
 PARTITION p201911 VALUES LESS THAN ('2019-12-01') ENGINE = InnoDB,
 PARTITION p201912 VALUES LESS THAN ('2020-01-01') ENGINE = InnoDB,
 PARTITION p202001 VALUES LESS THAN ('2020-02-01') ENGINE = InnoDB,
 PARTITION p202002 VALUES LESS THAN ('2020-03-01') ENGINE = InnoDB,
 PARTITION p202003 VALUES LESS THAN ('2020-04-01') ENGINE = InnoDB,
 PARTITION p202004 VALUES LESS THAN ('2020-05-01') ENGINE = InnoDB,
 PARTITION p202006 VALUES LESS THAN ('2020-06-01') ENGINE = InnoDB,
 PARTITION p202007 VALUES LESS THAN ('2020-07-01') ENGINE = InnoDB,
 PARTITION p202008 VALUES LESS THAN ('2020-08-01') ENGINE = InnoDB,
 PARTITION p202009 VALUES LESS THAN ('2020-09-01') ENGINE = InnoDB,
 PARTITION p202010 VALUES LESS THAN ('2020-10-01') ENGINE = InnoDB,
 PARTITION p202011 VALUES LESS THAN ('2020-11-01') ENGINE = InnoDB,
 PARTITION p202012 VALUES LESS THAN ('2020-12-01') ENGINE = InnoDB) */;

-- ----------------------------
-- Table structure for rb_user_behavior
-- ----------------------------
DROP TABLE IF EXISTS `rb_user_behavior`;
CREATE TABLE `rb_user_behavior` (
  `view_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `app_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `menu_id` int(11) DEFAULT NULL,
  `menu_name` varchar(255) DEFAULT NULL,
  `params` varchar(255) DEFAULT NULL,
  `is_search_btn` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8
/*!50500 PARTITION BY RANGE  COLUMNS(view_date)
(PARTITION p201709 VALUES LESS THAN ('2017-10-01') ENGINE = InnoDB,
 PARTITION p201710 VALUES LESS THAN ('2017-11-01') ENGINE = InnoDB,
 PARTITION p201711 VALUES LESS THAN ('2017-12-01') ENGINE = InnoDB,
 PARTITION p201712 VALUES LESS THAN ('2018-01-01') ENGINE = InnoDB,
 PARTITION p201801 VALUES LESS THAN ('2018-02-01') ENGINE = InnoDB,
 PARTITION p201802 VALUES LESS THAN ('2018-03-01') ENGINE = InnoDB,
 PARTITION p201803 VALUES LESS THAN ('2018-04-01') ENGINE = InnoDB,
 PARTITION p201804 VALUES LESS THAN ('2018-05-01') ENGINE = InnoDB,
 PARTITION p201805 VALUES LESS THAN ('2018-06-01') ENGINE = InnoDB,
 PARTITION p201806 VALUES LESS THAN ('2018-07-01') ENGINE = InnoDB,
 PARTITION p201807 VALUES LESS THAN ('2018-08-01') ENGINE = InnoDB,
 PARTITION p201808 VALUES LESS THAN ('2018-09-01') ENGINE = InnoDB,
 PARTITION p201809 VALUES LESS THAN ('2018-10-01') ENGINE = InnoDB,
 PARTITION p201810 VALUES LESS THAN ('2018-11-01') ENGINE = InnoDB,
 PARTITION p201811 VALUES LESS THAN ('2018-12-01') ENGINE = InnoDB,
 PARTITION p201812 VALUES LESS THAN ('2019-01-01') ENGINE = InnoDB,
 PARTITION p201901 VALUES LESS THAN ('2019-02-01') ENGINE = InnoDB,
 PARTITION p201902 VALUES LESS THAN ('2019-03-01') ENGINE = InnoDB,
 PARTITION p201903 VALUES LESS THAN ('2019-04-01') ENGINE = InnoDB,
 PARTITION p201904 VALUES LESS THAN ('2019-05-01') ENGINE = InnoDB,
 PARTITION p201905 VALUES LESS THAN ('2019-06-01') ENGINE = InnoDB,
 PARTITION p201906 VALUES LESS THAN ('2019-07-01') ENGINE = InnoDB,
 PARTITION p201907 VALUES LESS THAN ('2019-08-01') ENGINE = InnoDB,
 PARTITION p201908 VALUES LESS THAN ('2019-09-01') ENGINE = InnoDB,
 PARTITION p201909 VALUES LESS THAN ('2019-10-01') ENGINE = InnoDB,
 PARTITION p201910 VALUES LESS THAN ('2019-11-01') ENGINE = InnoDB,
 PARTITION p201911 VALUES LESS THAN ('2019-12-01') ENGINE = InnoDB,
 PARTITION p201912 VALUES LESS THAN ('2020-01-01') ENGINE = InnoDB,
 PARTITION p202001 VALUES LESS THAN ('2020-02-01') ENGINE = InnoDB,
 PARTITION p202002 VALUES LESS THAN ('2020-03-01') ENGINE = InnoDB,
 PARTITION p202003 VALUES LESS THAN ('2020-04-01') ENGINE = InnoDB,
 PARTITION p202004 VALUES LESS THAN ('2020-05-01') ENGINE = InnoDB,
 PARTITION p202005 VALUES LESS THAN ('2020-06-01') ENGINE = InnoDB,
 PARTITION p202006 VALUES LESS THAN ('2020-07-01') ENGINE = InnoDB,
 PARTITION p202007 VALUES LESS THAN ('2020-08-01') ENGINE = InnoDB) */;

-- ----------------------------
-- Table structure for rb_user_behavior2
-- ----------------------------
DROP TABLE IF EXISTS `rb_user_behavior2`;
CREATE TABLE `rb_user_behavior2` (
  `view_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `uid` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `fromurl` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_user_defined_report
-- ----------------------------
DROP TABLE IF EXISTS `rb_user_defined_report`;
CREATE TABLE `rb_user_defined_report` (
  `user_id` int(11) NOT NULL,
  `page_id` int(11) NOT NULL,
  `content` text,
  PRIMARY KEY (`user_id`,`page_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_user_host_relation
-- ----------------------------
DROP TABLE IF EXISTS `rb_user_host_relation`;
CREATE TABLE `rb_user_host_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `hid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rb_user_permission
-- ----------------------------
DROP TABLE IF EXISTS `rb_user_permission`;
CREATE TABLE `rb_user_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `role_id` int(11) DEFAULT NULL COMMENT '角色ID',
  `app_id` int(11) DEFAULT NULL COMMENT '业务ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=298770 DEFAULT CHARSET=utf8 COMMENT='用户权限';

-- ----------------------------
-- Table structure for rb_user_role
-- ----------------------------
DROP TABLE IF EXISTS `rb_user_role`;
CREATE TABLE `rb_user_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL DEFAULT '2' COMMENT '角色名称',
  `role_desc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='用户角色表';

-- ----------------------------
-- Table structure for rb_user_role_relation
-- ----------------------------
DROP TABLE IF EXISTS `rb_user_role_relation`;
CREATE TABLE `rb_user_role_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=647 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_games
-- ----------------------------
DROP TABLE IF EXISTS `user_games`;
CREATE TABLE `user_games` (
  `user_name` varchar(255) NOT NULL,
  `game_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- View structure for game_v_rpt_tbstoregamepoints
-- ----------------------------
DROP VIEW IF EXISTS `game_v_rpt_tbstoregamepoints`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `game_v_rpt_tbstoregamepoints` AS select `game_rpt_tbstoregamepoints`.`dtstatdate` AS `dtstatdate`,`game_rpt_tbstoregamepoints`.`vgameid` AS `vgameid`,`game_rpt_tbstoregamepoints`.`zoneid` AS `vgameappkey`,`game_rpt_tbstoregamepoints`.`channelid` AS `ChannelID`,`game_rpt_tbstoregamepoints`.`iusernum` AS `iUserNum`,`game_rpt_tbstoregamepoints`.`istoretimes` AS `iStoreTimes`,`game_rpt_tbstoregamepoints`.`istore` AS `iStore` from `game_rpt_tbstoregamepoints` ;
