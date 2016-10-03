# MySQL-Front 5.0  (Build 1.0)

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE */;
/*!40101 SET SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES */;
/*!40103 SET SQL_NOTES='ON' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;


# Host: localhost    Database: mynote
# ------------------------------------------------------
# Server version 5.0.18-nt

#
# Table structure for table collect
#

DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect` (
  `col_id` int(8) NOT NULL auto_increment COMMENT '收藏id唯一识别数据',
  `col_name` varchar(100) NOT NULL default '' COMMENT '收藏名字',
  `col_address` varchar(100) NOT NULL default '' COMMENT '收藏地址',
  `user_id` int(11) default NULL COMMENT '关联用户id',
  PRIMARY KEY  (`col_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收藏表';
/*!40000 ALTER TABLE `collect` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table finance
#

DROP TABLE IF EXISTS `finance`;
CREATE TABLE `finance` (
  `fin_id` int(8) NOT NULL auto_increment COMMENT '消费记录id唯一识别数据',
  `fin_type` int(4) NOT NULL default '0' COMMENT '消费类型，根据id匹配fiance_type中的fin_typename',
  `fin_moneyTotal` double(10,2) NOT NULL default '0.00' COMMENT '剩余金额',
  `fin_time` date default '2016-08-30' COMMENT '消费时间',
  `fin_summary` varchar(1000) default '' COMMENT '消费记录说明',
  `user_id` int(11) default NULL COMMENT '关联用户id',
  `fin_money` double(10,2) NOT NULL default '0.00',
  PRIMARY KEY  (`fin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存放消费记录表格';
INSERT INTO `finance` VALUES (1,1,0,'2016-08-30','data测试',1,0);
INSERT INTO `finance` VALUES (2,2,1000,'2014-02-03','null',1,1000);
INSERT INTO `finance` VALUES (3,2,2000,'2014-02-03','null',1,1000);
INSERT INTO `finance` VALUES (4,2,3000,'2014-02-03','报下',1,1000);
INSERT INTO `finance` VALUES (5,2,4000,'2014-05-08','保险啊',1,1000);
INSERT INTO `finance` VALUES (6,2,3000,'2014-03-02','保险',1,-1000);
INSERT INTO `finance` VALUES (7,3,6333,'2014-05-08','测试',1,3333);
/*!40000 ALTER TABLE `finance` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table finance_budget
#

DROP TABLE IF EXISTS `finance_budget`;
CREATE TABLE `finance_budget` (
  `fin_budgetid` int(11) NOT NULL auto_increment COMMENT '消费总额，同时关联userid',
  `f_budget` double(10,2) NOT NULL default '0.00' COMMENT '消费预算',
  PRIMARY KEY  (`fin_budgetid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预算金额';
/*!40000 ALTER TABLE `finance_budget` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table finance_type
#

DROP TABLE IF EXISTS `finance_type`;
CREATE TABLE `finance_type` (
  `fin_typenameid` int(8) NOT NULL auto_increment COMMENT '消费类型id,唯一识别数据',
  `fin_typename` varchar(100) NOT NULL default '默认' COMMENT '消费类型名',
  `fin_typeAttribute` tinyint(1) NOT NULL default '0' COMMENT '表示支出或者收入',
  PRIMARY KEY  (`fin_typenameid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='消费类型';
INSERT INTO `finance_type` VALUES (1,'旅游',0);
INSERT INTO `finance_type` VALUES (2,'保险',0);
INSERT INTO `finance_type` VALUES (3,'购物',0);
INSERT INTO `finance_type` VALUES (4,'服务型',0);
INSERT INTO `finance_type` VALUES (5,'其他',0);
INSERT INTO `finance_type` VALUES (6,'工资',1);
INSERT INTO `finance_type` VALUES (7,'中奖',1);
INSERT INTO `finance_type` VALUES (8,'投资',1);
INSERT INTO `finance_type` VALUES (9,'其他',1);
/*!40000 ALTER TABLE `finance_type` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table note
#

DROP TABLE IF EXISTS `note`;
CREATE TABLE `note` (
  `note_id` int(8) NOT NULL auto_increment COMMENT 'ID唯一识别数据',
  `note_title` varchar(100) NOT NULL default '' COMMENT '笔记题目',
  `note_type` varchar(255) NOT NULL default '1' COMMENT '笔记类型名id',
  `note_createTime` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '添加时间',
  `user_id` int(11) default NULL COMMENT '关联用户id',
  PRIMARY KEY  (`note_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='笔记表';
/*!40000 ALTER TABLE `note` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table note_type
#

DROP TABLE IF EXISTS `note_type`;
CREATE TABLE `note_type` (
  `note_typeNameId` int(8) NOT NULL auto_increment COMMENT '笔记类型id唯一识别数据',
  `note_typeName` varchar(100) NOT NULL default '' COMMENT '笔记类型名',
  `user_id` int(11) default NULL COMMENT '关联用户id',
  PRIMARY KEY  (`note_typeNameId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='笔记类型';
/*!40000 ALTER TABLE `note_type` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table schedule
#

DROP TABLE IF EXISTS `schedule`;
CREATE TABLE `schedule` (
  `sch_id` int(8) NOT NULL auto_increment COMMENT '日程id,唯一识别数据',
  `sch_isDone` tinyint(2) NOT NULL default '0' COMMENT '完成状态，0代表未完成1代表完成',
  `sch_createTime` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `sch_completeTime` date default NULL COMMENT '完成时间，修改完成状态时自动插入',
  `user_id` int(11) default NULL COMMENT '关联用户id',
  PRIMARY KEY  (`sch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日程表格';
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;
UNLOCK TABLES;

#
# Table structure for table user
#

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL auto_increment,
  `user_name` varchar(100) NOT NULL default '' COMMENT '用户名',
  `user_pass` varchar(100) NOT NULL default '' COMMENT '用户密码',
  `user_phone` int(11) default NULL,
  `user_email` varchar(100) default NULL,
  `user_photo` varchar(100) default NULL,
  `user_summary` varchar(255) default NULL,
  PRIMARY KEY  (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户信息';
INSERT INTO `user` VALUES (1,'admin','admin',NULL,NULL,NULL,NULL);
INSERT INTO `user` VALUES (2,'é¿è¿ª','asasd',123456,'123456','null','asfd');
INSERT INTO `user` VALUES (3,'S','adA',11111111,'ASDF','null','DSAF');
INSERT INTO `user` VALUES (4,'用户1','111',123456,'1140823948@qq.com','5}}TXC0({EPA(6RS_DXI70R.png','asfd');
INSERT INTO `user` VALUES (5,'用户2','222',123456,'1140823948@qq.com','5}}TXC0({EPA(6RS_DXI70R.png','asfd');
INSERT INTO `user` VALUES (6,'用户4','asdf',123456,'aasdf','null','asdf');
INSERT INTO `user` VALUES (7,'asdf','asdf',2222,'22','null','22');
INSERT INTO `user` VALUES (8,'asdf','asdf',3333333,'阿迪','null',' aad');
INSERT INTO `user` VALUES (9,'asdf','3333',33333333,'33','null','3');
INSERT INTO `user` VALUES (10,'用户5','5',55,'55','null','55');
INSERT INTO `user` VALUES (11,'wode','sadf',222222,'222','null','2222');
INSERT INTO `user` VALUES (12,'wodedier','wodedier',33333,'33','null','33');
INSERT INTO `user` VALUES (13,'','',0,'','null','');
INSERT INTO `user` VALUES (14,'','',0,'','null','');
INSERT INTO `user` VALUES (15,'','',0,'','null','');
INSERT INTO `user` VALUES (16,'','',0,'','null','');
INSERT INTO `user` VALUES (17,'as','as',0,'','null','');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
