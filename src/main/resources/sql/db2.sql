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
  `Fhandle_time` datetime NULL COMMENT '处理时间',
  `Fpayment_desc_page_num` int(11) DEFAULT NULL COMMENT '账期描述合同页码',
  `Foperate_type` tinyint(2) unsigned NOT NULL COMMENT '操作类型,0-退回，1-批准，2-转发，3-提交，4-撤回，5-意见征询，6-转办',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Fcomment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `t_bb_agreement_screenshot` (
  `Fid` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一ID',
  `Fagreement_oa_info_id` int(11) NOT NULL COMMENT '关联供应商ID',
  `Fimg_name` varchar(255) NOT NULL COMMENT '文件名称',
  `Fimg_type` tinyint(2) NOT NULL COMMENT '文件类型（1-发货方式合同截图 2-账期描述合同截图 3-发票类型合同截图 4-结算方式合同截图）',
  `Fimg_url` varchar(255) NOT NULL COMMENT '文件的url',
  `Fis_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '（是否删除 0 否 1 是 ）',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Fid`),
  KEY `tbb_supid_index` (`Fagreement_oa_info_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1239 DEFAULT CHARSET=utf8mb4 COMMENT='供应商企业凭证表，与供应商信息表通过供应商id关联';
