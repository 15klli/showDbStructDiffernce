/*
Navicat MySQL Data Transfer

Source Server         : 明华-BB3
Source Server Version : 50727
Source Host           : 172.16.16.5:3306
Source Database       : bbtest

Target Server Type    : MYSQL
Target Server Version : 50727
File Encoding         : 65001

Date: 2019-10-31 16:52:15
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_bb_oa_comment
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_oa_comment`;
CREATE TABLE `t_bb_oa_comment` (
  `Fcomment_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '流转意见id',
  `Fprocess_id` int(11) NOT NULL COMMENT '流程id',
  `Foperator_name` varchar(255) NOT NULL COMMENT '操作人员',
  `Freceive_persons_name` varchar(255) NOT NULL COMMENT '意见接收人员',
  `Fremark` varchar(516) NOT NULL COMMENT '流转意见内容',
  `Fhandle_time` datetime NOT NULL COMMENT '处理时间',
  `Foperate_type` tinyint(2) unsigned NOT NULL COMMENT '操作类型,0-退回，1-批准，2-转发，3-提交，4-撤回，5-意见征询，6-转办',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Fcomment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
