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

CREATE TABLE `t_bb_purchase_order_return_apply` (
  `Fpurchase_order_return_id` varchar(32) NOT NULL COMMENT '采购退货单id',
  `Fpurchase_order_id` varchar(32) NOT NULL COMMENT '采购订单id',
  `Fplan_type` tinyint(2) unsigned NOT NULL COMMENT '计划类型:1-自营分销;2-以销定采;3-BBC自营分销[冗余]',
  `Ftrade_type` tinyint(2) unsigned NOT NULL COMMENT '贸易类型：1一般贸易，2跨境贸易，3国内贸易[冗余]',
  `Fsupplier_id` int(11) unsigned NOT NULL COMMENT '供应商id[冗余]',
  `Fstore_out_id` varchar(32) DEFAULT NULL COMMENT '出库仓id',
  `Freturn_reason` tinyint(2) DEFAULT NULL COMMENT '退货原因:1商品到货破损;2采购取消,3到仓品错误4.其他',
  `Flogistic_type` tinyint(2) unsigned DEFAULT NULL COMMENT '物流方式 1供应商自提;2公司安排送回',
  `Freturn_date` datetime DEFAULT NULL COMMENT '安排退货日期',
  `Freceive_organization` varchar(32) DEFAULT NULL COMMENT '收货组织',
  `Freceive_contact` varchar(32) DEFAULT NULL COMMENT '收货组织联系人',
  `Freceive_contact_phone` varchar(32) DEFAULT NULL COMMENT '收货组织联系人电话',
  `Freturn_organization` varchar(32) DEFAULT NULL COMMENT '退货方',
  `Freturn_contact` varchar(32) DEFAULT NULL COMMENT '退货方联系人',
  `Freturn_contact_phone` varchar(32) DEFAULT NULL COMMENT '退货方联系人电话',
  `Fpurchase_return_status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采购退货单状态 0:草稿  1:待出库  2:已出库 3仓库驳回  5：仓库待确认，6：仓库已驳回',
  `Fpurchase_return_warehouse_refuse_reason` varchar(128) DEFAULT NULL COMMENT '仓库驳回原因',
  `Fremark` longtext COMMENT '备注',
  `Fdecimal` decimal(22,4) DEFAULT NULL,
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fpurchase_order_return_id`),
  UNIQUE KEY `fad` (`Fcreate_time`,`Fmodify_time`) USING BTREE,
  KEY `tbpra-pori-key` (`Fpurchase_order_id`) USING BTREE,
  FULLTEXT KEY `sgs` (`Fremark`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='采购退货单申请';


CREATE TABLE `t_bb_purchase_order_return_sku` (
  `Fpurchase_order_return_sku_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '采购退货单明细id',
  `Fpurchase_order_return_id` varchar(32) NOT NULL COMMENT '采购退货单id',
  `Fsku_id` varchar(32) NOT NULL COMMENT 'SKU商品编码',
  `Freturn_amount` bigint(20) unsigned NOT NULL COMMENT '退货数量',
  `Freturn_out_storage_amount` bigint(20) DEFAULT NULL COMMENT '实际出库数量',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fpurchase_order_return_sku_id`),
  UNIQUE KEY `tbprs-pori-si-unique` (`Fpurchase_order_return_id`,`Fsku_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=utf8mb4 COMMENT='采购退货单SKU明细';
