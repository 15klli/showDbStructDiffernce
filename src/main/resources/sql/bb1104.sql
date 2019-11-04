/*
Navicat MySQL Data Transfer

Source Server         : 明华-BB3
Source Server Version : 50727
Source Host           : 172.16.16.5:3306
Source Database       : bb

Target Server Type    : MYSQL
Target Server Version : 50727
File Encoding         : 65001

Date: 2019-11-04 08:56:35
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for pdman_db_version
-- ----------------------------
DROP TABLE IF EXISTS `pdman_db_version`;
CREATE TABLE `pdman_db_version` (
  `DB_VERSION` varchar(256) DEFAULT NULL,
  `VERSION_DESC` varchar(1024) DEFAULT NULL,
  `CREATED_TIME` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for t_bb_admin
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_admin`;
CREATE TABLE `t_bb_admin` (
  `Faid` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `Faccount` varchar(32) NOT NULL COMMENT '登陆账号',
  `Fpassword` varchar(64) NOT NULL COMMENT '登陆密码',
  `Fadmin_status` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '用户状态:1 正常 0 锁定',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Faid`),
  UNIQUE KEY `udx_account` (`Faccount`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- ----------------------------
-- Table structure for t_bb_agreement_oa_additional_info
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_agreement_oa_additional_info`;
CREATE TABLE `t_bb_agreement_oa_additional_info` (
  `Fagreement_oa_info_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `Fagreement_id` varchar(32) NOT NULL COMMENT '合同编号',
  `Fdispatch_way_page_num` int(11) DEFAULT NULL COMMENT '发货方式合同页面',
  `Fpayment_desc_page_num` int(11) DEFAULT NULL COMMENT '账期描述合同页码',
  `Finvioce_type_page_num` int(11) DEFAULT NULL COMMENT '发票类型合同页码',
  `Fsettle_way_page_num` int(11) DEFAULT NULL COMMENT '结算方式合同页码',
  `Fcredit_limit_currency_code` varchar(32) DEFAULT NULL COMMENT '信用额度币种',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Fagreement_oa_info_id`),
  UNIQUE KEY `t_bb_agreement_oa_unique` (`Fagreement_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for t_bb_agreement_screenshot
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_agreement_screenshot`;
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

-- ----------------------------
-- Table structure for t_bb_bid
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_bid`;
CREATE TABLE `t_bb_bid` (
  `Fbid_id` varchar(32) NOT NULL COMMENT '中标单',
  `Fenquiry_id` varchar(32) NOT NULL COMMENT '询价单',
  `Fcategory_id` int(11) NOT NULL COMMENT '分类id',
  `Fplan_type` tinyint(2) NOT NULL COMMENT '计划类型:1-自营分销;2-以销定采;3-BBC自营分销',
  `Fchannel_name` varchar(128) DEFAULT NULL COMMENT '渠道平台名称[渠道询价必填]',
  `Fsale_aid` int(11) NOT NULL COMMENT '销售负责人',
  `Ffeedback_date` date NOT NULL COMMENT '要求反馈时间',
  `Fcurrency_type` varchar(16) NOT NULL COMMENT '货币类型',
  `Ftrade_type` tinyint(2) DEFAULT '1' COMMENT '贸易类型：1一般贸易，2跨境贸易，3国内贸易',
  `Fquotation_method` varchar(16) NOT NULL COMMENT '报价方式:CIF,EXW等，关联贸易术语代码',
  `Fdelivery_address` varchar(255) DEFAULT NULL COMMENT '交货地点',
  `Ftransport_type` tinyint(2) DEFAULT NULL COMMENT '运输方式:1海运,2陆地运输,3空运',
  `Fdelivery_date` date DEFAULT NULL COMMENT '交货时间',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fbid_id`),
  UNIQUE KEY `tbb-ei-unique` (`Fenquiry_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='中标单';

-- ----------------------------
-- Table structure for t_bb_bid_file
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_bid_file`;
CREATE TABLE `t_bb_bid_file` (
  `Ffile_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文件Id',
  `Fbid_id` varchar(255) NOT NULL COMMENT '中标单Id',
  `Fsupplier_id` int(11) NOT NULL COMMENT '供应商Id',
  `Frole` tinyint(11) NOT NULL COMMENT '操作角色: 0 后台管理人员 1 供应商',
  `Ffile_url` varchar(255) DEFAULT NULL COMMENT '文件地址',
  `Ffile_type` tinyint(10) NOT NULL COMMENT '1 上传文件 2 下发文件',
  `Ffile_name` varchar(255) DEFAULT NULL COMMENT '上传文件命名(如 xxx.pdf)',
  `Ffile_description` varchar(255) NOT NULL COMMENT '文件需求名称(如 xxx合同)',
  `Fis_delete` tinyint(10) NOT NULL DEFAULT '0' COMMENT '文件删除标志 (0 未删除, 1 已删除)',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Ffile_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='中标单文件列表';

-- ----------------------------
-- Table structure for t_bb_bid_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_bid_sku`;
CREATE TABLE `t_bb_bid_sku` (
  `Fbid_sku_id` varchar(32) NOT NULL COMMENT '中标单SKUid',
  `Fbid_id` varchar(32) NOT NULL COMMENT '中标单id',
  `Fsku_id` varchar(32) NOT NULL COMMENT 'Fsku_id',
  `Ftarget_number` bigint(20) NOT NULL COMMENT '目标数量',
  `Ftarget_price` bigint(20) NOT NULL COMMENT '目标价格',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fbid_sku_id`),
  UNIQUE KEY `tbbs-bi-si-unique` (`Fbid_id`,`Fsku_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='中标单sku';

-- ----------------------------
-- Table structure for t_bb_bid_sku_supplier
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_bid_sku_supplier`;
CREATE TABLE `t_bb_bid_sku_supplier` (
  `Fsupplier_bid` varchar(32) NOT NULL COMMENT '供应商中标id',
  `Fsupplier_bid_trade_id` varchar(32) NOT NULL COMMENT '供应商中标单交易Id',
  `Fbid_sku_id` varchar(32) NOT NULL COMMENT '中标单skuID',
  `Fsupplier_id` int(11) NOT NULL COMMENT '供应商id',
  `Fquote_num` bigint(11) NOT NULL COMMENT '可售库存[中标单时供应商最新值][可冗余备用]',
  `Fquote_price` bigint(20) NOT NULL COMMENT '供货价格[中标单时供应商最新值][可冗余备用]',
  `Fbid_num` bigint(20) unsigned NOT NULL COMMENT '中标数量',
  `Fbid_price` bigint(20) unsigned NOT NULL COMMENT '中标价格',
  `Fpurchasing_documents` varchar(255) DEFAULT NULL COMMENT '商品凭证',
  `Fterm_validity_begin` date DEFAULT NULL COMMENT '价格有效期(开始)',
  `Fterm_validity_end` date DEFAULT NULL COMMENT '价格有效期(结束)',
  `Fguarantee_period` date NOT NULL COMMENT '商品质保期',
  `Ftimeliness` int(4) NOT NULL COMMENT '出单时效',
  `Fdelivery_time` date DEFAULT NULL COMMENT '交货日期',
  `Fremark` varchar(255) DEFAULT NULL COMMENT '备注',
  `Fsupplier_bid_status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '中标状态:0已中标,1未中标[按理只有中标的才会记录]',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fsupplier_bid`),
  UNIQUE KEY `tbbss-bsi-si-unique` (`Fbid_sku_id`,`Fsupplier_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='中标SKU供应商';

-- ----------------------------
-- Table structure for t_bb_bid_supplier_trade_state
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_bid_supplier_trade_state`;
CREATE TABLE `t_bb_bid_supplier_trade_state` (
  `Fsupplier_bid_trade_id` varchar(32) NOT NULL COMMENT '供应商中标单交易Id',
  `Fsupplier_id` int(11) NOT NULL COMMENT '供应商Id',
  `Fbid_id` varchar(32) NOT NULL,
  `Fenquiry_id` varchar(32) NOT NULL DEFAULT '' COMMENT '询价单Id',
  `Fbid_trade_state` int(255) NOT NULL DEFAULT '0' COMMENT '交易状态:0 待交易,1 交易中, 2 已完成, 3 已取消',
  `Fcreate_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `Fmodify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Fsupplier_bid_trade_id`),
  UNIQUE KEY `tbb-fs-fb-unique` (`Fsupplier_id`,`Fbid_id`) USING BTREE,
  UNIQUE KEY `tbb-fs-ei-unique` (`Fsupplier_id`,`Fenquiry_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='供应商中标单交易状态表';

-- ----------------------------
-- Table structure for t_bb_brand
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_brand`;
CREATE TABLE `t_bb_brand` (
  `Fbrand_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '品牌id',
  `Faid` int(11) unsigned NOT NULL COMMENT '录入/修改人',
  `Forigin_id` int(11) unsigned NOT NULL COMMENT '品牌发源地id',
  `Fbrand_name` varchar(32) NOT NULL DEFAULT '' COMMENT '品牌中文名称',
  `Fbrand_name_eng` varchar(32) NOT NULL DEFAULT '' COMMENT '品牌英文名称',
  `Fbrand_logo` varchar(255) NOT NULL COMMENT '品牌logo',
  `Fbrand_first_letter` varchar(8) DEFAULT '' COMMENT '品牌首字母',
  `Fis_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除 0：否 1：是',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '数据修改时间',
  PRIMARY KEY (`Fbrand_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COMMENT='商品品牌表';

-- ----------------------------
-- Table structure for t_bb_category
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_category`;
CREATE TABLE `t_bb_category` (
  `Fcategory_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '类目id',
  `Fparent_id` int(11) unsigned DEFAULT NULL COMMENT '上级类目id',
  `Fcategory_code` varchar(32) NOT NULL DEFAULT '' COMMENT '类目编码',
  `Fcategory_name` varchar(32) NOT NULL COMMENT '类目名称',
  `Flevel` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '类分级数，0是一级，1是二级 2是三级以此类推',
  `Fsort` int(11) NOT NULL DEFAULT '0' COMMENT '同级类目排序',
  `Fis_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '数据修改时间',
  PRIMARY KEY (`Fcategory_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COMMENT='类目表';

-- ----------------------------
-- Table structure for t_bb_category_purchase
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_category_purchase`;
CREATE TABLE `t_bb_category_purchase` (
  `Fid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `Fcategory_id` int(10) unsigned NOT NULL COMMENT '类目id',
  `Faid` int(10) unsigned NOT NULL COMMENT '员工账号id',
  `Fis_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0否1是',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Fid`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COMMENT='类目的采购负责人';

-- ----------------------------
-- Table structure for t_bb_channel_group
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_channel_group`;
CREATE TABLE `t_bb_channel_group` (
  `Fgroup_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '分组ID',
  `Fgroup_name` varchar(32) NOT NULL COMMENT '分组名称',
  `Fis_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '（是否删除 0 否 1 是 ）',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Fgroup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='供应商自定义分组表';

-- ----------------------------
-- Table structure for t_bb_common_numbers
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_common_numbers`;
CREATE TABLE `t_bb_common_numbers` (
  `Fnumber` varchar(32) NOT NULL COMMENT '编号',
  `Ftype` varchar(64) NOT NULL DEFAULT '' COMMENT '类型',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Ftype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='编号表';

-- ----------------------------
-- Table structure for t_bb_company
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_company`;
CREATE TABLE `t_bb_company` (
  `Fcompany_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `Faid` int(11) DEFAULT NULL COMMENT '运营后台新增账号默认是当前操作人',
  `Faccount_mail` varchar(32) NOT NULL COMMENT '邮件，也是账号',
  `Fpassword` varchar(128) NOT NULL COMMENT '密码',
  `Faccount_phone` varchar(64) NOT NULL COMMENT '企业手机号',
  `Faccount_nick_name` varchar(64) CHARACTER SET utf8 NOT NULL COMMENT '企业名称',
  `Fcontact_name` varchar(64) DEFAULT NULL COMMENT '联系人',
  `Faccount_status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '账号状态 1-正常 2-锁定',
  `Fchannel_audit_status` tinyint(2) NOT NULL DEFAULT '-1' COMMENT '[最新]渠道资料审核状态 -1 未提交审批 0 待补充合作信息 1 待初审 2 初审不通过 3 OA审批中 4 OA审批通过 5 OA审批不通过',
  `Fsupplier_audit_status` tinyint(2) NOT NULL DEFAULT '-1' COMMENT '[最新]供应商资料审核状态-1 未提交审批 0 待补充合作信息 1 待初审 2 初审不通过 3 OA审批中 4 OA审批通过 5 OA审批不通过',
  `Faccount_source` tinyint(2) NOT NULL DEFAULT '0' COMMENT '账号来源（0 供应商注册 1 运营后台注册）',
  `Faccount_code` varchar(64) DEFAULT NULL COMMENT '用户编码（账户唯一值）',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更改时间',
  PRIMARY KEY (`Fcompany_id`),
  UNIQUE KEY `udx_account_mail` (`Faccount_mail`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb4 COMMENT='供应商账号';

-- ----------------------------
-- Table structure for t_bb_company_agreement
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_company_agreement`;
CREATE TABLE `t_bb_company_agreement` (
  `Fagreement_id` varchar(32) NOT NULL COMMENT '协议编号',
  `Fagreement_type` tinyint(2) NOT NULL COMMENT '合同类型;1-采购框架协议；2-销售框架协议',
  `Fcompany_id` int(11) NOT NULL COMMENT '对方公司主体id',
  `Fcorporate_subject_id` int(11) NOT NULL COMMENT '我方公司主体id',
  `Fservice_type` tinyint(2) NOT NULL COMMENT '业务类型；0-BB以销定采；1-bb自营分销',
  `Fprocess_num` varchar(32) NOT NULL DEFAULT '0' COMMENT '流程编号,为0则是还没提交oa审批',
  `Fagreement_edition` tinyint(2) NOT NULL COMMENT '合同版本；0-我方版本；1-对方版本',
  `Fagreemen_is_change` int(11) DEFAULT NULL COMMENT '合同是否有修改',
  `Ftitle` varchar(128) NOT NULL COMMENT '协议标题',
  `Fapply_aid` int(11) NOT NULL COMMENT '申请人',
  `Fname` varchar(32) NOT NULL COMMENT '合同名称',
  `Fsignet_type` tinyint(2) NOT NULL COMMENT '盖章类型；0-公章；1-合同章；2-其他',
  `Fbegin_time` date NOT NULL COMMENT '合同有效期开始',
  `Fend_time` date NOT NULL COMMENT '合同有效期结束',
  `Fagreement_num` int(11) NOT NULL COMMENT '合同份数',
  `Fsku_source` varchar(32) DEFAULT NULL COMMENT '供方来源；0-原厂或原厂指定；1-当地经销商；2-贸易商；3-其他',
  `Four_charger_id` int(11) NOT NULL COMMENT '我方负责人id',
  `Four_charger_phone` varchar(32) NOT NULL COMMENT '我方负责人联系电话',
  `Four_authorize_email` varchar(32) NOT NULL COMMENT '我方授权电子邮箱',
  `Flaw` int(32) NOT NULL COMMENT '适用法律（国家名），关联国家表',
  `Fconflict_handle_way` tinyint(2) NOT NULL COMMENT '争议解决方式；0-仲裁；1-诉讼',
  `Fforum` tinyint(2) DEFAULT NULL COMMENT '仲裁地/管辖地；0-原告所在地；1-被告所在地；2-我方所在地；3-对方所在地；4-其他',
  `Fforum_name` varchar(64) DEFAULT NULL COMMENT '地域名称；仲裁地/管辖地选择其他时填写',
  `Fremark` varchar(255) DEFAULT NULL COMMENT '框架协议备注',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fagreement_id`),
  UNIQUE KEY `t-bb-agreement` (`Fagreement_type`,`Fcompany_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='框架协议表';

-- ----------------------------
-- Table structure for t_bb_company_balance_account
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_company_balance_account`;
CREATE TABLE `t_bb_company_balance_account` (
  `Faccount_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '结算账户ID',
  `Fcompany_id` int(11) NOT NULL COMMENT '关联企业ID',
  `Fpayee_type` tinyint(2) DEFAULT NULL COMMENT '收款人类型（1 个人账户 2 公司账户 3其他）',
  `Fis_oversea_payee` tinyint(2) DEFAULT NULL COMMENT '是否境外收款方（0 否 1是 ）',
  `Fpayee_account` varchar(64) DEFAULT NULL COMMENT '收款人账号',
  `Fpayee_name` varchar(64) DEFAULT NULL COMMENT '收款人户名',
  `Fpayee_bank_name` varchar(255) DEFAULT NULL COMMENT '收款行名称',
  `Fbank_address` varchar(255) DEFAULT NULL COMMENT '开户分行地址',
  `Fswift_code` varchar(64) DEFAULT '' COMMENT 'SWIFT号',
  `Flogistics_direction` varchar(128) NOT NULL COMMENT '货物流向；以<逗号>为分隔符',
  `Fis_need_store` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否需要仓储（0-否 1-是）',
  `Fstore_place` varchar(128) DEFAULT NULL COMMENT '仓储地点；以<逗号>分隔',
  `Fis_need_logistics` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否需要物流（0- 否 1-是 ）',
  `Flogistics_from_to` varchar(128) DEFAULT NULL COMMENT '物流起止地点；以<逗号>分隔',
  `Fdefault_account` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认结算账户（0 否 1 是）',
  `Fis_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '（是否删除 0 否 1 是 ）',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Faccount_id`),
  UNIQUE KEY `t_bb_sup_cur_index` (`Fcompany_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=374 DEFAULT CHARSET=utf8mb4 COMMENT='供应商交易信息表';

-- ----------------------------
-- Table structure for t_bb_company_extention_info
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_company_extention_info`;
CREATE TABLE `t_bb_company_extention_info` (
  `Fcompany_extention_info_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '供应商其他信息主键id',
  `Fcompany_id` int(11) NOT NULL COMMENT '关联企业id',
  `Fgroup_id` int(11) DEFAULT NULL COMMENT '关联企业分组id，供应商则是 supplier_group，渠道则是 channel_group',
  `Fgrade` tinyint(2) NOT NULL COMMENT '企业等级 （0 S 1 A 2 B）',
  `Fcompany_for_short` varchar(64) NOT NULL COMMENT '企业简称',
  `Fcompany_area` tinyint(2) NOT NULL COMMENT '企业区域（0 东南亚 1 香港 2 澳新 3 日韩 4 欧洲 5 其他 6 日本 7 韩国 8 美国 9 中国  10 港澳台）',
  `Fremark` varchar(255) DEFAULT NULL COMMENT '备注',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Fcompany_extention_info_id`),
  UNIQUE KEY `t_bb_company_union_index` (`Fcompany_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=333 DEFAULT CHARSET=utf8mb4 COMMENT='供应商其他信息表';

-- ----------------------------
-- Table structure for t_bb_company_extention_info_temp
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_company_extention_info_temp`;
CREATE TABLE `t_bb_company_extention_info_temp` (
  `Fid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `Fcompany_id` int(11) NOT NULL COMMENT '关联企业id',
  `Fcompany_type` int(11) NOT NULL COMMENT '企业账号对应的业务角色（0-BBC供应商 1-BB供应 商2-渠道客户 3- 资金使用方 4-品牌方）',
  `Fgroup_id` int(11) DEFAULT NULL COMMENT '关联企业分组id，供应商则是 supplier_group，渠道则是 channel_group',
  `Fgrade` tinyint(2) DEFAULT NULL COMMENT '企业等级 （0 S 1 A 2 B）',
  `Fcompany_for_short` varchar(64) DEFAULT NULL COMMENT '企业简称',
  `Fcompany_area` tinyint(2) DEFAULT NULL COMMENT '企业区域（0 东南亚 1 香港 2 澳新 3 日韩 4 欧洲 5 其他 6 日本 7 韩国 8 美国 9 中国  10 港澳台）',
  `Fremark` varchar(255) DEFAULT NULL COMMENT '备注',
  `Fmoney_direction` varchar(64) DEFAULT NULL COMMENT '资金流向；以<br>为分隔符',
  `Fgoods_way` tinyint(2) DEFAULT NULL COMMENT '供应商时为提货方式；0-付款提货；1-先货后款；渠道商时为发货方式，0-先货后款，1-收款发货',
  `Fmoney_way` tinyint(2) DEFAULT NULL COMMENT '[供应商-付款方式][渠道-收款方式]0-电汇；1-信用证；2-银行承兑汇票；3-商业承兑汇票；4-支票；5-抵扣。',
  `Flast_time` int(11) DEFAULT NULL COMMENT '结清款需要的时间',
  `Fpromise_type` tinyint(1) DEFAULT NULL COMMENT '保证金计算方式；0-按比例；1-按金额',
  `Fpromise_percent` int(11) DEFAULT NULL COMMENT '保证金比例；计算方式为比例时填写',
  `Fpromise_money` bigint(20) DEFAULT NULL COMMENT '保证金金额；计算方式为按金额时填写',
  `Fpromise_currency_code` varchar(32) DEFAULT NULL COMMENT '保证金货币类型code',
  `Fearnest_type` tinyint(2) DEFAULT NULL COMMENT '定金计算方式；0-按比例；1-按金额',
  `Fearnest_percent` int(11) DEFAULT NULL COMMENT '定金比例；计算方式为比例时填写',
  `Fearnest_money` bigint(20) DEFAULT NULL COMMENT '定金金额；计算方式为按金额时填写',
  `Fearnest_currency_code` varchar(32) DEFAULT NULL COMMENT '定金货币类型code',
  `Fimprest_type` tinyint(2) DEFAULT NULL COMMENT '预付款计算方式；0-按比例；1-按金额',
  `Fimprest_percent` int(11) DEFAULT NULL COMMENT '预付款比例；计算方式为比例时填写',
  `Fimprest_money` bigint(20) DEFAULT NULL COMMENT '预付款金额；计算方式为按金额时填写',
  `Fimprest_currency_code` varchar(32) DEFAULT NULL COMMENT '预付款货币类型code',
  `Fpayment_describe` tinyint(1) DEFAULT NULL COMMENT '账期描述（0-无账期 1-有账期）',
  `Fpayment_days` int(11) DEFAULT NULL COMMENT '账期天数',
  `Fapply_payment_days` int(11) DEFAULT NULL COMMENT '拟申请账期额度',
  `Fline_of_credit_currency_code` varchar(32) DEFAULT NULL COMMENT '信用额度币种',
  `Fpayment_comment` varchar(1024) DEFAULT NULL COMMENT '付款备注-(付款时间和要求)',
  `Fother_fee_comment` varchar(1024) DEFAULT NULL COMMENT '其他费用收/付款描述',
  `Fdedit_percent` int(11) DEFAULT NULL COMMENT '违约金比率',
  `Fdedit_begin` varchar(32) DEFAULT NULL COMMENT '违约开始日',
  `Finvoice_direction` varchar(64) DEFAULT NULL COMMENT '发票流向；以<br>为分隔符',
  `Finvoice_type` tinyint(2) DEFAULT NULL COMMENT '我方收取/开立发票类型；0-增值税专用发票；1-增值税普通发票；2-形式发票；3-无发票',
  `Ftax_rate_id` int(11) DEFAULT NULL COMMENT '税点id',
  `Ftax_rate` int(11) DEFAULT NULL COMMENT '保存当时的税率值(显示值*100)',
  `Finvoice_time` varchar(32) DEFAULT NULL COMMENT '开票/收票时效（单位：天）',
  `Fsettle_currency_code` varchar(32) DEFAULT NULL COMMENT '结算币种，关联币种code',
  `Faccount_id` int(11) DEFAULT NULL COMMENT '关联公司主体结算账户表；采购协议时是 付款方账户，销售协议时是 收款方账户',
  `Fis_delete` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否删除(0-否 1-是)',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Fid`),
  UNIQUE KEY `t_bb_supp_index` (`Fcompany_id`,`Fcompany_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=348 DEFAULT CHARSET=utf8mb4 COMMENT='运营后台企业合作信息临时表(包含其他信息、结算条款)';

-- ----------------------------
-- Table structure for t_bb_company_group
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_company_group`;
CREATE TABLE `t_bb_company_group` (
  `Fgroup_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '分组ID',
  `Fgroup_name` varchar(32) NOT NULL COMMENT '分组名称',
  `Fgroup_type` varchar(255) DEFAULT NULL COMMENT '（0-BBC供应 1-BB供应 2-渠道 3- 资使）',
  `Fis_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '（是否删除 0 否 1 是 ）',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Fgroup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COMMENT='供应商自定义分组表';

-- ----------------------------
-- Table structure for t_bb_company_info
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_company_info`;
CREATE TABLE `t_bb_company_info` (
  `Fcompany_info_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `Fcompany_id` int(11) NOT NULL COMMENT '企业ID',
  `Fcompany_class` tinyint(2) NOT NULL COMMENT '企业类别（1 境外商超 2 境外贸易商 3 境内贸易商 4 代理商/经销商 5 生产商 6 其他）',
  `Fcompany_kind` tinyint(2) NOT NULL COMMENT '公司性质（1 民营企业 2 外资企业 3 国营企业）',
  `Flegal_person` varchar(32) DEFAULT NULL COMMENT '法人',
  `Fbusiness_license_num` varchar(64) DEFAULT NULL COMMENT '营业执照号',
  `Ftax_regist_num` varchar(64) DEFAULT NULL COMMENT '纳税登记号',
  `Foffice_address` varchar(64) DEFAULT NULL COMMENT '办公室地址',
  `Fcompany_mail_address` varchar(32) NOT NULL COMMENT '公司邮箱',
  `Fcompany_fax` varchar(32) DEFAULT NULL COMMENT '公司传真',
  `Fcompany_fix_tel` varchar(32) NOT NULL COMMENT '公司固定电话',
  `Fcreater` varchar(32) NOT NULL COMMENT '创建人,取当前操作人',
  `Fupdater` varchar(32) NOT NULL COMMENT '修改人,取当前操作人',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Fcompany_info_id`),
  UNIQUE KEY `t_bb_supp_index` (`Fcompany_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=382 DEFAULT CHARSET=utf8mb4 COMMENT='供应商信息表';

-- ----------------------------
-- Table structure for t_bb_company_info_temp
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_company_info_temp`;
CREATE TABLE `t_bb_company_info_temp` (
  `Fid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `Fcompany_id` int(11) NOT NULL COMMENT '企业ID',
  `Fcompany_type` int(11) NOT NULL COMMENT '企业账号对应的业务角色（0-BBC供应商 1-BB供应 商2-渠道客户 3- 资金使用方 4-品牌方）',
  `Fcompany_class` tinyint(2) DEFAULT NULL COMMENT '企业类别（1 境外商超 2 境外贸易商 3 境内贸易商 4 代理商/经销商 5 生产商 6 其他）',
  `Fcompany_kind` tinyint(2) DEFAULT NULL COMMENT '公司性质（1 民营企业 2 外资企业 3 国营企业）',
  `Flegal_person` varchar(32) DEFAULT NULL COMMENT '法人',
  `Fbusiness_license_num` varchar(64) DEFAULT NULL COMMENT '营业执照号',
  `Ftax_regist_num` varchar(64) DEFAULT NULL COMMENT '纳税登记号',
  `Foffice_address` varchar(64) DEFAULT NULL COMMENT '办公室地址',
  `Fcompany_mail_address` varchar(32) DEFAULT NULL COMMENT '公司邮箱',
  `Fcompany_fax` varchar(32) DEFAULT NULL COMMENT '公司传真',
  `Fcompany_fix_tel` varchar(32) DEFAULT NULL COMMENT '公司固定电话',
  `Fcreater` varchar(32) DEFAULT NULL COMMENT '创建人,取当前操作人',
  `Fupdater` varchar(32) DEFAULT NULL COMMENT '修改人,取当前操作人',
  `Flink_name` varchar(32) DEFAULT NULL COMMENT '联系人姓名',
  `Flink_position` varchar(32) DEFAULT '' COMMENT '联系人职务',
  `Flink_mobile` varchar(32) DEFAULT NULL COMMENT '联系人手机号',
  `Flink_mail_address` varchar(32) DEFAULT NULL COMMENT '联系人邮箱',
  `Fdefault_link` tinyint(1) DEFAULT '0' COMMENT '（是否默认联系人 0 否 1 是）',
  `Flink_is_delete` tinyint(1) DEFAULT '0' COMMENT '（联系人是否删除 0 否 1 是 ）',
  `Fcurrency_id` int(11) DEFAULT NULL COMMENT '结算币种，关联币种表id',
  `Fpayee_type` tinyint(2) DEFAULT NULL COMMENT '收款人类型（1 个人账户 2 公司账户 3其他）',
  `Fis_oversea_payee` tinyint(2) DEFAULT NULL COMMENT '是否境外收款方（0 否 1是 ）',
  `Fpayee_account` varchar(64) DEFAULT NULL COMMENT '收款人账号',
  `Fpayee_name` varchar(64) DEFAULT NULL COMMENT '收款人户名',
  `Fpayee_bank_name` varchar(255) DEFAULT NULL COMMENT '收款行名称',
  `Fbank_address` varchar(255) DEFAULT NULL COMMENT '开户分行地址',
  `Fswift_code` varchar(64) DEFAULT '' COMMENT 'SWIFT号',
  `Flogistics_direction` varchar(128) DEFAULT NULL COMMENT '货物流向；以<逗号>为分隔符',
  `Fis_need_store` tinyint(1) DEFAULT NULL COMMENT '是否需要仓储（0-否 1-是）',
  `Fstore_place` varchar(128) DEFAULT NULL COMMENT '仓储地点；以<逗号>分隔',
  `Fis_need_logistics` tinyint(1) DEFAULT NULL COMMENT '是否需要物流（0- 否 1-是 ）',
  `Flogistics_from_to` varchar(128) DEFAULT NULL COMMENT '物流起止地点；以<逗号>分隔',
  `Fdefault_account` tinyint(1) DEFAULT '0' COMMENT '是否默认结算账户（0 否 1 是）',
  `Faccount_is_delete` tinyint(1) DEFAULT '0' COMMENT '（是否删除 0 否 1 是 ）',
  `Fis_delete` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否删除(0-否 1-是)',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Fid`),
  UNIQUE KEY `t_bb_supp_index` (`Fcompany_id`,`Fcompany_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=335 DEFAULT CHARSET=utf8mb4 COMMENT='供应商信息表临时表';

-- ----------------------------
-- Table structure for t_bb_company_link
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_company_link`;
CREATE TABLE `t_bb_company_link` (
  `Flink_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '联系人ID',
  `Fcompany_id` int(11) NOT NULL COMMENT '关联企业ID',
  `Flink_name` varchar(32) NOT NULL COMMENT '联系人姓名',
  `Flink_position` varchar(32) NOT NULL DEFAULT '' COMMENT '联系人职务',
  `Flink_mobile` varchar(32) NOT NULL COMMENT '联系人手机号',
  `Flink_mail_address` varchar(32) NOT NULL COMMENT '联系人邮箱',
  `Fdefault_link` tinyint(1) NOT NULL DEFAULT '0' COMMENT '（是否默认联系人 0 否 1 是）',
  `Fis_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '（是否删除 0 否 1 是 ）',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Flink_id`),
  UNIQUE KEY `tbb_supid_index` (`Fcompany_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=376 DEFAULT CHARSET=utf8mb4 COMMENT='供应商联系人表';

-- ----------------------------
-- Table structure for t_bb_company_operate_log
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_company_operate_log`;
CREATE TABLE `t_bb_company_operate_log` (
  `Fid` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `Fcompany_id` int(11) NOT NULL COMMENT '企业id',
  `Foperate_name` varchar(64) NOT NULL COMMENT '操作人名称',
  `Foperate_type` tinyint(2) NOT NULL COMMENT '操作类型 0 :删除 1:插入 2:更新 3:查询 4:账号登录',
  `Foperate_platform` tinyint(2) NOT NULL COMMENT '业务平台（0：BBC供应商平台 1：BB供应商平台 2：渠道平台 3：资金使用方平台 4：品牌方平台）',
  `Foperate_module` tinyint(2) DEFAULT NULL COMMENT '业务模块',
  `Foperate_business` varchar(255) NOT NULL COMMENT '操作业务内容',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fid`),
  KEY `t_bb_company_index` (`Fcompany_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=398 DEFAULT CHARSET=utf8mb4 COMMENT='企业平台操作日志记录';

-- ----------------------------
-- Table structure for t_bb_company_role
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_company_role`;
CREATE TABLE `t_bb_company_role` (
  `Fid` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `Fcompany_id` int(11) NOT NULL COMMENT '企业账户表ID',
  `Faccount_role` tinyint(2) NOT NULL COMMENT '企业账号对应的业务角色（0-BBC供应商 1-BB供应 商2-渠道客户 3- 资金使用方 4-品牌方）',
  `Finfo_auditor_aid` int(11) unsigned DEFAULT NULL COMMENT '资料审核人；账户角色是供应商时，则为所谓【采购负责人】；账户角色时渠道时，则为所谓【销售负责人】，供应商注册时为null',
  `Fcompany_code` varchar(64) NOT NULL COMMENT '企业编码（每种业务角色的编码不同）',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更改时间',
  PRIMARY KEY (`Fid`),
  UNIQUE KEY `t_bb_company_role_index` (`Fcompany_id`,`Faccount_role`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=202 DEFAULT CHARSET=utf8mb4 COMMENT='企业账号角色表';

-- ----------------------------
-- Table structure for t_bb_company_settlement_info
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_company_settlement_info`;
CREATE TABLE `t_bb_company_settlement_info` (
  `Fsettlement_info_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `Fcompany_id` int(11) NOT NULL COMMENT '公司id',
  `Fcompany_type` tinyint(2) NOT NULL COMMENT '业务类型；（0-BBC供应商 1-BB供应 商2-渠道客户 3- 资金使用方 4-品牌方）',
  `Fmoney_direction` varchar(64) NOT NULL COMMENT '资金流向；以<br>为分隔符',
  `Fgoods_way` tinyint(1) NOT NULL COMMENT '供应商时为提货方式；0-付款提货；1-先货后款；渠道商时为发货方式，0-先货后款，1-收款发货',
  `Fmoney_way` tinyint(2) NOT NULL COMMENT '[供应商-付款方式][渠道-收款方式]0-电汇；1-信用证；2-银行承兑汇票；3-商业承兑汇票；4-支票；5-抵扣。',
  `Flast_time` int(11) DEFAULT NULL COMMENT '结清款需要的时间',
  `Fpromise_type` tinyint(1) NOT NULL COMMENT '保证金计算方式；0-按比例；1-按金额',
  `Fpromise_percent` int(11) DEFAULT NULL COMMENT '保证金比例；计算方式为比例时填写',
  `Fpromise_money` bigint(20) DEFAULT NULL COMMENT '保证金金额；计算方式为按金额时填写',
  `Fpromise_currency_code` varchar(32) DEFAULT NULL COMMENT '保证金货币类型code',
  `Fearnest_type` tinyint(1) NOT NULL COMMENT '定金计算方式；0-按比例；1-按金额',
  `Fearnest_percent` int(11) DEFAULT NULL COMMENT '定金比例；计算方式为比例时填写',
  `Fearnest_money` bigint(20) DEFAULT NULL COMMENT '定金金额；计算方式为按金额时填写',
  `Fearnest_currency_code` varchar(32) DEFAULT NULL COMMENT '定金货币类型code',
  `Fimprest_type` tinyint(1) NOT NULL COMMENT '预付款计算方式；0-按比例；1-按金额',
  `Fimprest_percent` int(11) DEFAULT NULL COMMENT '预付款比例；计算方式为比例时填写',
  `Fimprest_money` bigint(20) DEFAULT NULL COMMENT '预付款金额；计算方式为按金额时填写',
  `Fimprest_currency_code` varchar(32) DEFAULT NULL COMMENT '预付款货币类型code',
  `Fpayment_describe` tinyint(1) NOT NULL DEFAULT '1' COMMENT '账期描述（0-无账期 1-有账期）',
  `Fpayment_days` int(11) DEFAULT NULL COMMENT '账期天数',
  `Fapply_payment_days` int(11) DEFAULT NULL COMMENT '拟申请账期额度',
  `Fline_of_credit_currency_code` varchar(32) DEFAULT NULL COMMENT '信用额度币种',
  `Fpayment_comment` varchar(1024) DEFAULT NULL COMMENT '付款备注-(付款条件和时间要求)',
  `Fother_fee_comment` varchar(1024) DEFAULT NULL COMMENT '其他费用收/付款描述',
  `Fdedit_percent` int(11) DEFAULT NULL COMMENT '违约金比率',
  `Fdedit_begin` varchar(32) DEFAULT NULL COMMENT '违约开始日',
  `Finvoice_direction` varchar(64) NOT NULL COMMENT '发票流向；以<br>为分隔符',
  `Finvoice_type` tinyint(2) NOT NULL COMMENT '我方收取/开立发票类型；0-增值税专用发票；1-增值税普通发票；2-形式发票；3-无发票',
  `Ftax_rate_id` int(11) DEFAULT NULL COMMENT '税率',
  `Ftax_rate` int(11) DEFAULT NULL COMMENT '用于保存当时的税率值',
  `Finvoice_time` varchar(32) DEFAULT NULL COMMENT '开票/收票时效（单位：天）',
  `Fsettle_currency_code` varchar(32) NOT NULL COMMENT '结算币种code',
  `Faccount_id` int(11) NOT NULL COMMENT '关联公司主体结算账户表；采购协议时是 付款方账户，销售协议时是 收款方账户',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fsettlement_info_id`),
  UNIQUE KEY `t_bb_company_index` (`Fcompany_id`,`Fcompany_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=245 DEFAULT CHARSET=utf8mb4 COMMENT='结算条款表';

-- ----------------------------
-- Table structure for t_bb_company_status_his
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_company_status_his`;
CREATE TABLE `t_bb_company_status_his` (
  `Fid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `Femp_job_num` varchar(32) DEFAULT NULL COMMENT '运营后台的审批操作人员工号（供应商平台提交资料为自己）',
  `Fcompany_id` int(11) NOT NULL COMMENT '企业Id，关联企业账户表',
  `Fcompany_type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '企业类型，1：BB供应商资料审核数据 2：渠道客户资料审核数据',
  `Fstatus` tinyint(2) NOT NULL DEFAULT '-1' COMMENT '供应商信息状态（-1 未提交审批 0 待补充合作信息 1 待初审 2 初审不通过 3 OA审批中 4 OA审批通过 5 OA审批不通过）',
  `Fremark` varchar(255) DEFAULT NULL COMMENT '备注（说明）',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Fid`),
  KEY `t_bb_supindex` (`Fcompany_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=831 DEFAULT CHARSET=utf8mb4 COMMENT='供应商信息审核状态记录表';

-- ----------------------------
-- Table structure for t_bb_company_voucher
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_company_voucher`;
CREATE TABLE `t_bb_company_voucher` (
  `Fid` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一ID',
  `Fcompany_id` int(11) NOT NULL COMMENT '关联供应商ID',
  `Fimg_name` varchar(255) DEFAULT NULL COMMENT '文件名称',
  `Fimg_type` tinyint(2) NOT NULL COMMENT '文件类型（1 营业执照扫描件 2 周年申报表/公司续存证明 3 法人身份证正面 4  法人身份证反面 5 产品链路证明 6 历史交易资料 7 其他资料 8 框架协议 ）',
  `Fimg_url` varchar(255) NOT NULL COMMENT '文件的url',
  `Fis_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '（是否删除 0 否 1 是 ）',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Fid`),
  KEY `tbb_supid_index` (`Fcompany_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1196 DEFAULT CHARSET=utf8mb4 COMMENT='供应商企业凭证表，与供应商信息表通过供应商id关联';

-- ----------------------------
-- Table structure for t_bb_corporate_subject
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_corporate_subject`;
CREATE TABLE `t_bb_corporate_subject` (
  `Fcorporate_subject_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id-公司主体id',
  `Fsubject_code` varchar(32) NOT NULL COMMENT '公司代码',
  `Fsubject_name` varchar(128) DEFAULT '' COMMENT '公司名称',
  `Fsubject_dept_id` int(11) unsigned DEFAULT NULL COMMENT '关联部门ID',
  `Fsubject_legal_represent` varchar(64) DEFAULT '' COMMENT '法人代表',
  `Fsubject_property` tinyint(2) unsigned DEFAULT '1' COMMENT '公司性质（1 民营企业 2 外资企业）',
  `Fsubject_business_license` varchar(64) DEFAULT '' COMMENT '统一社会信用代码/营业执照号型',
  `Fsubject_taxpay_num` varchar(64) DEFAULT '' COMMENT '纳税登记号',
  `Fsubject_address` varchar(64) DEFAULT '' COMMENT '公司地址',
  `Fsubject_phone` varchar(32) DEFAULT '' COMMENT '公司固定电话',
  `Fsubject_email` varchar(32) DEFAULT '' COMMENT '邮箱',
  `Fsubject_fax` varchar(32) DEFAULT '' COMMENT '公司传真',
  `Fcreate_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `Fmodify_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `Fcorporate_subject_status` tinyint(2) unsigned DEFAULT '0' COMMENT '状态(0/使用中,1/已冻结)',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fcorporate_subject_id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COMMENT='公司主体基本信息';

-- ----------------------------
-- Table structure for t_bb_corporate_subject_account
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_corporate_subject_account`;
CREATE TABLE `t_bb_corporate_subject_account` (
  `Faccount_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '账户主键Id',
  `Fcorporate_subject_id` int(11) unsigned NOT NULL COMMENT '关联公司主体Id',
  `Faccount_receivable_type` tinyint(2) unsigned DEFAULT NULL COMMENT '收款人类型(0:个人账户 1:公司账户)',
  `Faccount_oversea_receiver` tinyint(2) unsigned DEFAULT '0' COMMENT '是否境外收款方(0-否 1-是)',
  `Faccount_name` varchar(64) DEFAULT '' COMMENT '收款人户名',
  `Faccount_num` varchar(32) DEFAULT NULL COMMENT '收款人账号',
  `Faccount_receive_bank_name` varchar(32) DEFAULT '' COMMENT '收款行名称',
  `Faccount_bank_address` varchar(32) DEFAULT '' COMMENT '银行地址',
  `Faccount_swift_code` varchar(64) DEFAULT NULL COMMENT 'SWIFTCODE',
  `Fcreate_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `Fmodify_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Faccount_id`),
  UNIQUE KEY `t_account_num_uniq` (`Faccount_num`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8mb4 COMMENT='公司主体账户信息';

-- ----------------------------
-- Table structure for t_bb_corporate_subject_contact
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_corporate_subject_contact`;
CREATE TABLE `t_bb_corporate_subject_contact` (
  `Fcorporate_subject_id` int(12) unsigned NOT NULL COMMENT '公司主体Id',
  `Fcontact_duty` varchar(32) DEFAULT NULL COMMENT '职务',
  `Fcontact_name` varchar(32) DEFAULT '' COMMENT '姓名',
  `Fcontact_telephone` varchar(32) DEFAULT '' COMMENT '电话',
  `Fcontact_mobile_phone` varchar(16) DEFAULT '0' COMMENT '手机',
  `Fcontact_email` varchar(64) DEFAULT '' COMMENT '邮箱',
  `Fcreate_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `Fmodify_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fcorporate_subject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='公司主体联系人信息';

-- ----------------------------
-- Table structure for t_bb_currency
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_currency`;
CREATE TABLE `t_bb_currency` (
  `Fcurrency_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '币种id',
  `Fcurrency_code` varchar(16) NOT NULL COMMENT '币种编码',
  `Fcurrency_name` varchar(32) NOT NULL COMMENT '币种名称',
  `Fis_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除 0禁用1启用',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Fcurrency_id`),
  UNIQUE KEY `udx_currency_code` (`Fcurrency_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COMMENT='币种表';

-- ----------------------------
-- Table structure for t_bb_currency_exchange_rate
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_currency_exchange_rate`;
CREATE TABLE `t_bb_currency_exchange_rate` (
  `Fexchange_rate_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '币种汇率id',
  `Fcurrency_id` int(11) unsigned DEFAULT NULL COMMENT '币种id(汇率币种)',
  `Fcurrency_name` varchar(32) DEFAULT NULL COMMENT '币种名称',
  `Ftarget_currency_id` int(11) DEFAULT NULL COMMENT '目标币种id',
  `Fexchange_rate` int(11) unsigned DEFAULT NULL COMMENT '直接汇率: 一百万外币兑人民币(元)',
  `Findirect_exchange_rate` int(11) unsigned DEFAULT NULL COMMENT '间接汇率: 一百万外币兑人民币(元)',
  `Feffective_time` datetime DEFAULT NULL COMMENT '生效时间',
  `Fcreate_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `Fmodify_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `Fexchange_rate_last` int(11) DEFAULT NULL COMMENT '上次汇率',
  `Fis_change` tinyint(2) DEFAULT NULL COMMENT '是否更新(0:否    1:是）',
  `Finvalid_time` datetime DEFAULT NULL COMMENT '失效时间',
  `Fexchange_status` tinyint(2) DEFAULT NULL COMMENT '状态 (0:待确认  1:已确认)',
  `Fexchange_rate_type` tinyint(11) DEFAULT NULL COMMENT '0:固定汇率 1:即期汇率',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Fexchange_rate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18003 DEFAULT CHARSET=utf8mb4 COMMENT='币种汇率表';

-- ----------------------------
-- Table structure for t_bb_department
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_department`;
CREATE TABLE `t_bb_department` (
  `Fdept_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一主键',
  `Fdept_name` varchar(64) CHARACTER SET utf8 NOT NULL COMMENT '部门名称',
  `Fdept_liable_aid` int(11) DEFAULT NULL COMMENT '部门负责人ID',
  `Fdept_observer_aid` varchar(128) DEFAULT NULL COMMENT '工作观察者ID',
  `Fdept_pid` int(11) NOT NULL DEFAULT '0' COMMENT '父节点',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更改时间',
  PRIMARY KEY (`Fdept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COMMENT='部门表';

-- ----------------------------
-- Table structure for t_bb_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_dictionary`;
CREATE TABLE `t_bb_dictionary` (
  `Fdict_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `Fdict_key` varchar(32) NOT NULL COMMENT '字典枚举键, 命名：大写字母加下划线。对应XyDictionaryKeyEnum',
  `Fdict_code` varchar(32) NOT NULL COMMENT '字典值',
  `Fdict_text` varchar(32) NOT NULL COMMENT '字典文本',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Fdict_id`),
  UNIQUE KEY `udx_dic_key_code` (`Fdict_key`,`Fdict_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COMMENT='字典表';

-- ----------------------------
-- Table structure for t_bb_employee
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_employee`;
CREATE TABLE `t_bb_employee` (
  `Femp_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `Faid` int(11) NOT NULL COMMENT '账号ID',
  `Fdept_id` int(11) DEFAULT NULL COMMENT '部门ID',
  `Femp_job_num` varchar(32) NOT NULL COMMENT '工号',
  `Femp_name` varchar(32) NOT NULL COMMENT '名称',
  `Fjob_name` varchar(32) DEFAULT NULL COMMENT '职务',
  `Femp_sex` tinyint(2) unsigned DEFAULT NULL COMMENT '性别 0:女生 1:男生',
  `Femp_head_img` varchar(255) NOT NULL COMMENT '头像',
  `Fremark` varchar(255) DEFAULT NULL COMMENT '描述',
  `Femp_mobile_areacode` varchar(4) DEFAULT NULL COMMENT '电话国际区号',
  `Femp_mobile` varchar(32) DEFAULT NULL COMMENT '手机号码',
  `Femp_state` tinyint(2) NOT NULL DEFAULT '0' COMMENT '员工状态 0-停用 1-启用 2-禁止',
  `Freport_id` varchar(128) NOT NULL COMMENT '汇报对象ID',
  `Femp_mail` varchar(255) DEFAULT NULL COMMENT '邮箱地址',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Femp_id`),
  UNIQUE KEY `udx_faid` (`Faid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COMMENT='员工表';

-- ----------------------------
-- Table structure for t_bb_enquiry
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_enquiry`;
CREATE TABLE `t_bb_enquiry` (
  `Fenquiry_id` varchar(32) NOT NULL COMMENT '询价单id',
  `Fplan_id` varchar(32) NOT NULL COMMENT '采购计划id',
  `Fsale_aid` int(11) NOT NULL COMMENT '销售负责人',
  `Fpurchase_aid` int(11) DEFAULT NULL COMMENT '采购负责人[可能还未分配采购人]',
  `Fcategory_id` int(11) NOT NULL COMMENT '分类id',
  `Fquote_close_date` date DEFAULT NULL COMMENT '报价截止日期',
  `Fenquiry_status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '单据状态:0草稿,1待询价,2报价中,3评标结束,4已关闭，5采购报价待确认、6销售报价待确认、7待确认中标 ',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `Fclose_time` datetime DEFAULT NULL COMMENT '关闭时间',
  PRIMARY KEY (`Fenquiry_id`),
  UNIQUE KEY `tbe-pi-ci-unique` (`Fplan_id`,`Fcategory_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='询价单';

-- ----------------------------
-- Table structure for t_bb_enquiry_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_enquiry_sku`;
CREATE TABLE `t_bb_enquiry_sku` (
  `Fenquiry_sku_id` varchar(32) NOT NULL COMMENT '询价单sku单号',
  `Fenquiry_id` varchar(32) NOT NULL COMMENT '询价单',
  `Fsku_id` varchar(32) NOT NULL COMMENT 'skuid',
  `Ftarget_number` bigint(20) DEFAULT '0' COMMENT '目标数量',
  `Ftarget_price` bigint(20) DEFAULT '0' COMMENT '目标价格',
  `Fpurchase_quote_price` bigint(20) DEFAULT '0' COMMENT '采购报价价格',
  `Fsale_quote_price` bigint(20) DEFAULT '0' COMMENT '销售报价价格',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fenquiry_sku_id`),
  UNIQUE KEY `tbes-ei-si-unique` (`Fenquiry_id`,`Fsku_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='询价单SKU';

-- ----------------------------
-- Table structure for t_bb_finance_order_attachment
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_finance_order_attachment`;
CREATE TABLE `t_bb_finance_order_attachment` (
  `Fid` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一ID',
  `Ffinance_order_id` varchar(32) NOT NULL COMMENT '财务单据id(包含应收/付单id，收/付款单id)',
  `Ffile_name` varchar(255) NOT NULL COMMENT '文件名称',
  `Ffile_url` varchar(255) NOT NULL COMMENT '文件的url',
  `Fis_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '（是否删除 0 否 1 是 ）',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Fid`),
  KEY `tbb_finance_order_index` (`Ffinance_order_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=389 DEFAULT CHARSET=utf8mb4 COMMENT='财务模块单据上传附件表';

-- ----------------------------
-- Table structure for t_bb_finance_order_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_finance_order_sku`;
CREATE TABLE `t_bb_finance_order_sku` (
  `Ffinance_order_sku_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `Ffinance_order_id` varchar(32) NOT NULL COMMENT '应收或应付单id',
  `Fsku_id` varchar(32) NOT NULL COMMENT 'sku编码',
  `Fsku_name` varchar(255) NOT NULL COMMENT 'sku名称',
  `Funit` varchar(20) NOT NULL COMMENT '单位',
  `Fpurchase_amount` bigint(20) unsigned DEFAULT NULL COMMENT '数量',
  `Ftax_included` bigint(20) unsigned DEFAULT NULL COMMENT '含税单价(原币)',
  `Ftax_rate` int(11) unsigned NOT NULL COMMENT '税率',
  `Ftax_amount` bigint(20) unsigned NOT NULL COMMENT '税额(原币)',
  `Ftotal_amount_of_tax` bigint(20) unsigned NOT NULL COMMENT '含税总额(原币)',
  `Fnot_total_amount_of_tax` bigint(20) unsigned NOT NULL COMMENT '不含税总额(原币)',
  `Fis_negative_tax_included` tinyint(1) unsigned DEFAULT NULL COMMENT '是否负数含税单价(原币) (0 否 1是)',
  `Fis_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除  0 否 1 是',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fupdate_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Ffinance_order_sku_id`),
  UNIQUE KEY `t_bb_finace_sku_index` (`Ffinance_order_id`,`Fsku_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=590 DEFAULT CHARSET=utf8mb4 COMMENT='应收应付单对应sku表';

-- ----------------------------
-- Table structure for t_bb_finance_paymentable_order
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_finance_paymentable_order`;
CREATE TABLE `t_bb_finance_paymentable_order` (
  `Ffinance_paymentable_id` varchar(32) NOT NULL COMMENT '应付单单号',
  `Fpurchase_order_id` varchar(32) DEFAULT NULL COMMENT '采购订单号',
  `Fbill_id` varchar(32) DEFAULT NULL COMMENT '出入库单号id',
  `Fpayable_subject_id` int(11) DEFAULT NULL COMMENT '付款主体 id 关联公司主体id',
  `Fcompany_id` int(11) DEFAULT NULL COMMENT '供应商id',
  `Fcorporate_subject_id` int(11) DEFAULT NULL COMMENT '采购主体id 关联公司主体id',
  `Fpurchase_aid` int(11) DEFAULT NULL COMMENT '采购负责人id',
  `Fpayable_type` tinyint(2) DEFAULT '0' COMMENT '应付单类型 0 标准应付单 1 费用应付单',
  `Ffinance_paymentable_type` tinyint(2) DEFAULT '1' COMMENT '单据类型 0 负数应付单  1 正数应付单',
  `Fbill_type` tinyint(1) DEFAULT NULL COMMENT '0 退货单 1 入库通知单',
  `Fnature_of_money` tinyint(2) DEFAULT '0' COMMENT '款项性质 0 货款  1 物流费用  2 收款差异',
  `Fcurrency_code` varchar(16) DEFAULT NULL COMMENT '币种code',
  `Fsettlement_method` tinyint(2) DEFAULT NULL COMMENT '结算付款方式：0-电汇；1-信用证；2-银行承兑汇票；3-商业承兑汇票；4-支票；5-抵扣',
  `Fexchange_rate` int(11) DEFAULT NULL COMMENT '汇率',
  `Fterm_of_payment` tinyint(2) DEFAULT NULL COMMENT '付款条件 0订单生效后付款 1 见提单付款 2 见理货报告付款',
  `Ftotal_price_and_tax` bigint(20) DEFAULT NULL COMMENT '价税合计(转销生成应收单该字段就是本次转销金额)',
  `Fdue_date` date DEFAULT NULL COMMENT '到期日',
  `Fstate` tinyint(2) DEFAULT '0' COMMENT '状态 0 草稿 1 待审批 2已生效 3 已驳回',
  `Freason` varchar(255) DEFAULT NULL COMMENT '驳回原因',
  `Fcollect_money_status` tinyint(2) DEFAULT '0' COMMENT '核销状态 0 未核销  2部分核销  1 全部核销',
  `Fnot_verification_amount` bigint(20) unsigned DEFAULT NULL COMMENT '未核销金额',
  `Fremarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `Fis_resell` tinyint(2) DEFAULT '0' COMMENT '是否转销生成的应付单(0-否 1-是）',
  `Fconversion_relationship_paymentable_id` varchar(32) DEFAULT NULL COMMENT '转销关联应付单id',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更改时间',
  `Fwritten_off_amount` bigint(20) DEFAULT '0' COMMENT '已核销金额',
  PRIMARY KEY (`Ffinance_paymentable_id`),
  KEY `t_bb_payable_index` (`Ffinance_paymentable_id`,`Fpurchase_order_id`,`Fpayable_subject_id`,`Fcompany_id`,`Fcorporate_subject_id`,`Fpurchase_aid`,`Fpayable_type`,`Fcurrency_code`,`Fstate`,`Fis_resell`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='应付单';

-- ----------------------------
-- Table structure for t_bb_finance_payments_setup
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_finance_payments_setup`;
CREATE TABLE `t_bb_finance_payments_setup` (
  `Fpayments_id` int(11) NOT NULL AUTO_INCREMENT,
  `Fpayable_type` tinyint(2) NOT NULL COMMENT '单据类型  0标准应付单 1费用应付单  2标准应收单 3费用应收单',
  `Fcharacter_of_money` varchar(255) DEFAULT NULL COMMENT '款项性质/款项类型',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fupdate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Fpayments_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COMMENT='款项设置';

-- ----------------------------
-- Table structure for t_bb_finance_payment_order
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_finance_payment_order`;
CREATE TABLE `t_bb_finance_payment_order` (
  `Fpayment_order_id` varchar(32) NOT NULL COMMENT '付款单单号',
  `Forder_type` tinyint(2) DEFAULT NULL COMMENT '单据类型  0-付款退款单   1-采购付款申请   2-其他付款',
  `Fpayment_order_status` tinyint(2) DEFAULT NULL COMMENT '状态，0-草稿，1-待审批，2-已生效，3-已驳回',
  `Fpayment_refuse_reason` varchar(64) DEFAULT NULL COMMENT '驳回原因',
  `Fcollection_subject_type` tinyint(2) DEFAULT NULL COMMENT '收款主体类型 (1-供应商，2-渠道客户)',
  `Fsupplier_id` int(11) DEFAULT NULL COMMENT '供应商id',
  `Fcompany_id` int(11) DEFAULT NULL COMMENT '客户id',
  `Fget_money_company_id` int(11) DEFAULT NULL COMMENT '收款主体id',
  `Fpayment_subject_id` int(11) DEFAULT NULL COMMENT '付款主体 id',
  `Fcorporate_subject_id` int(11) DEFAULT NULL COMMENT '采购主体id 关联公司主体id',
  `Fverified_money` bigint(20) unsigned DEFAULT '0' COMMENT '已核销金额。乘于100',
  `Fdisverified_money` bigint(20) unsigned DEFAULT NULL COMMENT '未核销金额',
  `Fverification_status` tinyint(2) DEFAULT '0' COMMENT '核销状态 0:未核销 1:全部核销 2:部分核销',
  `Fsettlement_method` tinyint(2) DEFAULT NULL COMMENT '结算付款方式：0-电汇；1-信用证；2-银行承兑汇票；3-商业承兑汇票；4-支票；5-抵扣',
  `Fpay_money_day` date DEFAULT NULL COMMENT '付款日期',
  `Fis_imprest` tinyint(2) DEFAULT NULL COMMENT '是否是预付款    0-否 1-是',
  `Fmoney_off` int(11) unsigned DEFAULT NULL COMMENT '现金折扣',
  `Fafter_off_money` bigint(20) unsigned DEFAULT NULL COMMENT '折后金额',
  `Flong_short_money` bigint(20) DEFAULT NULL COMMENT '长短款',
  `Fservice_charge` int(11) unsigned DEFAULT NULL COMMENT '手续费',
  `Fpayment_currency_code` varchar(32) DEFAULT NULL COMMENT '结算币种code',
  `Ftotal_price_and_tax` bigint(20) unsigned DEFAULT NULL COMMENT '应付金额',
  `Fmoney_payment_functional_currency` bigint(20) unsigned DEFAULT NULL COMMENT '实付金额本位币',
  `Fcombine_money` bigint(20) unsigned DEFAULT NULL COMMENT '付款金额(乘以10000）',
  `Fmoney_payment` bigint(20) unsigned DEFAULT NULL COMMENT '实付金额',
  `Fpayment_exchange_rate` int(11) DEFAULT NULL COMMENT '结算汇率',
  `Fbank_account_num` varchar(64) DEFAULT NULL COMMENT '我方付款账号',
  `Fbank_account_name` varchar(64) DEFAULT NULL COMMENT '我方付款户名',
  `Fbank_flow_num` varchar(64) DEFAULT NULL COMMENT '银行流水号',
  `Fremark` varchar(128) DEFAULT NULL COMMENT '备注',
  `Fcreate_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `Fwritten_off_amount` bigint(20) DEFAULT '0' COMMENT '已核销金额',
  `Fnot_verification_amount` bigint(20) DEFAULT '0' COMMENT '未核销金额',
  PRIMARY KEY (`Fpayment_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='付款单表格 ';

-- ----------------------------
-- Table structure for t_bb_finance_payment_order_relative
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_finance_payment_order_relative`;
CREATE TABLE `t_bb_finance_payment_order_relative` (
  `Frelative_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '关联主键id',
  `Fpayment_order_id` varchar(32) NOT NULL COMMENT '付款单单号',
  `Fpayment_requisition_id` varchar(32) NOT NULL COMMENT '应付申请单号',
  `Fpurchase_order_id` varchar(32) DEFAULT NULL COMMENT '关联采购订单号',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Frelative_id`)
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8mb4 COMMENT='付款单关联的单';

-- ----------------------------
-- Table structure for t_bb_finance_po_so_relation
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_finance_po_so_relation`;
CREATE TABLE `t_bb_finance_po_so_relation` (
  `Ffinance_return_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '应付/收单入库/退货明细id',
  `Ffinance_order_id` varchar(32) NOT NULL COMMENT '应付/收单号',
  `Fbill_id` varchar(32) NOT NULL COMMENT '出入库单号',
  `Fbill_type` tinyint(1) NOT NULL COMMENT '入库通知类型 0 采购/销售退货单 1 采购入库/销售出库通知单',
  `Ffinance_order_type` tinyint(1) NOT NULL COMMENT '单据类型 0 应付单 1应收单',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新建时间',
  `Fupdate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Ffinance_return_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for t_bb_finance_receivable_order
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_finance_receivable_order`;
CREATE TABLE `t_bb_finance_receivable_order` (
  `Ffinance_receivable_order_id` varchar(32) NOT NULL COMMENT '应收单单号',
  `Fsale_order_id` varchar(32) DEFAULT NULL COMMENT '销售订单号',
  `Fjob_order_id` varchar(32) DEFAULT NULL COMMENT '关联销售出库/退货通知单号',
  `Fjob_order_type` tinyint(2) unsigned DEFAULT NULL COMMENT '通知单类型(1-销售出库通知单 2-销售退货通知单)',
  `Fsale_aid` int(11) unsigned DEFAULT NULL COMMENT '销售负责人id',
  `Fcompany_id` int(11) unsigned DEFAULT NULL COMMENT '关联渠道客户id',
  `Fsale_subject_id` int(11) unsigned DEFAULT NULL COMMENT '销售主体，关联公司主体id',
  `Fgathering_subject_id` int(11) unsigned DEFAULT NULL COMMENT '收款主体id,关联公司主体id',
  `Freceivable_type` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '应收单类型 0 标准应收单 1 费用应收单',
  `Fnature_of_money` tinyint(2) unsigned DEFAULT NULL COMMENT '款项性质 0 货款  1 物流费用  2 收款差异',
  `Fcurrency_code` varchar(16) DEFAULT NULL COMMENT '币种code',
  `Fsettlement_method` tinyint(2) unsigned DEFAULT NULL COMMENT '结算付款方式：0-电汇；1-信用证；2-银行承兑汇票；3-商业承兑汇票；4-支票；5-抵扣',
  `Fexchange_rate` int(11) unsigned DEFAULT NULL COMMENT '汇率',
  `Fterm_of_payment` tinyint(2) unsigned DEFAULT NULL COMMENT '收款条件 0订单生效后收款 1 见提单收款 2 见理货报告收款',
  `Ftotal_price_with_tax` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '价税合计(转销生成应收单该字段就是本次转销金额)',
  `Fdue_date` date DEFAULT NULL COMMENT '到期日',
  `Freceiveable_order_status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '状态 0 草稿 1 待审批 2已生效 3 已驳回',
  `Freason` varchar(255) DEFAULT NULL COMMENT '驳回原因',
  `Fcollect_money_status` tinyint(2) unsigned DEFAULT '0' COMMENT '核销状态 0 未核销 1全部核销  2部分核销 ',
  `Fnot_verification_amount` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '未核销金额(未核销金额=价税合计-已核销金额)',
  `Fwritten_off_amount` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '已核销金额',
  `Fremarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `Fis_resell` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否转销生成的应收单(0-否 1-是）',
  `Fresale_association_order_id` varchar(32) DEFAULT NULL COMMENT '转销生成应收单所关联的应收单单据id(非转销生成为null)',
  `Fis_negative_receivable_order` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否负数应收单(0:是 1:否)',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更改时间',
  PRIMARY KEY (`Ffinance_receivable_order_id`),
  KEY `t_bb_union_index` (`Fsale_order_id`,`Fcompany_id`,`Fsale_subject_id`,`Fgathering_subject_id`,`Fis_resell`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='应收单';

-- ----------------------------
-- Table structure for t_bb_finance_received_order
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_finance_received_order`;
CREATE TABLE `t_bb_finance_received_order` (
  `Freceived_order_id` varchar(32) NOT NULL COMMENT '收款单号',
  `Forder_type` tinyint(2) DEFAULT NULL COMMENT '单据类型.0-销售收款单，1-收款退款单，2-费用收款单，3-费用退款单',
  `Fmoney_order_status` tinyint(2) DEFAULT '0' COMMENT '状态，0-草稿，1-待审批，2-已生效，3-已驳回',
  `Freason` varchar(64) DEFAULT NULL COMMENT '驳回原因',
  `Fverification_status` tinyint(2) DEFAULT '5' COMMENT '5-“/”,0:未核销 1:全部核销 2:部分核销',
  `Fcompany_id` int(11) DEFAULT NULL COMMENT '客户id',
  `Fcompany_type` tinyint(2) DEFAULT NULL COMMENT '1-供应商，2-渠道客户',
  `Fget_money_company_id` int(11) DEFAULT NULL COMMENT '收款主体id',
  `Fpay_money_company_name` varchar(64) DEFAULT NULL COMMENT '付款主体名称',
  `Fsale_company_id` int(11) DEFAULT NULL COMMENT '销售主体id',
  `Freceive_way` tinyint(2) DEFAULT NULL COMMENT '收款方式,0-电汇；1-信用证；2-银行承兑汇票；3-商业承兑汇票；4-支票；5-抵扣',
  `Freceive_day` date DEFAULT NULL COMMENT '收款日期',
  `Fis_advance_pay` tinyint(2) DEFAULT NULL COMMENT '是否是预收款',
  `Fmoney_off` int(11) DEFAULT NULL COMMENT '现金折扣',
  `Fafter_off_money` bigint(20) DEFAULT NULL COMMENT '折后金额',
  `Flong_short_money` bigint(20) DEFAULT NULL COMMENT '长短款',
  `Fservice_charge` int(11) DEFAULT NULL COMMENT '手续费',
  `Fsettle_currency_code` varchar(32) DEFAULT NULL COMMENT '结算币种code',
  `Freceivable_money` bigint(20) DEFAULT NULL COMMENT '应收金额',
  `Freceived_money` bigint(20) unsigned DEFAULT NULL COMMENT '实收金额',
  `Freceived_money_functional_currency` bigint(255) unsigned DEFAULT NULL COMMENT '实收金额本位币',
  `Fexchange_rate` int(11) DEFAULT NULL COMMENT '结算汇率',
  `Fbank_account_num` varchar(64) DEFAULT NULL COMMENT '我方账户账号',
  `Fbank_flow_num` varchar(64) DEFAULT NULL COMMENT '银行流水号',
  `Fremark` varchar(128) DEFAULT NULL COMMENT '备注',
  `Fcreater_aid` int(11) DEFAULT NULL COMMENT '创建人',
  `Fupdater_aid` int(11) DEFAULT NULL COMMENT '修改人',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `Fwritten_off_amount` bigint(20) DEFAULT '0' COMMENT '已核销金额',
  `Fnot_verification_amount` bigint(20) DEFAULT NULL COMMENT '未核销金额',
  `Fcombine_money` bigint(40) unsigned DEFAULT NULL COMMENT '收款金额',
  PRIMARY KEY (`Freceived_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='收款单表格 ';

-- ----------------------------
-- Table structure for t_bb_finance_received_order_relative
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_finance_received_order_relative`;
CREATE TABLE `t_bb_finance_received_order_relative` (
  `Frelative_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `Forder_type` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '关联单号类型，0-销售订单号，1-付款申请单号,2-应收单号',
  `Freceived_order_id` varchar(32) NOT NULL COMMENT '收款单单号',
  `Frelative_order_id` varchar(32) NOT NULL COMMENT '关联的销售订单号或付款申请单号',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Frelative_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COMMENT='收款单关联的单';

-- ----------------------------
-- Table structure for t_bb_finance_verification
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_finance_verification`;
CREATE TABLE `t_bb_finance_verification` (
  `Fverification_id` varchar(32) NOT NULL COMMENT '核销单号',
  `Fbill_type` tinyint(8) DEFAULT NULL COMMENT '单据类型 0:标准核销单 1:预收核销单',
  `Fcompany_name` varchar(64) DEFAULT NULL COMMENT '收款主体',
  `Fverify_status` tinyint(8) DEFAULT NULL COMMENT '状态 0:草稿 1:待审批 2:已驳回 3:已生效',
  `Fverification_type` tinyint(2) unsigned NOT NULL COMMENT '核销单类型 0:应收核销单 1:应付核销单',
  `Fverification_amount` bigint(20) DEFAULT NULL COMMENT '本次核销金额',
  `Fnot_verification_amount` bigint(20) DEFAULT NULL COMMENT '本次剩余未核销金额',
  `Fremark` varchar(255) DEFAULT NULL COMMENT '备注',
  `Fcreate_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更改时间',
  PRIMARY KEY (`Fverification_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='核销表';

-- ----------------------------
-- Table structure for t_bb_finance_verification_collect_pay
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_finance_verification_collect_pay`;
CREATE TABLE `t_bb_finance_verification_collect_pay` (
  `Fcollect_pay_verification_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `Fcollect_pay_type` tinyint(2) DEFAULT NULL COMMENT '收付款类型 0:收款 1:付款',
  `Fverification_id` varchar(32) DEFAULT NULL COMMENT '核销编号',
  `Fcollect_money_type` varchar(255) DEFAULT NULL,
  `Fcollect_pay_id` varchar(32) DEFAULT NULL COMMENT '收付款单号',
  `Fcollect_money_status` tinyint(4) DEFAULT NULL COMMENT '状态 0:未核销 1:全部核销 2:部分核销',
  `Fsale_order_id` varchar(32) DEFAULT NULL COMMENT '销售单号',
  `Fchannel_name` varchar(255) DEFAULT NULL COMMENT '渠道客户名称',
  `Fsales_purchase_name` varchar(255) DEFAULT NULL COMMENT '销售采购主体名称',
  `Freceivable_name` varchar(255) DEFAULT NULL COMMENT '收付款主体名称',
  `Fcurrency` varchar(32) DEFAULT NULL COMMENT '币别',
  `Famount` bigint(20) DEFAULT NULL COMMENT '收付款金额',
  `Fnot_verification_amount` bigint(20) DEFAULT NULL COMMENT '未核销金额',
  `Fverification_amount` bigint(20) DEFAULT NULL COMMENT '已核销金额(原币)',
  `Fnormal_verification_amount` bigint(20) DEFAULT NULL COMMENT '本次正常核销金额(原币)',
  `Fspecial_verification_amount` bigint(20) DEFAULT NULL COMMENT '本次特殊核销金额(原币)',
  `Fsurplus_not_verification_amount` bigint(20) DEFAULT NULL COMMENT '本次剩余未核销金额(原币)',
  `Fcollect_pay_time` datetime DEFAULT NULL COMMENT '收款日期',
  `Frelation` varchar(510) DEFAULT NULL COMMENT '关联',
  `Fcreate_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fcollect_pay_verification_id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for t_bb_finance_verification_receivable_pay
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_finance_verification_receivable_pay`;
CREATE TABLE `t_bb_finance_verification_receivable_pay` (
  `Freceivable_pay_verification_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '应收付核销编号',
  `Freceivable_pay_type` tinyint(2) NOT NULL COMMENT '应收付类型 0:应收 1:应付',
  `Fverification_id` varchar(32) NOT NULL COMMENT '核销编号',
  `Fchannel_name` varchar(64) DEFAULT NULL COMMENT '渠道客户名称',
  `Fsales_purchase_name` varchar(64) DEFAULT NULL COMMENT '销售采购主体名称',
  `Freceivable_name` varchar(64) DEFAULT NULL COMMENT '应收付主题名称',
  `Fcurrency` varchar(32) DEFAULT NULL COMMENT '币别',
  `Freceivable_pay_id` varchar(32) NOT NULL COMMENT '应收收单号',
  `Fsale_order_id` varchar(32) NOT NULL COMMENT '销售单号',
  `Freceivable_amount` bigint(20) DEFAULT NULL COMMENT '应收金额(原币)',
  `Fverification_amount` bigint(20) DEFAULT NULL COMMENT '已核销金额(原币)',
  `Fnormal_verification_amount` bigint(20) DEFAULT NULL COMMENT '本次正常核销金额(原币)',
  `Fspecial_verification_amount` bigint(20) DEFAULT NULL COMMENT '本次特殊核销金额(原币)',
  `Fsurplus_not_verification_amount` bigint(20) DEFAULT NULL COMMENT '本次剩余未核销金额(原币)',
  `Frelation` varchar(510) DEFAULT NULL COMMENT '关联',
  `Fexpire_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '到期日',
  `Fcreate_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Freceivable_pay_verification_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COMMENT='应收核销表';

-- ----------------------------
-- Table structure for t_bb_finance_verification_setup
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_finance_verification_setup`;
CREATE TABLE `t_bb_finance_verification_setup` (
  `Fverification_id` int(11) NOT NULL AUTO_INCREMENT,
  `Fverification_state` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0 关闭 1 开启',
  `Fverification_proportion` int(11) NOT NULL COMMENT '核销比例  乘100 存储',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fupdate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Fverification_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='核销设置';

-- ----------------------------
-- Table structure for t_bb_finance_verification_setup_log
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_finance_verification_setup_log`;
CREATE TABLE `t_bb_finance_verification_setup_log` (
  `Fid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `Faid` int(11) NOT NULL COMMENT '操作人id',
  `Fverification_id` int(11) NOT NULL COMMENT '核销id',
  `Fverification_proportion` int(11) NOT NULL COMMENT '核销比例',
  `Fcreate_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `Fupdate_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Fid`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COMMENT='核销设置修改记录表';

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

-- ----------------------------
-- Table structure for t_bb_oa_process_relative
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_oa_process_relative`;
CREATE TABLE `t_bb_oa_process_relative` (
  `Fid` int(11) NOT NULL AUTO_INCREMENT,
  `Fbill_id` varchar(255) NOT NULL,
  `Fprocess_id` varchar(255) NOT NULL,
  `Fis_delete` tinyint(2) NOT NULL DEFAULT '1' COMMENT '关联关系是否有效，0-无效，1-生效',
  `Fcan_delete` tinyint(2) NOT NULL DEFAULT '1' COMMENT '关联关系是否能删除，0-不可以，1-可以',
  `Fcreate_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fid`)
) ENGINE=InnoDB AUTO_INCREMENT=263 DEFAULT CHARSET=utf8mb4 COMMENT='Oa流程号以及BB3.0系统的关联表';

-- ----------------------------
-- Table structure for t_bb_operate_flow
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_operate_flow`;
CREATE TABLE `t_bb_operate_flow` (
  `Fflow_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `Fbill` varchar(32) NOT NULL COMMENT '单据编号',
  `Faid` int(11) NOT NULL COMMENT '用户id',
  `Fremark` varchar(255) DEFAULT NULL COMMENT '备注',
  `Fflow_type` int(4) DEFAULT NULL COMMENT '类型',
  `Fcreate_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fflow_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1138 DEFAULT CHARSET=utf8mb4 COMMENT='操作流程';

-- ----------------------------
-- Table structure for t_bb_operate_log
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_operate_log`;
CREATE TABLE `t_bb_operate_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `Faid` int(11) NOT NULL COMMENT '操作人id',
  `Foperate_name` varchar(64) NOT NULL COMMENT '操作人名称',
  `Foperate_type` tinyint(2) NOT NULL COMMENT '操作类型 0 :删除 1:插入 2:更新 3:查询',
  `Foperate_module` tinyint(2) NOT NULL COMMENT '运营后台业务模块 0:SSO权限管理 1:商品中心 3:采购中心 4:供应商管理 5:渠道管理 6:订单中心 7:账号管理 8:通知管理 9:财务管理',
  `Foperate_business` varchar(255) NOT NULL COMMENT '操作业务',
  `Foperate_table` varchar(32) DEFAULT NULL COMMENT '操作表',
  `Foperate_field` varchar(32) DEFAULT NULL COMMENT '操作字段',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='操作日志记录';

-- ----------------------------
-- Table structure for t_bb_origin
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_origin`;
CREATE TABLE `t_bb_origin` (
  `Forigin_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '原产地主键id',
  `Faid` int(11) unsigned NOT NULL COMMENT '录入/修改人',
  `Forigin_name_chn` varchar(32) NOT NULL COMMENT '国家名称中文',
  `Forigin_name_eng` varchar(64) NOT NULL COMMENT '国家名称英文',
  `Fnational_flag` varchar(255) NOT NULL COMMENT '国旗',
  `Fis_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除 0：否  1：是',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '数据修改时间',
  PRIMARY KEY (`Forigin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COMMENT='SKU商品原产地';

-- ----------------------------
-- Table structure for t_bb_payment_requisition
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_payment_requisition`;
CREATE TABLE `t_bb_payment_requisition` (
  `Fpayment_requisition_id` varchar(32) NOT NULL COMMENT '付款申请单id',
  `Fpayment_order_id` varchar(32) DEFAULT NULL COMMENT '关联付款单号id',
  `Fpurchase_order_id` varchar(32) NOT NULL COMMENT '关联采购订单号（冗余子表信息）',
  `Fproposer_id` int(11) unsigned NOT NULL COMMENT '申请人id（冗余子表信息）',
  `Fpayment_currency_code` varchar(32) DEFAULT NULL COMMENT '申请付款币别(取编码,冗余子表信息)',
  `Fpayment_subject_name` varchar(32) DEFAULT NULL COMMENT '付款主体公司名称（冗余子表信息）',
  `Fsupplier_name` varchar(64) DEFAULT NULL COMMENT '供应商名称（冗余子表信息）',
  `Fbeneficiary_name` varchar(64) DEFAULT NULL COMMENT '收款行户名（冗余子表信息）',
  `Fdue_bank_account` varchar(64) DEFAULT NULL COMMENT '收款行账号（冗余子表信息）',
  `Fpayment_amount` bigint(20) DEFAULT NULL COMMENT '本次申请付款金额(申请付款币别，冗余子表信息)',
  `Fpayment_time` date DEFAULT NULL COMMENT '最晚付款时间(冗余子表信息)',
  `Fdocument_type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '单据类型1:采购付款申请 2:其他付款',
  `Fpayment_requisition_status` tinyint(2) NOT NULL COMMENT '状态 1：草稿 2：待审批 3：已驳回 4：待付款 5：已付款',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更改时间',
  PRIMARY KEY (`Fpayment_requisition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='付款申请单表';

-- ----------------------------
-- Table structure for t_bb_payment_requisition_basic
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_payment_requisition_basic`;
CREATE TABLE `t_bb_payment_requisition_basic` (
  `Fbasic_info_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '基本信息id',
  `Fpayment_requisition_id` varchar(32) NOT NULL COMMENT '付款申请单id',
  `Fproposer_id` int(11) unsigned NOT NULL COMMENT '申请人id',
  `Fcollection_subject_type` tinyint(2) DEFAULT NULL COMMENT '收款主体类型 1:供应商',
  `Fproposer_name` varchar(64) DEFAULT NULL COMMENT '申请人名称',
  `Fduty` varchar(32) DEFAULT NULL COMMENT '职务',
  `Fproposer_department` varchar(32) DEFAULT NULL COMMENT '申请人部门',
  `Fsubordinate_companies` varchar(64) DEFAULT NULL COMMENT '申请人所属公司名称',
  `Fpayment_subject_id` int(11) DEFAULT NULL COMMENT '付款主体公司id',
  `Fpayment_subject_name` varchar(32) DEFAULT NULL COMMENT '付款主体公司名称',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更改时间',
  PRIMARY KEY (`Fbasic_info_id`),
  UNIQUE KEY `uk_Fpayment_requisition_id` (`Fpayment_requisition_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COMMENT='付款申请单-基本信息表';

-- ----------------------------
-- Table structure for t_bb_payment_requisition_other
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_payment_requisition_other`;
CREATE TABLE `t_bb_payment_requisition_other` (
  `Fother_info_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '其他信息id',
  `Fpayment_requisition_id` varchar(32) NOT NULL COMMENT '付款申请单id',
  `Fremake` varchar(255) DEFAULT NULL COMMENT '备注',
  `Fpayment_purpose` varchar(255) DEFAULT NULL COMMENT '付款事由',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更改时间',
  PRIMARY KEY (`Fother_info_id`),
  UNIQUE KEY `uk_Fpayment_requisition_id` (`Fpayment_requisition_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COMMENT='付款申请单-其他信息表';

-- ----------------------------
-- Table structure for t_bb_payment_requisition_other_attchment
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_payment_requisition_other_attchment`;
CREATE TABLE `t_bb_payment_requisition_other_attchment` (
  `Fid` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '文件id',
  `Fother_info_id` bigint(20) unsigned NOT NULL COMMENT '对应付款申请单-其他信息id',
  `Ffile_url` varchar(255) NOT NULL COMMENT '文件路径',
  `Ffile_type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '文件类型 1:附件 2:ERP单据截图',
  `Ffile_name` varchar(255) DEFAULT NULL COMMENT '文件名',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更改时间',
  PRIMARY KEY (`Fid`),
  KEY `idx_Fother_info_id` (`Fother_info_id`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COMMENT='付款申请单-文件表';

-- ----------------------------
-- Table structure for t_bb_payment_requisition_other_payment
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_payment_requisition_other_payment`;
CREATE TABLE `t_bb_payment_requisition_other_payment` (
  `Fpayment_info_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '付款信息Id',
  `Fpayment_requisition_id` varchar(32) NOT NULL COMMENT '付款申请单id',
  `Fpurchase_order_id` varchar(32) NOT NULL COMMENT '采购订单编号',
  `Fassociated_id` varchar(32) NOT NULL COMMENT '关联合同',
  `Ferp_order_id` varchar(32) DEFAULT NULL COMMENT 'ERP订单号',
  `Fsettlement_conditions` int(11) DEFAULT NULL COMMENT '付款条件付款条件 1：订单生效后付款 2：见提单付款 3：见理货报告付款',
  `Freceipt_of_invoice` tinyint(2) unsigned DEFAULT NULL COMMENT '是否收到发票 0：否1：是',
  `Finvoice_type` tinyint(2) unsigned DEFAULT NULL COMMENT '发票类型0-增值税专用发票；1-增值税普通发票；2-形式发票；3-无发票',
  `Ftax_invoice` int(11) unsigned DEFAULT NULL COMMENT '发票税率 出参乘以1000',
  `Ftrack_the_invoice` tinyint(2) unsigned DEFAULT NULL COMMENT '跟踪发票 0否 1是',
  `Fcurrency_code` varchar(32) DEFAULT NULL COMMENT '币种(取编码)',
  `Faggregate_amount` bigint(20) DEFAULT NULL COMMENT '合同总金额',
  `Fmoney_way` tinyint(2) unsigned DEFAULT NULL COMMENT '付款方式：0-电汇；1-信用证；2-银行承兑汇票；3-商业承兑汇票；4-支票；5-抵扣',
  `Fpayment_type` tinyint(2) unsigned DEFAULT NULL COMMENT '付款类型 1：首款 2：中期款 3：尾款',
  `Fpayment_proportion` int(11) DEFAULT NULL COMMENT '本次申请付款比例',
  `Fcumulative_payment_amount` bigint(20) DEFAULT NULL COMMENT '累计已付款金额（原币）',
  `Fpayment_time` date DEFAULT NULL COMMENT '最晚付款时间',
  `Fpayable_amount` bigint(20) DEFAULT NULL COMMENT '本次应付款金额(原币)',
  `Fafter_balance` bigint(20) DEFAULT NULL COMMENT '本次付款后欠款余额',
  `Fpayment_currency_code` varchar(32) DEFAULT NULL COMMENT '申请付款币别(取编码)',
  `Fpayment_amount` bigint(20) DEFAULT NULL COMMENT '付款金额(申请付款币别)',
  `Fpayment_exchange_rate` int(11) DEFAULT NULL COMMENT '汇率（申请付款币别兑原币汇率）',
  `Flogistics_documents_type` tinyint(2) unsigned DEFAULT NULL COMMENT '物流单据类型 1:物流仓储付款',
  `Factual_payment` bigint(20) DEFAULT NULL COMMENT '实际付款金额',
  `Factual_payment_currency` varchar(32) DEFAULT NULL COMMENT '实际付款币别',
  `Factual_payment_exchange_rate` int(11) DEFAULT NULL COMMENT '实际付款汇率',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更改时间',
  PRIMARY KEY (`Fpayment_info_id`),
  UNIQUE KEY `uk_Fpayment_requisition_id` (`Fpayment_requisition_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COMMENT='付款申请单-其他付款信息表';

-- ----------------------------
-- Table structure for t_bb_payment_requisition_purchase_payment
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_payment_requisition_purchase_payment`;
CREATE TABLE `t_bb_payment_requisition_purchase_payment` (
  `Fpayment_info_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '付款信息Id',
  `Fpayment_requisition_id` varchar(32) NOT NULL COMMENT '付款申请单id',
  `Fpurchase_order_id` varchar(32) NOT NULL COMMENT '采购订单编号',
  `Ferp_order_id` varchar(32) DEFAULT NULL COMMENT 'ERP订单号',
  `Fsettlement_conditions` int(11) DEFAULT NULL COMMENT '付款条件 1：订单生效后付款 2：见提单付款 3：见理货报告付款',
  `Freceipt_of_invoice` tinyint(2) unsigned DEFAULT NULL COMMENT '是否收到发票 0：否1：是',
  `Finvoice_type` tinyint(2) unsigned DEFAULT NULL COMMENT '采购发票类型0-增值税专用发票；1-增值税普通发票；2-形式发票；3-无发票',
  `Ftax_invoice` int(11) unsigned DEFAULT NULL COMMENT '发票税率 出参乘以1000',
  `Ftrack_the_invoice` tinyint(2) unsigned DEFAULT NULL COMMENT '跟踪发票 0否 1是',
  `Fcurrency_code` varchar(32) DEFAULT NULL COMMENT '币种(取编码)',
  `Faggregate_amount` bigint(20) DEFAULT NULL COMMENT '采购总金额/合同总金额',
  `Fmoney_way` tinyint(2) unsigned DEFAULT NULL COMMENT '付款方式：0-电汇；1-信用证；2-银行承兑汇票；3-商业承兑汇票；4-支票；5-抵扣',
  `Fpayment_type` tinyint(2) unsigned DEFAULT NULL COMMENT '付款类型 1：首款 2：中期款 3：尾款',
  `Fpayment_proportion` int(11) DEFAULT NULL COMMENT '本次申请付款比例',
  `Fcumulative_payment_amount` bigint(20) DEFAULT NULL COMMENT '累计已付款金额（原币）',
  `Fpayment_time` date DEFAULT NULL COMMENT '最晚付款时间',
  `Fpayable_amount` bigint(20) DEFAULT NULL COMMENT '本次应付款金额(原币)',
  `Fafter_balance` bigint(20) DEFAULT NULL COMMENT '本次付款后欠款余额',
  `Fpayment_currency_code` varchar(32) DEFAULT NULL COMMENT '申请付款币别(取编码)',
  `Fpayment_amount` bigint(20) DEFAULT NULL COMMENT '付款金额(申请付款币别)',
  `Fpayment_exchange_rate` int(11) DEFAULT NULL COMMENT '汇率（申请付款币别兑原币汇率）',
  `Flogistics_documents_type` tinyint(2) unsigned DEFAULT NULL COMMENT '物流单据类型 1:收料通知单 2：采购入库单 3：预付款无单据',
  `Factual_payment` bigint(20) DEFAULT NULL COMMENT '实际付款金额',
  `Factual_payment_currency` varchar(32) DEFAULT NULL COMMENT '实际付款币别',
  `Factual_payment_exchange_rate` int(11) DEFAULT NULL COMMENT '实际付款汇率',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更改时间',
  PRIMARY KEY (`Fpayment_info_id`),
  UNIQUE KEY `uk_Fpayment_requisition_id` (`Fpayment_requisition_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COMMENT='付款申请单-采购付款信息表';

-- ----------------------------
-- Table structure for t_bb_payment_requisition_receiver
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_payment_requisition_receiver`;
CREATE TABLE `t_bb_payment_requisition_receiver` (
  `Freceiver_info_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '付款方信息id',
  `Fpayment_requisition_id` varchar(32) NOT NULL COMMENT '付款申请单id',
  `Fsupplier_id` int(11) unsigned NOT NULL COMMENT '供应商id',
  `Fsupplier_name` varchar(64) DEFAULT NULL COMMENT '供应商名称',
  `Fpayee_type` tinyint(2) unsigned DEFAULT NULL COMMENT '收款人类型 1:公司账户 2：个人账户（注：默认公司账户）',
  `Foverseas_receiver` tinyint(2) unsigned DEFAULT '0' COMMENT '是否境外收款方：0否1是',
  `Fbeneficiary_name` varchar(64) DEFAULT NULL COMMENT '收款行户名',
  `Fdue_bank_name` varchar(64) DEFAULT NULL COMMENT '收款行名称',
  `Fdue_bank_account` varchar(64) DEFAULT NULL COMMENT '收款行账号',
  `Fbank_address` varchar(128) DEFAULT NULL COMMENT '银行地址',
  `Fswifi_number` varchar(32) DEFAULT NULL COMMENT 'SWIFI号',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更改时间',
  PRIMARY KEY (`Freceiver_info_id`),
  UNIQUE KEY `uk_Fpayment_requisition_id` (`Fpayment_requisition_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COMMENT='付款申请单-付款方信息表';

-- ----------------------------
-- Table structure for t_bb_purchase_order
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_purchase_order`;
CREATE TABLE `t_bb_purchase_order` (
  `Fpurchase_order_id` varchar(32) NOT NULL COMMENT '采购订单编号',
  `Fbid_id` varchar(32) NOT NULL COMMENT '中标单Id',
  `Fsupplier_bid_trade_id` varchar(32) NOT NULL COMMENT '供应商中标单交易Id',
  `Ferp_order_id` varchar(32) DEFAULT NULL COMMENT 'ERP订单号',
  `Fcorporate_subject_id` int(11) unsigned NOT NULL COMMENT '我方公司主体id',
  `Fagreement_id` varchar(32) NOT NULL COMMENT '采购订单关联合同编号',
  `Fsupplier_id` int(11) unsigned NOT NULL COMMENT '供应商id',
  `Fpurchase_aid` int(11) unsigned NOT NULL COMMENT '采购负责人id',
  `Ffinance_id` int(11) unsigned NOT NULL COMMENT '采购订单-财务信息id',
  `Fdelivery_id` int(11) unsigned NOT NULL COMMENT '采购订单-物流信息id',
  `Ftrade_type` tinyint(2) unsigned NOT NULL COMMENT '贸易类型：1一般贸易，2跨境贸易，3国内贸易',
  `Fplan_type` tinyint(2) NOT NULL COMMENT '计划类型:1-自营分销;2-以销定采;3-BBC自营分销',
  `Fquotation_method` varchar(16) NOT NULL COMMENT '报价方式:CIF,EXW等，关联贸易术语代码',
  `Fpurchase_dept_name` varchar(64) DEFAULT '' COMMENT '采购部门名称',
  `Fsupplier_name` varchar(64) DEFAULT NULL COMMENT '供应商公司名称',
  `Fsupplier_leader` varchar(32) DEFAULT NULL COMMENT '供应商方负责人',
  `Fsupplier_leader_phone` varchar(32) DEFAULT NULL COMMENT '供应商负责人手机号',
  `Four_company_name` varchar(64) DEFAULT NULL COMMENT '采购主体',
  `Four_company_leader` varchar(32) DEFAULT NULL COMMENT '我方采购负责人名称',
  `Four_company_leader_phone` varchar(32) DEFAULT NULL COMMENT '我们公司负责人手机号',
  `Fclosing_reasons` tinyint(2) unsigned DEFAULT NULL COMMENT '关闭交易原因 1:下游客户取消订单 2:保质期/数量不满足下游客户需求 3:无法按约定时间交货 4:价格不满足',
  `Fshelf_life` varchar(255) DEFAULT NULL COMMENT '保质期(管理员填写描述，类似备注)',
  `Fsource_area` varchar(255) DEFAULT NULL COMMENT '原产地(管理员填写描述，类似备注)',
  `Fpurchase_order_notes` varchar(255) DEFAULT '' COMMENT '采购订单注释',
  `Fpurchase_order_status` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '采购订单状态1：草稿 2：待销售提交 3：待审批 4：已驳回 5：交易中 6：变更中 7：已完成 8：已关闭',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更改时间',
  PRIMARY KEY (`Fpurchase_order_id`),
  KEY `ik_bid_id` (`Fbid_id`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='采购订单表';

-- ----------------------------
-- Table structure for t_bb_purchase_order_attachment
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_purchase_order_attachment`;
CREATE TABLE `t_bb_purchase_order_attachment` (
  `Fid` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '附件id',
  `Fpurchase_bill_id` varchar(32) NOT NULL COMMENT '采购类单据ID: PO ID，PO变更ID，SO退货ID等等',
  `Fattachment_url` varchar(255) NOT NULL COMMENT '文件存放路径',
  `Fattachment_name` varchar(128) DEFAULT NULL COMMENT '附件名称',
  `Fattachment_size` varchar(16) DEFAULT NULL COMMENT '附件大小，单位KB,M',
  `Fattachment_type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '附件类型 0：其他，1：采购上传附件，2：供应商上传附件,3:采购变更附件 ，4:采购退货附件',
  `Fdata_type` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '数据类型：0：非变更数据 1：变更前数据类型 2：变更后数据类型',
  `Fis_delete` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '是否被删除，0-没被删除，1-被删除',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fid`),
  KEY `tbpoa-pbi-key` (`Fpurchase_bill_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=540 DEFAULT CHARSET=utf8mb4 COMMENT='采购订单-文件存放表';

-- ----------------------------
-- Table structure for t_bb_purchase_order_change
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_purchase_order_change`;
CREATE TABLE `t_bb_purchase_order_change` (
  `Fid` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `Fpurchase_order_change_id` varchar(32) NOT NULL COMMENT '采购订单变更单id',
  `Fpurchase_order_id` varchar(32) NOT NULL COMMENT '采购订单编号',
  `Fpurchase_order_original_order_id` int(11) unsigned NOT NULL COMMENT '采购订单-原订单信息id',
  `Ferp_order_id` varchar(32) DEFAULT NULL COMMENT 'ERP订单号',
  `Ffinance_change_id` int(11) unsigned NOT NULL COMMENT '采购订单-变更财务信息id',
  `Fdelivery_change_id` int(11) unsigned NOT NULL COMMENT '采购订单-变更物流信息id',
  `Fproposer_aid` int(11) unsigned NOT NULL COMMENT '申请人id',
  `Fproposer_date` date NOT NULL COMMENT '申请日期',
  `Fpurchase_order_change_status` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '采购订单状态1：草稿 2：待审批 3：已生效 4：已驳回',
  `Fchange_the_type` varchar(64) DEFAULT NULL COMMENT '变更类型 1：单价 2:数量 3:金额 4: 结算条件5: 交期6 :其他 ',
  `Fimpact` varchar(255) DEFAULT NULL COMMENT '产生影响',
  `Fshelf_life` varchar(255) DEFAULT NULL COMMENT '保质期(管理员填写描述，类似备注)',
  `Fsource_area` varchar(255) DEFAULT NULL COMMENT '原产地(管理员填写描述，类似备注)',
  `Fchange_reason` varchar(255) DEFAULT NULL COMMENT '变更理由',
  `Fdata_type` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '数据类型： 0：变更前数据类型 1：变更后数据类型',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更改时间',
  PRIMARY KEY (`Fid`),
  UNIQUE KEY `uk_poc_data` (`Fpurchase_order_change_id`,`Fdata_type`) USING BTREE,
  KEY `id_po` (`Fpurchase_order_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COMMENT='采购订单-变更信息表';

-- ----------------------------
-- Table structure for t_bb_purchase_order_delivery
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_purchase_order_delivery`;
CREATE TABLE `t_bb_purchase_order_delivery` (
  `Fdelivery_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '采购订单-物流信息id',
  `Ftransport_type` tinyint(2) unsigned DEFAULT '1' COMMENT '采购运输方式  1：海运,2：陆地运输,3：空运',
  `Fdelivery_address` varchar(255) DEFAULT NULL COMMENT '交货目的地',
  `Fdelivery_date` date DEFAULT NULL COMMENT '交货时间/交期',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更改时间',
  PRIMARY KEY (`Fdelivery_id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COMMENT='采购订单-物流信息表';

-- ----------------------------
-- Table structure for t_bb_purchase_order_delivery_change
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_purchase_order_delivery_change`;
CREATE TABLE `t_bb_purchase_order_delivery_change` (
  `Fdelivery_change_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '采购变更单-物流信息id',
  `Ftransport_type` tinyint(2) unsigned DEFAULT '1' COMMENT '采购运输方式  1：海运,2：陆地运输,3：空运',
  `Fdelivery_address` varchar(255) DEFAULT NULL COMMENT '交货目的地',
  `Fdelivery_date` date DEFAULT NULL COMMENT '交货时间/交期',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更改时间',
  PRIMARY KEY (`Fdelivery_change_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COMMENT='采购变更单-物流信息表';

-- ----------------------------
-- Table structure for t_bb_purchase_order_enter_stock
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_purchase_order_enter_stock`;
CREATE TABLE `t_bb_purchase_order_enter_stock` (
  `Fpurchase_order_enter_stock_id` varchar(32) NOT NULL COMMENT '入库单号',
  `Fpurchase_order_id` varchar(32) NOT NULL COMMENT 'po单号',
  `Fsupplier_dispatch_id` varchar(32) NOT NULL COMMENT '发货单号',
  `Fsupplier_id` int(11) unsigned NOT NULL COMMENT '供应商id',
  `Fpurchase_order_enter_stock_time` datetime DEFAULT NULL COMMENT '入库日期',
  `Fpurchase_order_enter_stock_state` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '0-待入库,1-已入库 3-无入库 5：仓库待确认，6：仓库已驳回',
  `Fpurchase_order_enter_stock_warehouse_refuse_reason` varchar(128) DEFAULT NULL COMMENT '仓库驳回原因',
  `Fsupplier_dispatch_state` tinyint(8) DEFAULT NULL COMMENT '状态 0-待确认，1-已确认, 2-已驳回',
  `Fbusiness_type` int(8) unsigned DEFAULT NULL COMMENT '业务类型 1-自营分销;2-以销定采;3-BBC自营分销',
  `Fwarehouse_id` int(8) DEFAULT NULL COMMENT ' 入库仓编号',
  `Freceiver_aid` int(11) DEFAULT NULL COMMENT '收货方id',
  `Fremark` varchar(128) DEFAULT NULL COMMENT '备注',
  `Fcreate_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fpurchase_order_enter_stock_id`),
  UNIQUE KEY `t_supplier_unique` (`Fsupplier_dispatch_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='采购入库通知';

-- ----------------------------
-- Table structure for t_bb_purchase_order_enter_stock_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_purchase_order_enter_stock_sku`;
CREATE TABLE `t_bb_purchase_order_enter_stock_sku` (
  `Fpurchase_order_enter_stock_sku_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '采购入库通知skuid',
  `Fpurchase_order_enter_stock_id` varchar(32) NOT NULL COMMENT '采购入库通知单号',
  `Fsku_id` varchar(32) NOT NULL COMMENT 'skuid',
  `Fdispatch_num` int(11) NOT NULL COMMENT '应收数量',
  `Factual_num` int(11) unsigned DEFAULT NULL COMMENT '实际入库数量',
  `Fbox_size` varchar(32) NOT NULL COMMENT '箱规',
  `Fvalidty_end` date NOT NULL COMMENT '有效期至',
  `Fsku_batch` varchar(32) DEFAULT NULL COMMENT '商品批次号',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fpurchase_order_enter_stock_sku_id`),
  UNIQUE KEY `t_stockid_skuid_unq` (`Fpurchase_order_enter_stock_id`,`Fsku_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4 COMMENT='采购入库通知sku';

-- ----------------------------
-- Table structure for t_bb_purchase_order_finance
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_purchase_order_finance`;
CREATE TABLE `t_bb_purchase_order_finance` (
  `Ffinance_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '采购订单-财务信息id',
  `Fcurrency_code` varchar(16) NOT NULL DEFAULT 'CNY' COMMENT '结算币种编码',
  `Fexchange_rate` int(11) unsigned NOT NULL COMMENT '（生成采购订单时汇率）汇率',
  `Fpurchase_invoice_type` tinyint(2) unsigned NOT NULL DEFAULT '3' COMMENT '采购发票类型；0-增值税专用发票；1-增值税普通发票；2-形式发票；3-无发票',
  `Fwhether_advance_payment` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '是否需要预付款 0：付款提货；1：先货后款',
  `Fnumber_of_settlement` int(11) unsigned DEFAULT NULL COMMENT '结算次数',
  `Fmoney_way` tinyint(2) unsigned DEFAULT NULL COMMENT '采购付款方式：0-电汇；1-信用证；2-银行承兑汇票；3-商业承兑汇票；4-支票；5-抵扣',
  `Fadvance_payment` bigint(20) DEFAULT NULL COMMENT '预付款金额',
  `Fadvance_proportion` int(11) DEFAULT NULL COMMENT '预付款比例',
  `Fadvance_payment_clause` tinyint(2) unsigned DEFAULT NULL COMMENT '预付款条件 1：订单生效后付款 2：见提单付款 3：见理货报告付款',
  `Fthe_first_payment` bigint(20) DEFAULT NULL COMMENT '首款金额',
  `Fthe_first_proportion` int(11) DEFAULT NULL COMMENT '首款比例',
  `Fthe_first_payment_clause` tinyint(2) unsigned DEFAULT NULL COMMENT '首款条件 1：订单生效后付款 2：见提单付款 3：见理货报告付款',
  `Fmetaphase_payment` bigint(20) DEFAULT NULL COMMENT '中期付款金额',
  `Fmetaphase_proportion` int(11) DEFAULT NULL COMMENT '中期付款比例',
  `Fmetaphase_payment_clause` tinyint(2) unsigned DEFAULT NULL COMMENT '中期付款条件 1：订单生效后付款 2：见提单付款 3：见理货报告付款',
  `Ffinal_payment` bigint(20) DEFAULT NULL COMMENT '尾款付款金额',
  `Ffinal_proportion` int(11) DEFAULT NULL COMMENT '尾款付款比例',
  `Ffinal_payment_clause` tinyint(2) unsigned DEFAULT NULL COMMENT '尾款付款条件 1：订单生效后付款 2：见提单付款 3：见理货报告付款',
  `Fadvance_estimated_time_of_payment` date DEFAULT NULL COMMENT '预付款预计付款时间',
  `Fthe_first_estimated_time_of_payment` date DEFAULT NULL COMMENT '首款预计付款时间',
  `Fmetaphase_estimated_time_of_payment` date DEFAULT NULL COMMENT '中期款预计付款时间',
  `Ffinal_estimated_time_of_payment` date DEFAULT NULL COMMENT '尾款预计付款时间',
  `Festimate_purchase_cost` bigint(20) unsigned DEFAULT NULL COMMENT '预估采购费用（原币）',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更改时间',
  PRIMARY KEY (`Ffinance_id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COMMENT='采购订单-财务信息表';

-- ----------------------------
-- Table structure for t_bb_purchase_order_finance_change
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_purchase_order_finance_change`;
CREATE TABLE `t_bb_purchase_order_finance_change` (
  `Ffinance_change_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '采购变更单-财务信息id',
  `Fcurrency_code` varchar(16) NOT NULL DEFAULT 'CNY' COMMENT '结算币种编码',
  `Fexchange_rate` int(11) unsigned DEFAULT NULL COMMENT '（生成采购订单时汇率）汇率',
  `Fpurchase_invoice_type` tinyint(2) unsigned NOT NULL DEFAULT '3' COMMENT '采购发票类型；0-增值税专用发票；1-增值税普通发票；2-形式发票；3-无发票',
  `Fwhether_advance_payment` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '是否需要预付款 0：付款提货；1：先货后款',
  `Fnumber_of_settlement` int(11) unsigned DEFAULT NULL COMMENT '结算次数',
  `Fmoney_way` tinyint(2) unsigned DEFAULT NULL COMMENT '采购付款方式：0-电汇；1-信用证；2-银行承兑汇票；3-商业承兑汇票；4-支票；5-抵扣',
  `Fadvance_payment` bigint(20) DEFAULT NULL COMMENT '预付款金额',
  `Fadvance_proportion` int(11) DEFAULT NULL COMMENT '预付款比例',
  `Fadvance_payment_clause` tinyint(2) unsigned DEFAULT NULL COMMENT '预付款条件  1：订单生效后付款 2：见提单付款 3：见理货报告付款',
  `Fthe_first_payment` bigint(20) DEFAULT NULL COMMENT '首款金额',
  `Fthe_first_proportion` int(11) DEFAULT NULL COMMENT '首款比例',
  `Fthe_first_payment_clause` tinyint(2) unsigned DEFAULT NULL COMMENT '首款条件 1：订单生效后付款 2：见提单付款 3：见理货报告付款',
  `Fmetaphase_payment` bigint(20) DEFAULT NULL COMMENT '中期付款金额',
  `Fmetaphase_proportion` int(11) DEFAULT NULL COMMENT '中期付款比例',
  `Fmetaphase_payment_clause` tinyint(2) unsigned DEFAULT NULL COMMENT '中期付款条件  1：订单生效后付款 2：见提单付款 3：见理货报告付款',
  `Ffinal_payment` bigint(20) DEFAULT NULL COMMENT '尾款付款金额',
  `Ffinal_proportion` int(11) DEFAULT NULL COMMENT '尾款付款比例',
  `Ffinal_payment_clause` tinyint(2) unsigned DEFAULT NULL COMMENT '尾款付款条件 1：订单生效后付款 2：见提单付款 3：见理货报告付款',
  `Fadvance_estimated_time_of_payment` date DEFAULT NULL COMMENT '预付款预计付款时间',
  `Fthe_first_estimated_time_of_payment` date DEFAULT NULL COMMENT '首款预计付款时间',
  `Fmetaphase_estimated_time_of_payment` date DEFAULT NULL COMMENT '中期款预计付款时间',
  `Ffinal_estimated_time_of_payment` date DEFAULT NULL COMMENT '尾款预计付款时间',
  `Festimate_purchase_cost` bigint(20) unsigned DEFAULT NULL COMMENT '预估采购费用（原币）',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更改时间',
  PRIMARY KEY (`Ffinance_change_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COMMENT='采购变更单-财务信息表';

-- ----------------------------
-- Table structure for t_bb_purchase_order_original
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_purchase_order_original`;
CREATE TABLE `t_bb_purchase_order_original` (
  `Foriginal_order_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '变更单-原订单信息id',
  `Foriginal_order_amount` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '原订单数量',
  `Foriginal_order_sum` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '原订单金额',
  `Ftotal_payment_sum` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '累计已付款',
  `Fnot_paid_sum` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '未付款金额',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更改时间',
  PRIMARY KEY (`Foriginal_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COMMENT='变更单-原订单信息表';

-- ----------------------------
-- Table structure for t_bb_purchase_order_return_apply
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_purchase_order_return_apply`;
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
  `Fpurchase_return_status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采购退货单状态 0:草稿  1:待出库  2:已出库   5：仓库待确认，6：仓库已驳回',
  `Fpurchase_return_warehouse_refuse_reason` varchar(128) DEFAULT NULL COMMENT '仓库驳回原因',
  `Fremark` varchar(255) DEFAULT NULL COMMENT '备注',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fpurchase_order_return_id`),
  KEY `tbpra-pori-key` (`Fpurchase_order_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='采购退货单申请';

-- ----------------------------
-- Table structure for t_bb_purchase_order_return_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_purchase_order_return_sku`;
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

-- ----------------------------
-- Table structure for t_bb_purchase_order_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_purchase_order_sku`;
CREATE TABLE `t_bb_purchase_order_sku` (
  `Fpurchase_order_sku_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '采购订单-商品列表id',
  `Fpurchase_order_id` varchar(32) NOT NULL COMMENT '采购订单id',
  `Fsku_id` varchar(32) NOT NULL COMMENT 'sku编码',
  `Fpurchase_amount` bigint(20) unsigned DEFAULT '0' COMMENT '采购数量',
  `Ftax_rate` int(11) unsigned DEFAULT '0' COMMENT '税点 枚举：',
  `Ftax_included` bigint(20) unsigned DEFAULT '0' COMMENT '含税单价(原币)',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更改时间',
  PRIMARY KEY (`Fpurchase_order_sku_id`),
  UNIQUE KEY `tbpos-poi-si-unique` (`Fpurchase_order_id`,`Fsku_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=865 DEFAULT CHARSET=utf8mb4 COMMENT='采购订单-SKU信息表';

-- ----------------------------
-- Table structure for t_bb_purchase_order_sku_change
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_purchase_order_sku_change`;
CREATE TABLE `t_bb_purchase_order_sku_change` (
  `Fpurchase_order_sku_change_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '采购订单-商品列表id',
  `Fpurchase_order_change_id` varchar(32) NOT NULL COMMENT '采购变更单id',
  `Fsku_id` varchar(32) NOT NULL COMMENT 'sku编码',
  `Fpurchase_amount` bigint(20) unsigned DEFAULT '0' COMMENT '采购数量',
  `Fpurchase_tax_rate` int(11) unsigned DEFAULT '0' COMMENT '税率：原始税率 = 100：1，出库除100',
  `Ftax_included` bigint(20) unsigned DEFAULT '0' COMMENT '含税单价(原币)',
  `Fdata_type` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '数据类型： 0：变更前数据类型 1：变更后数据类型',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更改时间',
  PRIMARY KEY (`Fpurchase_order_sku_change_id`),
  UNIQUE KEY `tbposc-poi-si-data-unique` (`Fpurchase_order_change_id`,`Fsku_id`,`Fdata_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=257 DEFAULT CHARSET=utf8mb4 COMMENT='变更单-sku信息表';

-- ----------------------------
-- Table structure for t_bb_purchase_plan
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_purchase_plan`;
CREATE TABLE `t_bb_purchase_plan` (
  `Fplan_id` varchar(32) NOT NULL COMMENT '计划id',
  `Fplan_type` tinyint(2) unsigned NOT NULL COMMENT '计划类型:1-自营分销;2-以销定采;3-BBC自营分销',
  `Fchannel_id` int(11) unsigned DEFAULT NULL COMMENT '渠道id',
  `Fchannel_name` varchar(128) DEFAULT NULL COMMENT '渠道平台名称[渠道询价必填]',
  `Fsale_aid` int(11) unsigned NOT NULL COMMENT '销售负责人',
  `Ffeedback_date` date NOT NULL COMMENT '要求反馈时间',
  `Fcurrency_type` varchar(16) NOT NULL COMMENT '货币类型',
  `Fquotation_method` varchar(16) NOT NULL COMMENT '报价方式:CIF,EXW等，关联贸易术语代码',
  `Fdelivery_address` varchar(255) DEFAULT NULL COMMENT '交货地点',
  `Ftransport_type` tinyint(2) unsigned DEFAULT NULL COMMENT '运输方式:1海运,2陆地运输,3空运',
  `Ftrade_type` tinyint(2) unsigned DEFAULT NULL COMMENT '贸易类型：1一般贸易，2跨境贸易，3国内贸易',
  `Fdelivery_date` date DEFAULT NULL COMMENT '交货时间',
  `Fremark` varchar(255) DEFAULT NULL COMMENT '备注',
  `Fplan_status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '单据状态:0草稿,1询价中,4 全部询单中标,5已关闭,6 部分询单中标',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fplan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='采购计划[备货单和渠道询价单]';

-- ----------------------------
-- Table structure for t_bb_purchase_quote
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_purchase_quote`;
CREATE TABLE `t_bb_purchase_quote` (
  `Fpurchase_quote_id` varchar(32) NOT NULL COMMENT '采购报价id',
  `Fenquiry_id` varchar(32) NOT NULL COMMENT '询价单id',
  `Fsale_aid` int(11) NOT NULL COMMENT '销售负责人',
  `Fpurchase_aid` int(11) NOT NULL COMMENT '采购负责人',
  `Flogistics_fees` bigint(20) DEFAULT NULL COMMENT '物流费用（本位币）',
  `Fcost_of_funds` bigint(20) DEFAULT NULL COMMENT '资金成本(本位币)',
  `Fother_expenses` bigint(20) DEFAULT NULL COMMENT '其他费用（本位币）',
  `Fapportioned_cost` bigint(20) DEFAULT NULL COMMENT '分摊成本（原币）',
  `Festimate_purchase_cost` bigint(20) DEFAULT NULL COMMENT '预估采购总成本（原币）',
  `Fpurchase_quote_status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '采购报价状态:0草稿,1待确认,2已生效,3,已关闭',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fpurchase_quote_id`),
  UNIQUE KEY `tbpq-ei-unique` (`Fenquiry_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='采购报价信息表';

-- ----------------------------
-- Table structure for t_bb_region
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_region`;
CREATE TABLE `t_bb_region` (
  `Fid` int(11) NOT NULL AUTO_INCREMENT COMMENT '无意义自增id',
  `Fadministrative_code` varchar(16) NOT NULL COMMENT '行政区划代码',
  `Farea_name` varchar(32) DEFAULT NULL COMMENT '地区名称',
  `Fparent_administrative_code` varchar(16) DEFAULT NULL COMMENT '父级行政编码 为0则无父级别',
  `Fspell_name` varchar(128) DEFAULT NULL COMMENT '拼写',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fid`),
  UNIQUE KEY `uk_Fadministrative_code` (`Fadministrative_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13446 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for t_bb_sale_order
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sale_order`;
CREATE TABLE `t_bb_sale_order` (
  `Fsale_order_id` varchar(32) NOT NULL COMMENT '销售订单id SO为前缀',
  `Fbid_id` varchar(32) DEFAULT NULL COMMENT '中标单Id',
  `Fenquiry_id` varchar(32) DEFAULT NULL COMMENT '询价单Id',
  `Fsale_aid` int(11) NOT NULL COMMENT '销售负责人Id 框架协议指定负责人',
  `Fsale_dept` varchar(128) DEFAULT NULL COMMENT '销售负责人部门',
  `Fxycompany_id` int(32) unsigned DEFAULT NULL COMMENT '我方公司主体id',
  `Fxycompany_name` varchar(128) DEFAULT NULL COMMENT '我方公司名称',
  `Fsale_name` varchar(128) DEFAULT NULL COMMENT '销售姓名',
  `Fsale_contact` varchar(128) DEFAULT NULL COMMENT '销售联系方式',
  `Fagreement_id` varchar(32) NOT NULL COMMENT '销售框架协议编号',
  `Fcompany_id` int(32) NOT NULL COMMENT '对方公司主体id',
  `Fcompany_name` varchar(128) DEFAULT NULL COMMENT '对方公司名称',
  `Faccount_charge_name` varchar(128) DEFAULT NULL COMMENT '渠道客户负责人姓名',
  `Faccount_charge_contact` varchar(128) DEFAULT NULL COMMENT '渠道客户负责人联系方式',
  `Fcurrency_type` varchar(16) DEFAULT NULL COMMENT '币别',
  `Fplan_type` tinyint(8) NOT NULL DEFAULT '-1' COMMENT '业务类型 :1-自营分销;2-以销定采;3-BBC自营分销',
  `Ftrade_type` tinyint(2) DEFAULT NULL COMMENT '''贸易类型：1 一般贸易，2 跨境贸易(CIF)，3 国内贸易',
  `Fquotation_method` varchar(16) NOT NULL DEFAULT '' COMMENT '报价方式:CIF,EXW等，关联贸易术语代码',
  `Fquality_guarantee_period` varchar(255) DEFAULT NULL COMMENT '保质期',
  `Forigin_place` varchar(255) DEFAULT NULL COMMENT '原产地',
  `Fsummary` varchar(255) DEFAULT NULL COMMENT '内容摘要',
  `Ferp_order_id` varchar(128) DEFAULT NULL COMMENT 'ERP订单Id',
  `Fclose_order_reason` varchar(128) DEFAULT NULL COMMENT '关闭交易原因 0:下游客户取消订单1:保质期/数量不满足下游客户需求2:无法按约定时间交货 3:价格不满足',
  `Fsale_order_status` tinyint(8) NOT NULL DEFAULT '0' COMMENT '销售订单状态 0:草稿 1:待审批 2:已驳回 3:交易中4:变更中 5:已完成 6:已关闭',
  `Fremark` varchar(255) DEFAULT NULL COMMENT '备注',
  `Freject_reason` varchar(255) DEFAULT NULL COMMENT '驳回原因',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fsale_order_id`),
  KEY `Fsale_order_id` (`Fsale_order_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='销售订单';

-- ----------------------------
-- Table structure for t_bb_sale_order_attachment
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sale_order_attachment`;
CREATE TABLE `t_bb_sale_order_attachment` (
  `Ffile_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '销售订单文件Id',
  `Fsale_bill_id` varchar(32) NOT NULL COMMENT '销售单据id :可以为采购订单单号,发货单单号,调拨申请单等等',
  `Fattachment_url` varchar(255) NOT NULL COMMENT '文件存放路径',
  `Fattachment_name` varchar(128) NOT NULL COMMENT '附件名称',
  `Fattachment_size` varchar(16) NOT NULL DEFAULT '0' COMMENT '附件大小',
  `Fattachment_type` tinyint(6) NOT NULL DEFAULT '0' COMMENT '文件类型 0:其他  1:销售订单  2:销售变更后文件 3:销售变更前文件  4:发货通知单  5:理货报告 6：销售发货单文件 7：销售退货单文件 8: 调拨申请单',
  `Fis_delete` tinyint(8) NOT NULL DEFAULT '0' COMMENT '是否删除 0:未删除 1:已删除',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Ffile_id`)
) ENGINE=InnoDB AUTO_INCREMENT=565 DEFAULT CHARSET=utf8mb4 COMMENT='销售订单文件';

-- ----------------------------
-- Table structure for t_bb_sale_order_change
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sale_order_change`;
CREATE TABLE `t_bb_sale_order_change` (
  `fid` int(11) NOT NULL AUTO_INCREMENT,
  `Fsale_order_change_id` varchar(32) NOT NULL COMMENT '销售变更单id SCO为前缀',
  `Fsale_order_id` varchar(32) NOT NULL COMMENT '销售订单id SO为前缀',
  `Fplan_type` tinyint(8) NOT NULL COMMENT '业务类型 :1-自营分销;2-以销定采;3-BBC自营分销',
  `Fcurrency_type` varchar(16) DEFAULT NULL COMMENT '币别',
  `Fquality_guarantee_period` varchar(255) DEFAULT NULL COMMENT '保质期',
  `Forigin_place` varchar(255) DEFAULT NULL COMMENT '原产地',
  `Fsummary` varchar(255) DEFAULT NULL COMMENT '内容摘要',
  `Ferp_order_id` varchar(128) DEFAULT NULL COMMENT 'ERP订单Id',
  `Feffect` varchar(255) DEFAULT NULL COMMENT '产生影响',
  `Fsale_aid` int(11) NOT NULL COMMENT '销售负责人Id 框架协议指定负责人',
  `Fxycompany_id` int(32) unsigned DEFAULT NULL COMMENT '我方公司主体id',
  `Fapplicant_id` int(11) NOT NULL COMMENT '申请人Id',
  `Fapplicant_name` varchar(128) DEFAULT NULL COMMENT '申请人姓名',
  `Fapplicant_dept` varchar(128) DEFAULT NULL COMMENT '申请人部门',
  `Fapplicant_company` varchar(255) DEFAULT NULL COMMENT '申请人所属公司(行云旗下公司)',
  `Fcompany_id` int(11) NOT NULL COMMENT '对方公司主体id(渠道)',
  `Fcompany_name` varchar(128) DEFAULT NULL COMMENT '对方公司主体id',
  `Foriginal_order_sku_num` bigint(20) DEFAULT NULL COMMENT '原销售订单SKU总数量',
  `Foriginal_order_total_amount` bigint(20) DEFAULT NULL COMMENT '原订单总金额()',
  `Famount_receipt` bigint(20) DEFAULT NULL COMMENT '累计已收款',
  `Famount_not_receipt` bigint(20) DEFAULT NULL COMMENT '未收款金额',
  `Fremark` varchar(255) DEFAULT NULL COMMENT '备注',
  `Fchange_reason` varchar(255) DEFAULT NULL COMMENT '变更理由',
  `Fchange_content` tinyint(16) DEFAULT NULL COMMENT '变更内容 0:其他 1:单价 2:数量 3:金额 4:结算条件 5:交期',
  `Freject_reason` varchar(255) DEFAULT NULL COMMENT '驳回原因',
  `Fsale_order_change_status` tinyint(8) NOT NULL DEFAULT '0' COMMENT '销售变更单状态 0:草稿 1:待审批 2:已驳回 3:已生效4:已关闭',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`fid`),
  UNIQUE KEY `tbsoc_soci_Unique` (`Fsale_order_change_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COMMENT='销售变更单';

-- ----------------------------
-- Table structure for t_bb_sale_order_delivery_apply
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sale_order_delivery_apply`;
CREATE TABLE `t_bb_sale_order_delivery_apply` (
  `Fsale_delivery_id` varchar(32) NOT NULL COMMENT '销售发货单id',
  `Fsale_order_id` varchar(32) NOT NULL COMMENT '销售订单id',
  `Ftrade_term` varchar(32) DEFAULT NULL COMMENT '贸易术语',
  `Fstore_out_id` varchar(32) DEFAULT NULL COMMENT '出仓库id',
  `Fsale_delivery_status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '销售发货单状态 0:草稿  1:待审批  2:待出库  3:已出库  4:已驳回  5：待仓库确认  6：仓库已驳回',
  `Fsale_delivery_warehouse_refuse_reason` varchar(128) DEFAULT NULL COMMENT '仓库驳回原因',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fsale_delivery_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='销售发货申请 ';

-- ----------------------------
-- Table structure for t_bb_sale_order_delivery_financial_info
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sale_order_delivery_financial_info`;
CREATE TABLE `t_bb_sale_order_delivery_financial_info` (
  `Fsale_delivery_financia_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '销售发货财务id',
  `Fsale_delivery_id` varchar(32) NOT NULL COMMENT '销售发货单id',
  `Fsettlement_currency_type` varchar(16) NOT NULL COMMENT '结算币别',
  `Fexchange_rate` int(11) NOT NULL COMMENT '汇率',
  `Fis_Tax` tinyint(2) NOT NULL COMMENT '是否含税 是否含税 0:是 1:否',
  `Fsale_total_amount_without_tax_original_currency` bigint(20) NOT NULL COMMENT '销售不含税总金额（原币）',
  `Ftax_amount_original_currency` bigint(20) NOT NULL COMMENT '税额（原币）',
  `Fsale_total_amount_include_tax_original_currency` bigint(20) NOT NULL COMMENT '价税合计（原币）',
  `Fpayment_method` tinyint(8) NOT NULL COMMENT '销售收款方式',
  `Fsale_cost_currency_type` varchar(16) NOT NULL COMMENT '已收款金额（币别）',
  `Fsale_amount_received` bigint(20) NOT NULL COMMENT '已收款金额',
  `Fcollection_ratio` int(11) NOT NULL COMMENT '已收款比率',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fsale_delivery_financia_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='销售发货财务信息';

-- ----------------------------
-- Table structure for t_bb_sale_order_delivery_sku_info
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sale_order_delivery_sku_info`;
CREATE TABLE `t_bb_sale_order_delivery_sku_info` (
  `Fsale_delivery_detail_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '销售发货详情id',
  `Fsale_delivery_id` varchar(32) NOT NULL COMMENT '销售发货单id',
  `Fsku_id` varchar(32) NOT NULL COMMENT 'SKU商品编码',
  `Fsale_delivery_store_num` varchar(32) DEFAULT NULL COMMENT '入仓号(非必填)',
  `Fsale_num` bigint(20) DEFAULT NULL COMMENT '销售数量',
  `Fsale_delivery_amount` bigint(20) DEFAULT NULL COMMENT '发货数量',
  `Fsale_delivery_out_storage_amount` bigint(20) DEFAULT NULL COMMENT '实际出库数量',
  `Ftax_rate` smallint(4) DEFAULT NULL COMMENT '税率 tax_rate =Ftax_rate/10000',
  `Fsale_delivery_expiration` datetime DEFAULT NULL COMMENT '保质期',
  `Fprice_including_tax_original_currency` bigint(20) DEFAULT NULL COMMENT '单价',
  `Fsale_total_amount_include_tax_original_currency` bigint(20) DEFAULT NULL COMMENT '小计',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fsale_delivery_detail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=utf8mb4 COMMENT='销售发货SKU详情';

-- ----------------------------
-- Table structure for t_bb_sale_order_delivery_term
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sale_order_delivery_term`;
CREATE TABLE `t_bb_sale_order_delivery_term` (
  `Fdelivery_term_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '销售订单交货方式Id',
  `Fsale_order_id` varchar(32) NOT NULL COMMENT '销售订单id SO为前缀',
  `Fdelivery_date` date DEFAULT NULL COMMENT '交货时间',
  `Fdelivery_address` varchar(128) DEFAULT NULL COMMENT '交货地点',
  `Ftransport_type` tinyint(4) DEFAULT NULL COMMENT '运输方式:1海运,2陆地运输,3空运',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fdelivery_term_id`)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8mb4 COMMENT='销售订单交货方式';

-- ----------------------------
-- Table structure for t_bb_sale_order_delivery_term_change
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sale_order_delivery_term_change`;
CREATE TABLE `t_bb_sale_order_delivery_term_change` (
  `Fdelivery_term_change_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '销售订单交货方式Id',
  `Fsale_order_change_id` varchar(32) NOT NULL COMMENT '销售变更单id SCO为前缀',
  `Fdelivery_date` date DEFAULT NULL COMMENT '交货时间',
  `Fdelivery_address` varchar(128) DEFAULT NULL COMMENT '交货地点',
  `Ftransport_type` tinyint(4) DEFAULT NULL COMMENT '运输方式:1海运,2陆地运输,3空运',
  `Fdata_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '数据类型：0：变更前数据类型 1：变更后数据类型',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fdelivery_term_change_id`),
  UNIQUE KEY `tbsodtc-soci-Unique` (`Fsale_order_change_id`,`Fdata_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COMMENT='销售变更单交货方式';

-- ----------------------------
-- Table structure for t_bb_sale_order_details_change
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sale_order_details_change`;
CREATE TABLE `t_bb_sale_order_details_change` (
  `Ffinance_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '销售变更明细Id',
  `Fsale_order_change_id` varchar(32) NOT NULL COMMENT '销售变更单id SCO为前缀',
  `Fchange_content` varchar(64) NOT NULL COMMENT '变更内容 0:其他 1:单价 2:数量 3:金额 4:结算条件 5:交期',
  `Fchange_reason` varchar(255) NOT NULL COMMENT '变更理由',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Ffinance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='销售变更明细';

-- ----------------------------
-- Table structure for t_bb_sale_order_finance
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sale_order_finance`;
CREATE TABLE `t_bb_sale_order_finance` (
  `Ffinance_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '销售订单财务信息Id',
  `Fsale_order_id` varchar(32) NOT NULL COMMENT '销售订单id SO为前缀',
  `Fsettlement_currency_type` varchar(16) DEFAULT NULL COMMENT '结算币别',
  `Fexchange_rate` int(11) DEFAULT NULL COMMENT '直接汇率: 一百万外币兑人民币(元)',
  `Fsale_invoice_type` tinyint(8) DEFAULT NULL COMMENT '销售发票类型 0:增值税专用发票1:增值税普通发票2:形式发票3:无发票',
  `Fsale_total_amount_without_tax_original_currency` bigint(20) DEFAULT '0' COMMENT '销售不含税总金额（原币）',
  `Fsale_total_amount_without_tax_functional_currency` bigint(20) DEFAULT '0' COMMENT '销售不含税总金额（本位币）',
  `Ftax_amount_original_currency` bigint(20) DEFAULT '0' COMMENT '税额(原币)',
  `Ftax_amount_functional_currency` bigint(20) DEFAULT NULL COMMENT '税额(本位币)',
  `Fsale_total_amount_include_tax_original_currency` bigint(20) DEFAULT '0' COMMENT '价税合计（原币）',
  `Fsale_total_amount_include_tax_functional_currency` bigint(20) DEFAULT '0' COMMENT '价税合计（本位币）',
  `Fitem_received_in_advance` tinyint(8) DEFAULT NULL COMMENT '是否需要预收款 0:否 1:是',
  `Fsettlement_frequency` int(4) DEFAULT NULL COMMENT '结算次数 1,2,3',
  `Fpayment_method` tinyint(8) DEFAULT NULL COMMENT '销售收款方式 0:电汇1:信用证2:银行承兑汇票3:商业承兑汇票4:支票5:抵扣',
  `Fpre_gather_amount` bigint(20) DEFAULT '0' COMMENT '预收款金额',
  `Fpre_gather_date` date DEFAULT NULL COMMENT '预收款预计收款时间',
  `Fpre_gather_condition` tinyint(8) DEFAULT NULL COMMENT '预收款条件 0:订单生效后收款1:见提单收款2:见理货报告收款',
  `Fmidterm_gather_amount` bigint(20) DEFAULT '0' COMMENT '中期款金额',
  `Fmidterm_gather_date` date DEFAULT NULL COMMENT '中期款预计收款时间',
  `Fmidterm_gather_condition` tinyint(8) DEFAULT NULL COMMENT '中期收款条件 0:订单生效后收款1:见提单收款2:见理货报告收款',
  `Frest_gather_amount` bigint(20) DEFAULT '0' COMMENT '尾款金额',
  `Frest_gather_date` date DEFAULT NULL COMMENT '尾款预计收款时间',
  `Frest_gather_condition` tinyint(8) DEFAULT NULL COMMENT '尾款收款条件 0:订单生效后收款1:见提单收款2:见理货报告收款',
  `Fsale_cost_currency_type` varchar(16) DEFAULT 'CNY' COMMENT '销售费用币别',
  `Festimated_sale_cost_original_currency` bigint(20) DEFAULT '0' COMMENT '预估销售费用（原币）',
  `Festimated_sale_cost_functional_currency` bigint(20) DEFAULT '0' COMMENT '预估销售费用（本位币）',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Ffinance_id`)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8mb4 COMMENT='销售订单财务信息';

-- ----------------------------
-- Table structure for t_bb_sale_order_finance_change
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sale_order_finance_change`;
CREATE TABLE `t_bb_sale_order_finance_change` (
  `Ffinance_change_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '销售订单财务信息Id',
  `Fsale_order_change_id` varchar(32) NOT NULL COMMENT '销售变更单id SCO为前缀',
  `Fsettlement_currency_type` varchar(16) DEFAULT NULL COMMENT '结算币别',
  `Fexchange_rate` int(11) DEFAULT NULL COMMENT '直接汇率: 一百万外币兑人民币(元)',
  `Fsale_invoice_type` tinyint(8) DEFAULT NULL COMMENT '销售发票类型 0:增值税专用发票1:增值税普通发票2:形式发票3:无发票',
  `Fsale_total_amount_without_tax_original_currency` bigint(20) DEFAULT NULL COMMENT '销售不含税总金额（原币）',
  `Fsale_total_amount_without_tax_functional_currency` bigint(20) DEFAULT NULL COMMENT '销售不含税总金额（本位币）',
  `Ftax_amount_original_currency` bigint(20) DEFAULT NULL COMMENT '税额(原币)',
  `Ftax_amount_functional_currency` bigint(20) DEFAULT NULL COMMENT '税额(本位币)',
  `Fsale_total_amount_include_tax_original_currency` bigint(20) DEFAULT NULL COMMENT '价税合计（原币）',
  `Fsale_total_amount_include_tax_functional_currency` bigint(20) DEFAULT NULL COMMENT '价税合计（本位币）',
  `Fitem_received_in_advance` tinyint(8) DEFAULT NULL COMMENT '是否需要预收款 0:否 1:是',
  `Fsettlement_frequency` int(11) DEFAULT NULL COMMENT '结算次数 1,2,3',
  `Fpayment_method` tinyint(8) DEFAULT NULL COMMENT '销售收款方式 0:电汇1:信用证2:银行承兑汇票3:商业承兑汇票4:支票5:抵扣',
  `Fpre_gather_amount` bigint(20) DEFAULT NULL COMMENT '预收款比例',
  `Fpre_gather_date` date DEFAULT NULL COMMENT '预收款预计收款时间',
  `Fpre_gather_condition` tinyint(8) DEFAULT NULL COMMENT '预收款条件 0:订单生效后收款1:见提单收款2:见理货报告收款',
  `Fmidterm_gather_amount` bigint(20) DEFAULT NULL COMMENT '中期款比例',
  `Fmidterm_gather_date` date DEFAULT NULL COMMENT '中期款预计收款时间',
  `Fmidterm_gather_condition` tinyint(8) DEFAULT NULL COMMENT '中期收款条件 0:订单生效后收款1:见提单收款2:见理货报告收款',
  `Frest_gather_amount` bigint(20) DEFAULT NULL COMMENT '尾款比例',
  `Frest_gather_date` date DEFAULT NULL COMMENT '尾款预计收款时间',
  `Frest_gather_condition` tinyint(8) DEFAULT NULL COMMENT '尾款收款条件 0:订单生效后收款1:见提单收款2:见理货报告收款',
  `Fsale_cost_currency_type` varchar(8) DEFAULT 'CNY' COMMENT '销售费用币别',
  `Festimated_sale_cost_original_currency` bigint(20) DEFAULT NULL COMMENT '预估销售费用（原币）',
  `Festimated_sale_cost_functional_currency` bigint(20) DEFAULT NULL COMMENT '预估销售费用（本位币）',
  `Fdata_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '数据类型：0：变更前数据类型 1：变更后数据类型',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Ffinance_change_id`),
  UNIQUE KEY `tbsofc-soci-dt` (`Fsale_order_change_id`,`Fdata_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COMMENT='销售变更单财务信息';

-- ----------------------------
-- Table structure for t_bb_sale_order_logistic_info
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sale_order_logistic_info`;
CREATE TABLE `t_bb_sale_order_logistic_info` (
  `Fsale_logistic_id` varchar(32) NOT NULL COMMENT '销售物流id',
  `Fsale_delivery_id` varchar(32) NOT NULL COMMENT '销售发货单id',
  `Fsale_receive_organization` varchar(32) DEFAULT NULL COMMENT '收货方',
  `Fsale_receive_contact` varchar(32) DEFAULT NULL COMMENT '收货方联系人',
  `Fsale_receive_contact_phone` varchar(32) DEFAULT NULL COMMENT '收货方联系人电话',
  `Fsale_receive_address` varchar(32) DEFAULT NULL COMMENT '收货地址',
  `Fdelivery_date` datetime DEFAULT NULL COMMENT '要求到货日期',
  `Ftransport_type` tinyint(2) DEFAULT NULL COMMENT '运输方式 运输方式:1海运,2陆地运输,3空运',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fsale_logistic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='销售物流信息';

-- ----------------------------
-- Table structure for t_bb_sale_order_refund_application
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sale_order_refund_application`;
CREATE TABLE `t_bb_sale_order_refund_application` (
  `Frefund_application_id` varchar(255) NOT NULL DEFAULT '' COMMENT '退款申请id',
  `Fsale_order_id` varchar(32) NOT NULL COMMENT '关联销售订单id',
  `Fpayment_order_id` varchar(32) DEFAULT NULL COMMENT '关联付款单单号(收款退款单号)',
  `Frefund_type` tinyint(2) NOT NULL COMMENT '退款单据类型 0:销售退款申请 1:其他退款申请',
  `Faccount_role` tinyint(2) NOT NULL COMMENT '企业账号对应的业务角色（0-BBC供应商 1-BB供应 商2-渠道客户 3- 资金使用方 4-品牌方）',
  `Fapplicant_id` int(11) NOT NULL COMMENT '申请人id',
  `Fapplicant_name` varchar(32) DEFAULT NULL COMMENT '申请人姓名',
  `Fapplicant_job_name` varchar(32) DEFAULT NULL COMMENT '申请人职务',
  `Fapplicant_dept_name` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT '申请人部门名称',
  `Fapplicant_company_id` int(64) DEFAULT NULL COMMENT '申请人所属公司主体Id',
  `Fapplicant_company_name` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT '申请人所属公司主体名称',
  `Fpay_corporate_id` int(11) NOT NULL COMMENT '付款主体id 若单据类型为采购付款、销售退款，直接取采购主体、销售主体，不可修改。若单据类型为其他付款、其他退款，可模糊搜索选择付款主体。',
  `Fpay_corporate_name` varchar(255) DEFAULT NULL COMMENT '付款主体名称',
  `Fremark` varchar(255) DEFAULT NULL COMMENT '备注',
  `Frefund_application_status` tinyint(16) NOT NULL DEFAULT '0' COMMENT '付款申请单状态 0:草稿 1：待审批 2：已驳回 3：待付款 4：已付款',
  `Fpayee_name` varchar(64) DEFAULT NULL COMMENT '收款人户名(冗余字段)',
  `Frefund_currency_type` varchar(16) DEFAULT NULL COMMENT '申请付款(退款)币别 (冗余字段)',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Frefund_application_id`) USING BTREE,
  UNIQUE KEY `Frefund_application_id` (`Frefund_application_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='退款申请主表';

-- ----------------------------
-- Table structure for t_bb_sale_order_refund_attachment
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sale_order_refund_attachment`;
CREATE TABLE `t_bb_sale_order_refund_attachment` (
  `Ffile_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '退款申请单文件Id',
  `Fsale_bill_id` varchar(32) NOT NULL COMMENT '退款申请单据id',
  `Fattachment_url` varchar(255) NOT NULL COMMENT '文件存放路径',
  `Fattachment_name` varchar(128) NOT NULL COMMENT '附件名称',
  `Fattachment_size` varchar(16) NOT NULL DEFAULT '0' COMMENT '附件大小',
  `Fattachment_type` tinyint(6) NOT NULL DEFAULT '0' COMMENT '文件类型 0:其他  1: 退款申请单 ',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Ffile_id`),
  KEY `tb-sbi-fcmt-normal` (`Fsale_bill_id`,`Fattachment_type`) USING BTREE COMMENT '联合普通索引'
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COMMENT='退货申请单附件';

-- ----------------------------
-- Table structure for t_bb_sale_order_refund_finance_info
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sale_order_refund_finance_info`;
CREATE TABLE `t_bb_sale_order_refund_finance_info` (
  `Frefund_finance_info_id` int(255) NOT NULL AUTO_INCREMENT COMMENT '退货申请单财务信息',
  `Frefund_application_id` varchar(255) NOT NULL DEFAULT '' COMMENT '退款申请单id',
  `Frefund_currency_type` varchar(16) DEFAULT NULL COMMENT '申请付款(退款)币别',
  `Frefund_total_amount` bigint(20) DEFAULT '0' COMMENT '本次申请付款(退款) 金额',
  `Fexchange_rate` int(11) DEFAULT '0' COMMENT '本次(申请)付款币别兑本次(应付)款金额的汇率',
  `Fsale_order_id` varchar(32) DEFAULT NULL COMMENT '关联销售订单id',
  `Fsale_order_currency_type` varchar(16) DEFAULT NULL COMMENT '销售订单币别(退货申请单关联)',
  `Fsale_order_total_amount` bigint(20) DEFAULT '0' COMMENT '销售订单总金额（价税合计原币）',
  `Frecevice_money_order_id` varchar(32) NOT NULL COMMENT '关联收款单id',
  `Frecevice_money_order_currency_type` varchar(16) NOT NULL COMMENT '收款单结算币别 (根据关联的采购订单号带出)',
  `Frecevice_money_order_total_amount` bigint(20) NOT NULL DEFAULT '0' COMMENT '收款单总金额（价税合计原币）',
  `Fis_diliveryed` tinyint(2) DEFAULT NULL COMMENT ' 是否已发货 0：否 1：是',
  `Fgoods_return_id` varchar(16) DEFAULT NULL COMMENT '关联退货单号 由仓库提供 ',
  `Fgoods_return_total_amount` bigint(20) DEFAULT '0' COMMENT '退款单总金额(销售订单币种)',
  `Fpayment_deadline` date DEFAULT NULL COMMENT '最晚付款日期',
  `Famount_payable_this_time` bigint(20) DEFAULT '0' COMMENT '本次应付款金额(销售订单币种)',
  `Fpayment_type` tinyint(16) DEFAULT NULL COMMENT '付款类别 0: 其他退款 1:保证金',
  PRIMARY KEY (`Frefund_finance_info_id`) USING BTREE,
  UNIQUE KEY `Frefund_application_id` (`Frefund_application_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for t_bb_sale_order_refund_receiving_side_info
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sale_order_refund_receiving_side_info`;
CREATE TABLE `t_bb_sale_order_refund_receiving_side_info` (
  `Frefund_receive_side_info_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '退款申请单财务信息id',
  `Frefund_application_id` varchar(255) NOT NULL DEFAULT '' COMMENT '退款申请单id',
  `Fagreement_id` varchar(32) NOT NULL COMMENT '框架协议编号',
  `Fcompany_id` int(11) NOT NULL COMMENT '对方公司主体id',
  `Fcompany_name` varchar(64) CHARACTER SET utf8 NOT NULL COMMENT '渠道客户名称',
  `Fpayee_type` tinyint(2) NOT NULL COMMENT '收款人类型（1 个人账户 2 公司账户 3其他）',
  `Fis_oversea_payee` tinyint(2) NOT NULL COMMENT '是否境外收款方（0 否 1是 ）',
  `Fpayee_name` varchar(64) NOT NULL COMMENT '收款人户名',
  `Fpayee_account` varchar(64) NOT NULL COMMENT '收款人账号',
  `Fpayee_bank_name` varchar(255) NOT NULL COMMENT '收款行名称',
  `Fbank_address` varchar(255) DEFAULT '' COMMENT '开户分行地址',
  `Fswift_code` varchar(64) DEFAULT '' COMMENT 'SWIFT号',
  PRIMARY KEY (`Frefund_receive_side_info_id`) USING BTREE,
  UNIQUE KEY `Frefund_application_id` (`Frefund_application_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COMMENT='退款申请单收款方信息';

-- ----------------------------
-- Table structure for t_bb_sale_order_return_apply
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sale_order_return_apply`;
CREATE TABLE `t_bb_sale_order_return_apply` (
  `Fsale_return_id` varchar(32) NOT NULL COMMENT '销售退货单id',
  `Fsale_order_id` varchar(32) NOT NULL COMMENT '销售订单id',
  `Fsale_order_contract` varchar(64) DEFAULT NULL COMMENT '销售订单关联合同',
  `Fsale_organization` varchar(64) DEFAULT NULL COMMENT '销售主体',
  `Fstore_in_id` varchar(32) DEFAULT NULL COMMENT '入库仓id',
  `Fsale_return_reason_id` tinyint(2) DEFAULT NULL COMMENT '销售退货原因ID(1：商品到货破损   2：丢失  3：客户拒收  4：其他）',
  `Fsale_return_reason` varchar(128) DEFAULT NULL COMMENT '退货原因',
  `Fsale_return_carrier` varchar(64) DEFAULT NULL COMMENT '承运商',
  `Fsale_return_date` datetime DEFAULT NULL COMMENT '预计到仓时间',
  `Fsale_return_logistic_num` varchar(32) DEFAULT NULL COMMENT '物流单号',
  `Fsale_return_logistic_type` tinyint(2) DEFAULT NULL COMMENT '物流方式 物流方式 0:我方提货  1:客户拒收随货退货  2:快递退货',
  `Fsale_receive_organization` varchar(32) DEFAULT NULL COMMENT '收货组织',
  `Fsale_receive_contact` varchar(32) DEFAULT NULL COMMENT '收货组织联系人',
  `Fsale_receive_contact_phone` varchar(32) DEFAULT NULL COMMENT '收货组织联系人电话',
  `Fsale_return_organization` varchar(32) DEFAULT NULL COMMENT '退货方',
  `Fsale_return_contact` varchar(32) DEFAULT NULL COMMENT '退货方联系人',
  `Fsale_return_contact_phone` varchar(32) DEFAULT NULL COMMENT '退货方联系人电话',
  `Fsale_return_status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '销售退货单状态 0:草稿  1:待入库  2:已入库  5：仓库待确认，6：仓库已驳回',
  `Fsale_return_warehouse_refuse_reason` varchar(128) DEFAULT NULL COMMENT '仓库驳回原因',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fsale_return_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='销售退货单申请';

-- ----------------------------
-- Table structure for t_bb_sale_order_return_financial_info
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sale_order_return_financial_info`;
CREATE TABLE `t_bb_sale_order_return_financial_info` (
  `Fsale_return_financial_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '销售退货单财务id',
  `Fsale_return_id` varchar(32) NOT NULL COMMENT '销售退货单id',
  `Fsettlement_currency_code` varchar(16) NOT NULL COMMENT '结算币别id',
  `Fis_tax` tinyint(2) NOT NULL COMMENT '是否含税 是否含税 0:是 1:否',
  `Fexchange_rate` int(11) NOT NULL COMMENT '汇率',
  `Fsale_total_amount_without_tax_original_currency` bigint(20) NOT NULL COMMENT '金额',
  `Ftax_amount_original_currency` bigint(20) NOT NULL COMMENT '税额',
  `Fsale_total_amount_include_tax_original_currency` bigint(20) NOT NULL COMMENT '价税合计',
  `Fcreate_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fsale_return_financial_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='销售退货单财务信息';

-- ----------------------------
-- Table structure for t_bb_sale_order_return_sku_info
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sale_order_return_sku_info`;
CREATE TABLE `t_bb_sale_order_return_sku_info` (
  `Fsale_return_detail_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '销售退货单明细id',
  `Fsale_return_id` varchar(32) NOT NULL COMMENT '销售退货单id',
  `Fsku_id` varchar(32) NOT NULL COMMENT 'SKU商品编码',
  `Fsale_num` bigint(20) DEFAULT NULL COMMENT '销售数量',
  `Fsale_return_amount` bigint(20) DEFAULT NULL COMMENT '退货数量',
  `Fsale_return_in_storage_amount` bigint(20) DEFAULT NULL COMMENT '实际入库数量',
  `Ftax_rate` smallint(4) DEFAULT NULL COMMENT '税率 tax_rate =Ftax_rate/10000',
  `Fsale_return_expiration` datetime DEFAULT NULL COMMENT '保质期',
  `Fsale_return_vaildity_to` datetime DEFAULT NULL COMMENT '有效期至',
  `Fprice_including_tax_original_currency` bigint(20) DEFAULT NULL COMMENT '单价',
  `Fsale_total_amount_include_tax_original_currency` bigint(20) DEFAULT NULL COMMENT '小计',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fsale_return_detail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COMMENT='销售退货单SKU明细';

-- ----------------------------
-- Table structure for t_bb_sale_order_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sale_order_sku`;
CREATE TABLE `t_bb_sale_order_sku` (
  `Fsale_order_sku_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '销售订单商品Id',
  `Fsale_order_id` varchar(32) NOT NULL COMMENT '销售订单id SO为前缀',
  `Fsku_id` varchar(32) NOT NULL COMMENT '物料编码 SkuId',
  `Fpurchase_quote_price` bigint(20) DEFAULT NULL COMMENT '采购报价 本位币(人民币)',
  `Fsale_num` bigint(20) DEFAULT '0' COMMENT '销售数量 引用询价的销售数量',
  `Ftax_rate` smallint(4) DEFAULT NULL COMMENT '税率 tax_rate =Ftax_rate/10000',
  `Ftax_rate_id` int(11) DEFAULT NULL,
  `Fprice_including_tax_original_currency` bigint(20) DEFAULT NULL COMMENT 'SKU含税单价(原币)',
  `Fprice_including_tax_functional_currency` bigint(20) DEFAULT NULL COMMENT 'SKU含税单价(本位币) ',
  `Fsale_total_amount_without_tax_original_currency` bigint(20) DEFAULT NULL COMMENT 'SKU不含税总金额（原币）',
  `Fsale_total_amount_without_tax_functional_currency` bigint(20) DEFAULT NULL COMMENT 'SKU不含税总金额（本位币）',
  `Ftax_amount_original_currency` bigint(20) DEFAULT NULL COMMENT 'SKU税额(原币)',
  `Ftax_amount_functional_currency` bigint(20) DEFAULT NULL COMMENT 'SKU税额(本位币)',
  `Fsale_total_amount_include_tax_original_currency` bigint(20) DEFAULT NULL COMMENT '价税合计（原币）',
  `Fsale_total_amount_include_tax_functional_currency` bigint(20) DEFAULT NULL COMMENT '价税合计（本位币）',
  `Fis_delete` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否删除 0 : 否 1 : 是',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fsale_order_sku_id`),
  UNIQUE KEY `tbsos-soi-si-unique` (`Fsale_order_id`,`Fsku_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=576 DEFAULT CHARSET=utf8mb4 COMMENT='销售订单商品';

-- ----------------------------
-- Table structure for t_bb_sale_order_sku_change
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sale_order_sku_change`;
CREATE TABLE `t_bb_sale_order_sku_change` (
  `Fsale_order_sku_change_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '销售订单商品Id',
  `Fsale_order_change_id` varchar(32) NOT NULL COMMENT '销售变更单id SCO为前缀',
  `Fsku_id` varchar(32) NOT NULL COMMENT '物料编码 SkuId',
  `Fpurchase_quote_price` bigint(20) DEFAULT NULL COMMENT '采购报价 本位币(人民币)',
  `Fsale_num` bigint(20) DEFAULT NULL COMMENT '销售数量 引用询价的销售数量',
  `Ftax_rate` smallint(4) DEFAULT NULL COMMENT '税率 tax_rate =Ftax_rate/10000',
  `Ftax_rate_id` int(11) DEFAULT NULL,
  `Fprice_including_tax_original_currency` bigint(20) DEFAULT NULL COMMENT 'SKU含税单价(原币)',
  `Fprice_including_tax_functional_currency` bigint(20) DEFAULT NULL COMMENT 'SKU含税单价(本位币) ',
  `Fsale_total_amount_without_tax_original_currency` bigint(20) DEFAULT NULL COMMENT 'SKU不含税总金额（原币）',
  `Fsale_total_amount_without_tax_functional_currency` bigint(20) DEFAULT NULL COMMENT 'SKU不含税总金额（本位币）',
  `Ftax_amount_original_currency` bigint(20) DEFAULT NULL COMMENT 'SKU税额(原币)',
  `Ftax_amount_functional_currency` bigint(20) DEFAULT NULL COMMENT 'SKU税额(本位币)',
  `Fsale_total_amount_include_tax_original_currency` bigint(20) DEFAULT NULL COMMENT '价税合计（原币）',
  `Fsale_total_amount_include_tax_functional_currency` bigint(20) DEFAULT NULL COMMENT '价税合计（本位币）',
  `Fis_delete` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否删除 0 : 否 1 : 是',
  `Fdata_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '数据类型：0：变更前数据类型 1：变更后数据类型',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fsale_order_sku_change_id`),
  UNIQUE KEY `tbsosc-soi-si-unique` (`Fsale_order_change_id`,`Fsku_id`,`Fdata_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8mb4 COMMENT='销售变更单商品';

-- ----------------------------
-- Table structure for t_bb_sale_order_tally_report
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sale_order_tally_report`;
CREATE TABLE `t_bb_sale_order_tally_report` (
  `Fsale_order_tally_report_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '销售订单理货报告id',
  `Fsale_order_id` varchar(32) NOT NULL COMMENT '销售订单id',
  `Fsku_id` varchar(32) NOT NULL COMMENT 'sku编码',
  `Fsku_international_no` varchar(32) DEFAULT NULL COMMENT '国际条码',
  `Fsku_name` varchar(128) DEFAULT NULL COMMENT '商品名称',
  `Fsale_num` bigint(20) DEFAULT NULL COMMENT '应收数量',
  `Fsale_received_num` bigint(20) DEFAULT NULL COMMENT '实收数量',
  `Fsale_diff_num` bigint(20) DEFAULT NULL COMMENT '差异数量',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fsale_order_tally_report_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COMMENT='销售理货报告';

-- ----------------------------
-- Table structure for t_bb_sale_quote
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sale_quote`;
CREATE TABLE `t_bb_sale_quote` (
  `Fsale_quote_id` varchar(32) NOT NULL COMMENT '销售报价单',
  `Fenquiry_id` varchar(32) NOT NULL COMMENT '询价单',
  `Fsale_aid` int(11) NOT NULL COMMENT '销售负责人',
  `Fsale_quote_status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '销售报价状态:0草稿,1已生效,2,已关闭',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fsale_quote_id`),
  UNIQUE KEY `tbsq-ei-unique` (`Fenquiry_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='销售报价信息表';

-- ----------------------------
-- Table structure for t_bb_sale_transfers_apply_order
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sale_transfers_apply_order`;
CREATE TABLE `t_bb_sale_transfers_apply_order` (
  `Ftransfers_apply_order_id` varchar(32) NOT NULL COMMENT '调拨申请单ID',
  `Fcall_in_organization_id` int(11) unsigned DEFAULT NULL COMMENT '调入组织id,关联公司主体id',
  `Fbring_up_organization_id` int(11) unsigned DEFAULT NULL COMMENT '调出组织iD,关联公司主体表id',
  `Fcall_in_warehouse_id` int(11) unsigned DEFAULT NULL COMMENT '调入仓库id,关联仓库id',
  `Fbring_up_warehouse_id` int(11) unsigned DEFAULT NULL COMMENT '调出仓库id,关联仓库id',
  `Ftransfers_type` tinyint(2) unsigned DEFAULT NULL COMMENT '调拨类型(1:组织内调拨 2:跨组织调拨)',
  `Ftransfers_date` date DEFAULT NULL COMMENT '安排调拨日期',
  `Ftransfers_apply_order_status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '调拨申请单状态(0:草稿 1:待审批 2:已生效 3:已驳回)',
  `Fremark` varchar(255) DEFAULT NULL COMMENT '备注',
  `Freason` varchar(255) DEFAULT NULL COMMENT '驳回原因',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Ftransfers_apply_order_id`),
  KEY `tbb_transfer_index` (`Fcall_in_warehouse_id`,`Fbring_up_warehouse_id`,`Ftransfers_type`,`Ftransfers_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='调拨申请单';

-- ----------------------------
-- Table structure for t_bb_sale_transfers_apply_order_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sale_transfers_apply_order_sku`;
CREATE TABLE `t_bb_sale_transfers_apply_order_sku` (
  `Ftransfers_apply_order_sku_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一ID',
  `Fsku_id` varchar(32) NOT NULL COMMENT 'sku编码',
  `Ftransfers_apply_order_id` varchar(32) NOT NULL COMMENT '调拨申请单Id',
  `Ftransfers_apply_sku_num` int(11) unsigned NOT NULL COMMENT '调拨数量',
  `Fwarehouseing_num` varchar(32) DEFAULT NULL COMMENT '入仓号',
  `Findate` date DEFAULT NULL COMMENT '有效期',
  `Fis_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除(0否 1是)',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Ftransfers_apply_order_sku_id`),
  UNIQUE KEY `tbb_transfer_order_index` (`Ftransfers_apply_order_id`,`Fsku_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='调拨申请单sku表';

-- ----------------------------
-- Table structure for t_bb_spu
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_spu`;
CREATE TABLE `t_bb_spu` (
  `Fspu_id` varchar(32) NOT NULL COMMENT 'spu编码',
  `Fbrand_id` int(11) unsigned NOT NULL COMMENT '品牌id',
  `Fcategory_id_1` int(11) unsigned NOT NULL COMMENT '类目1',
  `Fcategory_id_2` int(11) unsigned NOT NULL COMMENT '类目2',
  `Fcategory_id_3` int(11) unsigned NOT NULL COMMENT '类目3',
  `Fspu_name` varchar(64) NOT NULL COMMENT 'SPU商品名称',
  `Funit` varchar(16) NOT NULL COMMENT '单位 例：只、个、瓶',
  `Fisdelete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除，0为否 1为是',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '数据修改时间',
  PRIMARY KEY (`Fspu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='spu商品表';

-- ----------------------------
-- Table structure for t_bb_spu_graphic_details
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_spu_graphic_details`;
CREATE TABLE `t_bb_spu_graphic_details` (
  `Fspu_id` varchar(32) NOT NULL COMMENT 'spu编码',
  `Fgraphic_details` text NOT NULL COMMENT '图文详情',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '数据修改时间',
  PRIMARY KEY (`Fspu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='spu图文详情表';

-- ----------------------------
-- Table structure for t_bb_spu_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_spu_sku`;
CREATE TABLE `t_bb_spu_sku` (
  `Fsku_id` varchar(32) NOT NULL COMMENT 'SKU商品编码',
  `Fspu_id` varchar(32) NOT NULL COMMENT 'spu商品编码',
  `Forigin_id` int(11) unsigned NOT NULL COMMENT '原产地id',
  `Fsku_name` varchar(128) NOT NULL COMMENT 'SKU名称',
  `Fsku_specification` varchar(64) NOT NULL COMMENT 'sku规格',
  `Fsku_international_no` varchar(32) NOT NULL DEFAULT '' COMMENT '商品国际编码',
  `Fsku_weight` int(11) unsigned NOT NULL COMMENT 'SKU商品重量，单位:克',
  `Fsku_pic` varchar(255) NOT NULL COMMENT '商品规格图片',
  `Fexpiration_date` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '保质期 单位（天）例：360天',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '数据修改时间',
  PRIMARY KEY (`Fsku_id`),
  UNIQUE KEY `ux_international_no` (`Fsku_international_no`) USING BTREE COMMENT '国际条码此表唯一'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='SKU商品表';

-- ----------------------------
-- Table structure for t_bb_sso_admin_role
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sso_admin_role`;
CREATE TABLE `t_bb_sso_admin_role` (
  `Fadmin_role_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `Faid` int(11) unsigned DEFAULT NULL COMMENT '用户id',
  `Frole_id` int(11) unsigned DEFAULT NULL COMMENT '角色id',
  `Fcreate_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fadmin_role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=576 DEFAULT CHARSET=utf8mb4 COMMENT='用户角色';

-- ----------------------------
-- Table structure for t_bb_sso_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sso_permission`;
CREATE TABLE `t_bb_sso_permission` (
  `Fpermission_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `Fsystem_id` int(11) DEFAULT NULL COMMENT '应用id',
  `Fp_name` varchar(128) DEFAULT NULL COMMENT '权限名称',
  `Fp_picture` varchar(128) DEFAULT NULL COMMENT '图片',
  `Ftoute_url` varchar(255) DEFAULT NULL COMMENT '路由url',
  `Fp_auth_url` varchar(255) DEFAULT NULL COMMENT '权限url',
  `Fp_menu` tinyint(2) DEFAULT NULL COMMENT '是否是菜单 0:否 1:是',
  `Fenable` tinyint(2) DEFAULT NULL COMMENT '是否启用 0:停用 1:启用',
  `Fsort` int(8) DEFAULT NULL COMMENT '排序',
  `Fpermission_pid` int(11) unsigned DEFAULT NULL COMMENT '父id',
  `Fcreate_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fpermission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=639 DEFAULT CHARSET=utf8mb4 COMMENT='权限表';

-- ----------------------------
-- Table structure for t_bb_sso_role
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sso_role`;
CREATE TABLE `t_bb_sso_role` (
  `Frole_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `Frole_name` varchar(64) NOT NULL COMMENT '角色名称',
  `Fenable` tinyint(2) DEFAULT '1' COMMENT '是否启用 0:停用 1:启用',
  `Fsort` int(8) unsigned DEFAULT '0' COMMENT '排序',
  `Fremark` varchar(255) DEFAULT NULL COMMENT '描述',
  `Fcreate_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Frole_id`),
  UNIQUE KEY `Frole_name` (`Frole_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8mb4 COMMENT='角色表';

-- ----------------------------
-- Table structure for t_bb_sso_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_sso_role_permission`;
CREATE TABLE `t_bb_sso_role_permission` (
  `Frole_permission_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `Fsystem_id` int(11) unsigned DEFAULT NULL COMMENT '应用id',
  `Frole_id` int(11) unsigned DEFAULT NULL COMMENT '角色id',
  `Fpermission_id` int(11) unsigned DEFAULT NULL COMMENT '权限id',
  `Fcreate_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Frole_permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=97478 DEFAULT CHARSET=utf8mb4 COMMENT='角色权限';

-- ----------------------------
-- Table structure for t_bb_suppleer_quote_import_error
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_suppleer_quote_import_error`;
CREATE TABLE `t_bb_suppleer_quote_import_error` (
  `Fquote_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `Fgoods_picture` varchar(255) DEFAULT NULL COMMENT '商品图片',
  `Fsku_name` varchar(128) DEFAULT NULL COMMENT 'SKU名称',
  `Finternational_code` varchar(64) DEFAULT NULL COMMENT '国际条码',
  `Fquote_num` int(11) DEFAULT NULL COMMENT '可售库存',
  `Fquote_price` bigint(20) DEFAULT NULL COMMENT '供货价格',
  `Fterm_validity_begin` date DEFAULT NULL COMMENT '价格有效期(开始)',
  `Fterm_validity_end` date DEFAULT NULL COMMENT '价格有效期(结束)',
  `Fguarantee_period` date DEFAULT NULL COMMENT '商品质保期',
  `Fvoucher_picture` varchar(255) DEFAULT NULL COMMENT '商品凭证',
  `Fremark` varchar(255) DEFAULT NULL COMMENT '备注',
  `Fquote_code` varchar(64) DEFAULT NULL COMMENT '批次',
  `Fdelivery_time` date DEFAULT NULL COMMENT '交货日期',
  `Fcreate_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fquote_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COMMENT='供应商导入错误记录';

-- ----------------------------
-- Table structure for t_bb_supplier_brand
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_supplier_brand`;
CREATE TABLE `t_bb_supplier_brand` (
  `Fid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `Fcompany_id` int(11) NOT NULL COMMENT '关联企业账号表id',
  `Fbrand_id` int(11) NOT NULL COMMENT '关联品牌表id',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Fid`),
  UNIQUE KEY `t_bb_supb_index` (`Fcompany_id`,`Fbrand_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=899 DEFAULT CHARSET=utf8mb4 COMMENT='供应商关联主营品牌表';

-- ----------------------------
-- Table structure for t_bb_supplier_category
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_supplier_category`;
CREATE TABLE `t_bb_supplier_category` (
  `Fid` int(11) NOT NULL AUTO_INCREMENT,
  `Fcompany_id` int(11) NOT NULL COMMENT '供应商id,关联企业账户表',
  `Fcategory_id` int(11) NOT NULL COMMENT '商品类型，关联商品类目表',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Fid`),
  UNIQUE KEY `t_bb_sc_index` (`Fcompany_id`,`Fcategory_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1016 DEFAULT CHARSET=utf8mb4 COMMENT='供应商关联商品类目表';

-- ----------------------------
-- Table structure for t_bb_supplier_dispatch
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_supplier_dispatch`;
CREATE TABLE `t_bb_supplier_dispatch` (
  `Fsupplier_dispatch_id` varchar(32) NOT NULL COMMENT '发货单号',
  `Fpurchase_order_id` varchar(32) NOT NULL COMMENT 'po单号',
  `Fsupplier_id` int(11) NOT NULL COMMENT '供应商的compnyId',
  `Fout_time` date NOT NULL COMMENT '发货时间',
  `Freach_time` date NOT NULL COMMENT '预计到港时间',
  `Fdelivery_way` tinyint(2) NOT NULL COMMENT '【冗余字段，跟PO单的运输方式一致】运输方式；；1-海运；2-陆运;3-空运',
  `Flogistics_company` varchar(32) NOT NULL COMMENT '物流公司名称',
  `Flogistics_num` varchar(32) NOT NULL COMMENT '物流单号',
  `Fremark` varchar(128) DEFAULT NULL COMMENT '备注',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fsupplier_dispatch_id`),
  KEY `tbsd-poi-key` (`Fpurchase_order_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='发货单 发货单表';

-- ----------------------------
-- Table structure for t_bb_supplier_dispatch_attachment
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_supplier_dispatch_attachment`;
CREATE TABLE `t_bb_supplier_dispatch_attachment` (
  `Fid` int(11) NOT NULL AUTO_INCREMENT COMMENT '附件id',
  `Fsupplier_dispatch_id` varchar(32) NOT NULL COMMENT '发货单id',
  `Fattachment_type` tinyint(2) NOT NULL COMMENT '附件类型.0-箱单；1-发票；2-提单；3-其他',
  `Fattachment_url` varchar(64) NOT NULL COMMENT '附件url',
  `Fattachment_name` varchar(255) NOT NULL COMMENT '附件类型为其他时，保存文件名',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fid`),
  KEY `tbsda-sdi-key` (`Fsupplier_dispatch_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=288 DEFAULT CHARSET=utf8mb4 COMMENT='发货单附件 ';

-- ----------------------------
-- Table structure for t_bb_supplier_dispatch_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_supplier_dispatch_sku`;
CREATE TABLE `t_bb_supplier_dispatch_sku` (
  `Fid` int(11) NOT NULL AUTO_INCREMENT COMMENT '发货单skuid',
  `Fsupplier_dispatch_id` varchar(32) NOT NULL COMMENT '发货单号',
  `Fsku_id` varchar(32) NOT NULL COMMENT 'skuid',
  `Fdispatch_num` int(11) NOT NULL COMMENT '发货数量',
  `Fbox_size` varchar(32) NOT NULL COMMENT '箱规',
  `Fvalidty_end` date NOT NULL COMMENT '有效期至',
  `Fsku_batch` varchar(32) DEFAULT NULL COMMENT '商品批次号',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fid`),
  UNIQUE KEY `tbsds-sdi-si-unique` (`Fsupplier_dispatch_id`,`Fsku_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COMMENT='发货单中的sku 发货单中的sku';

-- ----------------------------
-- Table structure for t_bb_supplier_enquiry
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_supplier_enquiry`;
CREATE TABLE `t_bb_supplier_enquiry` (
  `Fsupplier_enquiry_id` varchar(32) NOT NULL DEFAULT '0' COMMENT '供应商询单id',
  `Fenquiry_id` varchar(32) NOT NULL COMMENT '询价单id',
  `Fsupplier_id` int(11) NOT NULL COMMENT '供应商id',
  `Fenquiry_state` tinyint(2) NOT NULL COMMENT '询价参与状态 0:未参与  1:全部参与  2:部分参与  ',
  `Fenquiry_bid_state` tinyint(2) NOT NULL COMMENT '询单中标状态 0:未中标 1:全部中标 2:部分中标 3:评标中',
  `Fsupplier_enquiry_state` tinyint(2) NOT NULL COMMENT '供应商询单状态 0:询价中 1:询价结束',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fsupplier_enquiry_id`),
  UNIQUE KEY `tbes-ei-si-unique` (`Fenquiry_id`,`Fsupplier_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='供应商询单';

-- ----------------------------
-- Table structure for t_bb_supplier_quote
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_supplier_quote`;
CREATE TABLE `t_bb_supplier_quote` (
  `Fsupplier_quote_id` varchar(32) NOT NULL COMMENT '报价id',
  `Fsupplier_enquiry_id` varchar(32) DEFAULT NULL COMMENT '供应商询单id',
  `Fenquiry_sku_id` varchar(32) NOT NULL COMMENT 'SKU询单id',
  `Fsupplier_id` int(11) NOT NULL COMMENT '供应商id',
  `Fquote_num` int(11) unsigned DEFAULT NULL COMMENT '可售库存[供应商当前最新值]',
  `Fquote_price` bigint(20) unsigned DEFAULT NULL COMMENT '供货价格[供应商当前最新值]',
  `Fquote_num_backup` int(11) unsigned DEFAULT '0' COMMENT '可售库存[采购单时供应商最新值]',
  `Fquote_price_backup` bigint(20) unsigned DEFAULT '0' COMMENT '供货价格[采购单时供应商最新值]',
  `Fpre_bid_num` bigint(20) unsigned DEFAULT '0' COMMENT '拟中标数量[采购员当前预设]',
  `Fpre_bid_price` bigint(20) unsigned DEFAULT '0' COMMENT '拟中标价格[采购员当前预设]',
  `Fterm_validity_begin` date DEFAULT NULL COMMENT '价格有效期(开始)',
  `Fterm_validity_end` date DEFAULT NULL COMMENT '价格有效期(结束)',
  `Fguarantee_period` date DEFAULT NULL COMMENT '商品质保期',
  `Ftimeliness` int(11) DEFAULT NULL COMMENT '出单时效',
  `Fdelivery_time` date DEFAULT NULL COMMENT '交货日期',
  `Fremark` varchar(255) DEFAULT NULL COMMENT '备注',
  `Fsupplier_quote_status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '供应商报价状态:0未参与,1已参与,2已中标3未中标',
  `Fvoucher_picture` varchar(255) DEFAULT NULL COMMENT '采购凭证',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fsupplier_quote_id`),
  UNIQUE KEY `tbsq-esi-si-unique` (`Fenquiry_sku_id`,`Fsupplier_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='供应商报价';

-- ----------------------------
-- Table structure for t_bb_supplier_quote_his
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_supplier_quote_his`;
CREATE TABLE `t_bb_supplier_quote_his` (
  `Fid` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `Fsupplier_quote_id` varchar(32) NOT NULL COMMENT '报价id',
  `Fenquiry_sku_id` varchar(32) NOT NULL COMMENT 'SKU询单id',
  `Fsupplier_id` int(11) NOT NULL COMMENT '供应商id',
  `Fquote_num` bigint(20) unsigned NOT NULL COMMENT '可售库存',
  `Fquote_price` bigint(20) unsigned NOT NULL COMMENT '供货价格',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Fid`)
) ENGINE=InnoDB AUTO_INCREMENT=214 DEFAULT CHARSET=utf8mb4 COMMENT='供应商报价历史';

-- ----------------------------
-- Table structure for t_bb_supplier_quote_his_copy
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_supplier_quote_his_copy`;
CREATE TABLE `t_bb_supplier_quote_his_copy` (
  `Fid` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `Fsupplier_quote_id` varchar(32) NOT NULL COMMENT '报价id',
  `Fenquiry_sku_id` varchar(32) NOT NULL COMMENT 'SKU询单id',
  `Fsupplier_id` int(11) NOT NULL COMMENT '供应商id',
  `Fquote_num` bigint(20) unsigned NOT NULL COMMENT '可售库存',
  `Fquote_price` bigint(20) unsigned NOT NULL COMMENT '供货价格',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='供应商报价历史';

-- ----------------------------
-- Table structure for t_bb_supplier_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_supplier_sku`;
CREATE TABLE `t_bb_supplier_sku` (
  `Fsupplier_sku_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '供应商提交sku信息表id',
  `Fcompany_id` int(11) unsigned NOT NULL COMMENT '供应商id',
  `Forigin_id` int(11) unsigned NOT NULL COMMENT '原产地id',
  `Fsku_id` varchar(32) DEFAULT NULL COMMENT 'skuid',
  `Fcurrency_id` int(11) unsigned DEFAULT NULL COMMENT '商品币种id',
  `Fbrand_id` int(11) unsigned NOT NULL COMMENT '品牌id',
  `Fregion_id_country` int(11) unsigned DEFAULT NULL COMMENT '发货国家id(暂时废除)',
  `Fregion_id_province` int(11) unsigned DEFAULT NULL COMMENT '发货省id(暂时废除)',
  `Fregion_id_city` int(11) unsigned DEFAULT NULL COMMENT '发货城市id(暂时废除)',
  `Fcategory_id_1` int(11) unsigned NOT NULL COMMENT '类目1',
  `Fcategory_id_2` int(11) unsigned NOT NULL COMMENT '类目2',
  `Fcategory_id_3` int(11) unsigned NOT NULL COMMENT '类目3',
  `Fsku_name` varchar(64) NOT NULL COMMENT 'SKU名称',
  `Fsku_used_name` varchar(64) DEFAULT NULL COMMENT '曾用sku名称(仅用于匹配前后，编辑操作不录入）',
  `Fsku_international_no` varchar(32) NOT NULL COMMENT '商品国际条码',
  `Fsku_commodity_item_no` varchar(32) NOT NULL COMMENT '商品货号,供应商根据自己的规则生成的商品sku编码',
  `Fcommodity_prices` int(11) unsigned DEFAULT NULL COMMENT '商品价格',
  `Fsku_weight` int(11) unsigned DEFAULT NULL COMMENT '商品重量',
  `Fprice_validity_start_date` date DEFAULT NULL COMMENT '价格有效期开始时间',
  `Fprice_validity_end_date` date DEFAULT NULL COMMENT '价格有效期结束时间',
  `Fdetailed_address` varchar(128) DEFAULT NULL COMMENT '发货详细地址',
  `Fsku_matching_state` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT 'SKU匹配状态0：草稿 1：匹配中 2:匹配完成',
  `Fsku_pic` varchar(255) DEFAULT NULL COMMENT '商品图片',
  `Fsku_source` varchar(64) DEFAULT NULL COMMENT '商品来源',
  `Fpurchasing_documents` varchar(255) DEFAULT NULL COMMENT '采购凭证',
  `Fsku_auth_pic` varchar(255) DEFAULT NULL COMMENT '审核图片',
  `Fcertificate_of_authorization` varchar(255) DEFAULT NULL COMMENT '授权书 ',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '数据修改时间',
  PRIMARY KEY (`Fsupplier_sku_id`),
  UNIQUE KEY `uk_supplier_international_no` (`Fsku_international_no`,`Fcompany_id`) USING BTREE COMMENT '国际条码+供应商，唯一'
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COMMENT='供应商商品';

-- ----------------------------
-- Table structure for t_bb_system_configure
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_system_configure`;
CREATE TABLE `t_bb_system_configure` (
  `Fsystem_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `Faid` int(11) DEFAULT NULL COMMENT '关联admin表',
  `Fsystem_code` varchar(64) NOT NULL COMMENT '业务系统代码',
  `Fsystem_name` varchar(64) NOT NULL COMMENT '业务系统名称',
  `Fsystem_logo` varchar(255) NOT NULL COMMENT '业务系统的LOGO',
  `Fsystem_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '业务系统的状态0:隐藏 1:上线',
  `Fverify_account_url` varchar(255) NOT NULL COMMENT '验证账号的url',
  `Fback_verify_url` varchar(255) NOT NULL COMMENT '服务域名',
  `Fsort` int(11) DEFAULT NULL COMMENT '排序值',
  `Fdescription` varchar(255) DEFAULT NULL COMMENT '描述',
  `Fis_delete` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否删除（0 否 1是）',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Fsystem_id`),
  KEY `t_bb_faid_index` (`Faid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COMMENT='系统配置表';

-- ----------------------------
-- Table structure for t_bb_tax_rate
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_tax_rate`;
CREATE TABLE `t_bb_tax_rate` (
  `Ftax_rate_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '税率id',
  `Ftax_rate` int(11) NOT NULL COMMENT '具体税率，单位为千分之一',
  `Fstate` tinyint(2) unsigned NOT NULL COMMENT '使用状态，0-禁用，1-启用',
  `Fcreater_aid` int(11) NOT NULL COMMENT '税率创建人id',
  `Fupdater_aid` int(11) NOT NULL COMMENT '税率修改人id',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`Ftax_rate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COMMENT='税率表';

-- ----------------------------
-- Table structure for t_bb_trade_remark
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_trade_remark`;
CREATE TABLE `t_bb_trade_remark` (
  `Ftrade_remark_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '中标单交易说明id',
  `Fbid_id` varchar(32) NOT NULL COMMENT '关联中标单',
  `Fsupplier_id` int(11) NOT NULL COMMENT '关联企业id',
  `Fremark_type` tinyint(2) NOT NULL COMMENT '交易说明类型 [0-交易说明文本 1-交易说明图示] 交易说明图示以<br>为分隔符',
  `Fremark` varchar(255) NOT NULL COMMENT '交易说明内容',
  PRIMARY KEY (`Ftrade_remark_id`),
  UNIQUE KEY `bidid-sid-retp` (`Fbid_id`,`Fsupplier_id`,`Fremark_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COMMENT='此表用于采购给在中标单的每个供应商给予提示所用';

-- ----------------------------
-- Table structure for t_bb_trade_terminology
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_trade_terminology`;
CREATE TABLE `t_bb_trade_terminology` (
  `Fid` int(11) NOT NULL AUTO_INCREMENT,
  `Ftrade_terminology_code` varchar(16) NOT NULL COMMENT '贸易术语代码',
  `Ftrade_terminology_chn` varchar(255) NOT NULL COMMENT '贸易术语中文说明',
  `Frelation_terminology_type` tinyint(8) NOT NULL COMMENT '关联贸易方式',
  `Fis_valid` tinyint(8) NOT NULL DEFAULT '1' COMMENT '是否启用 0:禁用 1:启用',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fid`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COMMENT='贸易术语';

-- ----------------------------
-- Table structure for t_bb_transfer_enter_stock
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_transfer_enter_stock`;
CREATE TABLE `t_bb_transfer_enter_stock` (
  `Ftransfer_enter_stock_id` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '调拨入库通知单id',
  `Fdispatcher_out_id` int(10) NOT NULL COMMENT '调出方id',
  `Fwarehouse_out_id` int(10) NOT NULL COMMENT '调出仓库id',
  `Fplan_type` tinyint(3) NOT NULL COMMENT '业务类型 :1-自营分销;2-以销定采;3-BBC自营分销',
  `Fdispatch_enter_id` int(10) NOT NULL COMMENT '调入方id',
  `Fwarehouse_enter_id` int(10) NOT NULL COMMENT '调入仓库id',
  `Fdispatch_date` datetime NOT NULL COMMENT '安排调拨日期',
  `Fremark` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `Fout_stock_status` tinyint(3) NOT NULL COMMENT '调拨单状态:0-草稿;1-待入库;',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`Ftransfer_enter_stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='调拨入库通知 ';

-- ----------------------------
-- Table structure for t_bb_transfer_enter_stock_attachment
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_transfer_enter_stock_attachment`;
CREATE TABLE `t_bb_transfer_enter_stock_attachment` (
  `Fid` int(10) NOT NULL AUTO_INCREMENT COMMENT '附件id',
  `Ftransfer_enter_stock_id` int(10) NOT NULL COMMENT '调拨入库通知id',
  `Fattachment_type` varchar(64) NOT NULL COMMENT '附件名称',
  `Fattachment_url` varchar(64) NOT NULL COMMENT '附件url',
  `Fsequence_num` tinyint(3) NOT NULL COMMENT '排序号',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`Fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='调拨入库通知单附件 ';

-- ----------------------------
-- Table structure for t_bb_transfer_enter_stock_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_transfer_enter_stock_sku`;
CREATE TABLE `t_bb_transfer_enter_stock_sku` (
  `Ftransfer_enter_stock_sku_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '调拨入库通知skuid',
  `Ftransfer_enter_stock_id` varchar(32) NOT NULL COMMENT '调拨入库通知单号',
  `Fsku_id` varchar(32) NOT NULL COMMENT 'skuid',
  `Fdispatch_num` int(10) NOT NULL COMMENT '调拨数量',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  `Fstatus` tinyint(4) DEFAULT NULL COMMENT 'sku状态:0-良品;1-不良品;2-临期',
  PRIMARY KEY (`Ftransfer_enter_stock_sku_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='调拨入库通知sku明细';

-- ----------------------------
-- Table structure for t_bb_transfer_out_stock
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_transfer_out_stock`;
CREATE TABLE `t_bb_transfer_out_stock` (
  `Ftransfer_out_stock_id` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '调拨出库通知单id',
  `Fdispatcher_out_id` int(10) NOT NULL COMMENT '调出方id',
  `Fwarehouse_out_id` int(10) NOT NULL COMMENT '调出仓库id',
  `Fplan_type` tinyint(3) NOT NULL COMMENT '业务类型 :1-自营分销;2-以销定采;3-BBC自营分销',
  `Fdispatch_enter_id` int(10) NOT NULL COMMENT '调入方id',
  `Fwarehouse_enter_id` int(10) NOT NULL COMMENT '调入仓库id',
  `Fdispatch_date` datetime NOT NULL COMMENT '安排调拨日期',
  `Fremark` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `Fout_stock_status` tinyint(3) NOT NULL COMMENT '调拨单状态:0-草稿;1-待出库;',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`Ftransfer_out_stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='调拨出库通知 ';

-- ----------------------------
-- Table structure for t_bb_transfer_out_stock_attachment
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_transfer_out_stock_attachment`;
CREATE TABLE `t_bb_transfer_out_stock_attachment` (
  `Fid` int(10) NOT NULL AUTO_INCREMENT COMMENT '附件id',
  `Ftransfer_out_stock_id` int(10) NOT NULL COMMENT '调拨出库通知id',
  `Fattachment_type` varchar(64) NOT NULL COMMENT '附件名称',
  `Fattachment_url` varchar(64) NOT NULL COMMENT '附件url',
  `Fsequence_num` tinyint(3) NOT NULL COMMENT '排序号',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`Fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='调拨出库通知单附件 ';

-- ----------------------------
-- Table structure for t_bb_transfer_out_stock_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_transfer_out_stock_sku`;
CREATE TABLE `t_bb_transfer_out_stock_sku` (
  `Ftransfer_out_stock_sku_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '调拨出库通知skuid',
  `Ftransfer_out_stock_id` varchar(32) NOT NULL COMMENT '调拨出库通知单号',
  `Fsku_id` varchar(32) NOT NULL COMMENT 'skuid',
  `Fdispatch_num` int(10) NOT NULL COMMENT '调拨数量',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`Ftransfer_out_stock_sku_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='调拨出库通知sku明细';

-- ----------------------------
-- Table structure for t_bb_voucher_url
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_voucher_url`;
CREATE TABLE `t_bb_voucher_url` (
  `Fid` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `Fbid_sku_id` varchar(32) NOT NULL COMMENT '中标单SKUid 采购凭证属于报价单',
  `Fsupplier_id` int(11) NOT NULL COMMENT '供应商的fcompnyId',
  `Fvoucher_url` varchar(255) NOT NULL COMMENT '图片路径',
  `Fvoucher_name` varchar(128) NOT NULL COMMENT '凭证名字',
  `Fcreate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`Fid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='中标单SKU凭证';

-- ----------------------------
-- Table structure for t_bb_warehouse
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse`;
CREATE TABLE `t_bb_warehouse` (
  `Fwarehouse_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '仓库id',
  `Fwarehouse_name` varchar(32) NOT NULL COMMENT '仓库名称',
  `Fwarehouse_code` varchar(32) NOT NULL COMMENT '仓库编号',
  `Fwarehouse_affiliation_id` int(10) NOT NULL COMMENT '所属公司',
  `Fwarehouse_type` tinyint(3) NOT NULL COMMENT '仓库类型:0-实物仓;1-虚拟仓',
  `Fwarehouse_operation_type` tinyint(3) NOT NULL COMMENT '经营类型:0-自营;1-第三方合作',
  `Fcountry_in_id` int(10) NOT NULL COMMENT '所在国家',
  `Faddress` varchar(255) DEFAULT NULL COMMENT '详细地址',
  `Fzip_code` varchar(8) DEFAULT NULL COMMENT '邮编',
  `Flinkman_name` varchar(32) DEFAULT NULL COMMENT '联系人姓名',
  `Flinkman_phone` varchar(32) DEFAULT NULL COMMENT '联系人手机',
  `Fremark` varchar(255) DEFAULT NULL COMMENT '备注',
  `Fwarehouse_status` tinyint(3) DEFAULT NULL COMMENT '状态:0-未生效;1-生效；第三方实物仓库由于需要审核，所以审核通过前都是未生效',
  `Fagreement_status` tinyint(3) DEFAULT NULL COMMENT '协议审核状态:0-未添加;1-已添加,未审核;2-已添加,审核中;3-已添加，已审核',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更改时间',
  `Fwarehouse_affiliation` varchar(128) DEFAULT NULL COMMENT '所属公司',
  `Farea_id` int(10) DEFAULT NULL COMMENT '所属地区',
  `Ftotal_inventory` int(11) DEFAULT '0' COMMENT '总库存',
  `Freject_reason` varchar(255) DEFAULT NULL COMMENT '驳回原因',
  PRIMARY KEY (`Fwarehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='仓库表';

-- ----------------------------
-- Table structure for t_bb_warehouse_admin
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_admin`;
CREATE TABLE `t_bb_warehouse_admin` (
  `Fid` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `Fwarehouse_id` int(10) NOT NULL COMMENT '仓库id',
  `Faid` int(10) NOT NULL COMMENT '员工账号id',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`Fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='仓库管理员';

-- ----------------------------
-- Table structure for t_bb_warehouse_agreement
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_agreement`;
CREATE TABLE `t_bb_warehouse_agreement` (
  `Fagreement_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '仓储物流类采购框架协议id',
  `Fwarehouse_id` int(10) NOT NULL COMMENT '仓库id',
  `Fprocess_num` varchar(32) DEFAULT NULL COMMENT '流程编号,为0则是还没提交oa审批',
  `Ftitle` varchar(128) NOT NULL COMMENT '协议标题',
  `Fapplicant_id` int(10) NOT NULL COMMENT '申请人id',
  `Fapplicant_department_id` int(10) NOT NULL COMMENT '申请部门id',
  `Fapplicant_department` varchar(64) NOT NULL COMMENT '申请部门',
  `Fapplicant_company_id` int(10) DEFAULT NULL COMMENT '所属公司id',
  `Fapplicant_company_name` varchar(64) DEFAULT NULL COMMENT '所属公司',
  `Fapplicant_title` varchar(32) DEFAULT NULL COMMENT '职务',
  `Fapplicant_number` varchar(32) DEFAULT NULL COMMENT '工号',
  `Fservice_type` tinyint(3) NOT NULL COMMENT '业务类型:0-BB以销定采;1-BB自营分销;2-BBC自营分销',
  `Fcontract_type` tinyint(3) NOT NULL COMMENT '合同类型:1-采购框架协议；2-销售框架协议',
  `Fcontract_edition` tinyint(3) NOT NULL COMMENT '合同版本:0-我方版本；1-对方版本',
  `Fcontract_is_modified` tinyint(3) NOT NULL COMMENT '合同是否有修改',
  `Fcontract_name` varchar(64) NOT NULL COMMENT '合同名称',
  `Fcontract_id` varchar(32) NOT NULL COMMENT '合同编号',
  `Fsignet_type` tinyint(3) NOT NULL COMMENT '盖章类型；0-公章；1-合同章；2-其他',
  `Fcontract_begin_time` date NOT NULL COMMENT '合同有效期开始',
  `Fcontract_end_time` date NOT NULL COMMENT '合同有效期结束',
  `Fcontract_copy_numbers` tinyint(3) NOT NULL COMMENT '合同份数',
  `Four_company_name` varchar(64) NOT NULL COMMENT '我方单位名称',
  `Four_charger_name` varchar(32) NOT NULL COMMENT '我方负责人',
  `Four_charger_phone` varchar(32) NOT NULL COMMENT '我方负责人联系电话',
  `Four_authorize_email` varchar(32) NOT NULL COMMENT '我方授权电子邮箱',
  `Fcorporate_company_name` varchar(64) NOT NULL COMMENT '对方单位名称',
  `Fcorporate_charger_name` varchar(32) NOT NULL COMMENT '对方负责人',
  `Fcorporate_charger_phone` varchar(32) NOT NULL COMMENT '对方负责人联系电话',
  `Fcorporate_authorize_email` varchar(32) NOT NULL COMMENT '对方授权电子邮箱',
  `Flaw_of_country_id` int(10) NOT NULL COMMENT '适用法律（国家名），关联国家表',
  `Fconflict_handle_way` tinyint(3) NOT NULL COMMENT '争议解决方式；0-仲裁；1-诉讼',
  `Fplace_of_arbitration` tinyint(3) NOT NULL COMMENT '仲裁地/管辖地；0-原告所在地；1-被告所在地；2-我方所在地；3-对方所在地；4-其他',
  `Fplace_name_of_arbitration` varchar(64) DEFAULT NULL COMMENT '地域名称；仲裁地/管辖地选择其他时填写',
  `Fexpress_type` tinyint(3) NOT NULL COMMENT '物流类型:0-国际物流；1-国内物流',
  `Fstock_type_is_bonded_area` tinyint(3) NOT NULL COMMENT '仓储服务类型:是否保税仓储;',
  `Fstock_type_is_out_aborad` tinyint(3) NOT NULL COMMENT '仓储服务类型:是否境外仓储',
  `Fwarehouse_address` varchar(128) NOT NULL COMMENT '仓库所在地',
  `Fpayment_type` tinyint(3) NOT NULL COMMENT '付款方式:0-电汇;1-信用证;2-银行承兑汇票;3-商业承兑汇票;4-支票;5-抵扣',
  `Fsettlement_days` int(10) DEFAULT NULL COMMENT '远期结算(天)',
  `Fsecurity_currency_type` varchar(16) NOT NULL COMMENT '保证金币别',
  `Fsecurity_amount` bigint(19) NOT NULL COMMENT '保证金金额',
  `Fdeposit_currency_type` varchar(16) NOT NULL COMMENT '定金币别',
  `Fdeposit_amount` bigint(19) NOT NULL COMMENT '定金金额',
  `Fprepaid_currency_type` varchar(16) NOT NULL COMMENT '预付款币别',
  `Fprepaid_amount` bigint(19) NOT NULL COMMENT '预付款金额',
  `Faccount_period` tinyint(3) NOT NULL COMMENT '账期描述:0-有账期;1-无账期',
  `Faccount_period_days` int(10) DEFAULT NULL COMMENT '账期天数',
  `Fquota` bigint(19) DEFAULT NULL COMMENT '额度',
  `Fpayment_remark` varchar(255) DEFAULT NULL COMMENT '付款备注',
  `Fother_payment_remark` varchar(255) DEFAULT NULL COMMENT '其他费用收/付款描述',
  `Fliquidated_damages_rate` bigint(19) DEFAULT NULL COMMENT '违约金比率',
  `Fliquidated_damages_from_days` int(10) DEFAULT NULL COMMENT '违约金开始收取日',
  `Finvoice_type` tinyint(3) NOT NULL COMMENT '我方收取发票类型:0-增值税专用发票;1-增值税普通发票;2-形式发票;3-无发票',
  `Ftax_rate` bigint(19) DEFAULT NULL COMMENT '税点:13%;10%;6%;5%;9%;8%;3%;0%',
  `Finvoice_deadline` varchar(50) DEFAULT NULL COMMENT '收票时效',
  `Fsettlement_currency_type` varchar(16) NOT NULL COMMENT '结算币别',
  `Fdrawee_account_type` tinyint(3) NOT NULL COMMENT '付款人类型(0:个人账户 1:公司账户)',
  `Fdrawee_account_is_oversea` tinyint(3) NOT NULL COMMENT '是否境外付款方(0-否 1-是)',
  `Fdrawee_account_name` varchar(64) NOT NULL COMMENT '付款人户名',
  `Fdrawee_account_num` varchar(50) NOT NULL COMMENT '付款人账号',
  `Fdrawee_account_bank_name` varchar(128) NOT NULL COMMENT '付款行名称',
  `Fdrawee_account_bank_address` varchar(255) DEFAULT NULL COMMENT '付款银行地址',
  `Fdrawee_account_swift_code` varchar(64) DEFAULT NULL COMMENT '付款银行SWIFTCODE',
  `Fpayee_account_type` tinyint(3) NOT NULL COMMENT '收款人类型(0:个人账户 1:公司账户)',
  `Fpayee_account_is_oversea` tinyint(3) NOT NULL COMMENT '是否境外收款方(0-否 1-是)',
  `Fpayee_account_name` varchar(64) NOT NULL COMMENT '收款人户名',
  `Fpayee_account_num` varchar(50) NOT NULL COMMENT '收款人账号',
  `Fpayee_account_bank_name` varchar(128) NOT NULL COMMENT '收款行名称',
  `Fpayee_account_bank_address` varchar(255) DEFAULT NULL COMMENT '收款银行地址',
  `Fpayee_account_swift_code` varchar(64) DEFAULT NULL COMMENT '收款银行SWIFTCODE',
  `Fremark` varchar(255) DEFAULT NULL COMMENT '框架协议备注',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  `Fagreement_no` varchar(32) DEFAULT NULL COMMENT '协议编号(规则生成)',
  PRIMARY KEY (`Fagreement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='仓库框架协议';

-- ----------------------------
-- Table structure for t_bb_warehouse_agreement_attachment
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_agreement_attachment`;
CREATE TABLE `t_bb_warehouse_agreement_attachment` (
  `Fid` int(10) NOT NULL AUTO_INCREMENT COMMENT '附件id',
  `Fagreement_id` int(10) NOT NULL COMMENT '仓库协议id',
  `Fattachment_type` varchar(64) NOT NULL COMMENT '附件名称',
  `Fattachment_url` varchar(64) NOT NULL COMMENT '附件url',
  `Fsequence_num` tinyint(3) NOT NULL COMMENT '排序号',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`Fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='仓库框架协议附件';

-- ----------------------------
-- Table structure for t_bb_warehouse_agreement_capital_flow
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_agreement_capital_flow`;
CREATE TABLE `t_bb_warehouse_agreement_capital_flow` (
  `Fcapital_flow_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '资金流向记录id',
  `Fagreement_id` int(10) NOT NULL COMMENT '仓库框架协议id',
  `Fsequence_num` tinyint(3) NOT NULL COMMENT '资金流向顺序编号：从1-5',
  `Fflow_name` varchar(64) NOT NULL COMMENT '资金流向名称',
  PRIMARY KEY (`Fcapital_flow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='仓库资金流向';

-- ----------------------------
-- Table structure for t_bb_warehouse_agreement_invoice_flow
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_agreement_invoice_flow`;
CREATE TABLE `t_bb_warehouse_agreement_invoice_flow` (
  `Finvoice_flow_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '发票流向记录id',
  `Fagreement_id` int(10) NOT NULL COMMENT '仓库框架协议id',
  `Fsequence_num` tinyint(3) NOT NULL COMMENT '发票流向顺序编号：从1-5',
  `Fflow_name` varchar(64) NOT NULL COMMENT '发票流向名称',
  PRIMARY KEY (`Finvoice_flow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='仓库发票流向';

-- ----------------------------
-- Table structure for t_bb_warehouse_inventory
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_inventory`;
CREATE TABLE `t_bb_warehouse_inventory` (
  `Finventory_id` varchar(32) NOT NULL COMMENT '盘点表id',
  `Fwarehouse_id` int(10) NOT NULL COMMENT '仓库id',
  `Fstatus` tinyint(3) DEFAULT NULL COMMENT '盘点表状态:0-草稿;1-已确认',
  `Fremark` varchar(255) DEFAULT NULL COMMENT '备注',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`Finventory_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='盘点表';

-- ----------------------------
-- Table structure for t_bb_warehouse_inventory_attchment
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_inventory_attchment`;
CREATE TABLE `t_bb_warehouse_inventory_attchment` (
  `Fid` int(10) NOT NULL AUTO_INCREMENT COMMENT '附件id',
  `Finventory_id` varchar(32) NOT NULL COMMENT '盘点表id',
  `Fattachment_url` varchar(64) NOT NULL COMMENT '附件url',
  `Fattachment_name` varchar(255) NOT NULL COMMENT '保存文件名',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`Fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='盘点表附件';

-- ----------------------------
-- Table structure for t_bb_warehouse_inventory_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_inventory_sku`;
CREATE TABLE `t_bb_warehouse_inventory_sku` (
  `Finventory_sku_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '明细表id',
  `Finventory_id` varchar(32) NOT NULL COMMENT '盘点表id',
  `Fsku_id` varchar(32) NOT NULL COMMENT 'skuid',
  `Fstatus` tinyint(3) DEFAULT NULL COMMENT 'sku状态:0-良品;1-不良品;2-临期;3-退货',
  `Factual_num` int(10) NOT NULL COMMENT '数量',
  `Fvalidty_end` date DEFAULT NULL COMMENT '有效期至',
  `Fsku_batch` int(10) DEFAULT NULL COMMENT '商品批次号',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  `Fenter_stock_num` varchar(32) DEFAULT NULL COMMENT '入仓号',
  `Fstock_amount` int(10) NOT NULL COMMENT '库存数量',
  `FearningsOrLosses` int(10) DEFAULT NULL COMMENT '盘盈/盘亏数量',
  PRIMARY KEY (`Finventory_sku_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='盘点表明细';

-- ----------------------------
-- Table structure for t_bb_warehouse_open_balance
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_open_balance`;
CREATE TABLE `t_bb_warehouse_open_balance` (
  `Fid` varchar(32) NOT NULL COMMENT '记录id',
  `Fwarehouse_id` int(10) NOT NULL COMMENT '仓库id',
  `Fowner_id` int(10) NOT NULL COMMENT '仓库主体id',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  `Fwarehouse_affiliation` varchar(128) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`Fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='期初表';

-- ----------------------------
-- Table structure for t_bb_warehouse_open_balance_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_open_balance_sku`;
CREATE TABLE `t_bb_warehouse_open_balance_sku` (
  `Fopen_balance_sku_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '期初明细id',
  `Fopen_balance_id` varchar(32) NOT NULL COMMENT '期初表id',
  `Fsku_id` varchar(32) NOT NULL COMMENT 'skuid',
  `Fstatus` tinyint(3) NOT NULL COMMENT 'sku状态:0-良品;1-不良品;2-临期;3-退货',
  `Factual_num` int(10) NOT NULL COMMENT '数量',
  `Fvalidty_end` date DEFAULT NULL COMMENT '有效期至',
  `Fsku_batch` int(10) DEFAULT NULL COMMENT '商品批次号',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  `Fenter_stock_num` varchar(32) DEFAULT NULL COMMENT '入仓号',
  PRIMARY KEY (`Fopen_balance_sku_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='期初明细记录';

-- ----------------------------
-- Table structure for t_bb_warehouse_other_enter_stock
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_other_enter_stock`;
CREATE TABLE `t_bb_warehouse_other_enter_stock` (
  `Fenter_stock_id` varchar(32) NOT NULL COMMENT '入库编号id',
  `Fenter_stock_type` tinyint(3) DEFAULT NULL COMMENT '入库类型:0-赠品;1-盘盈入库;2-其他入库',
  `Fapplicant_id` int(10) DEFAULT NULL COMMENT '申请人id',
  `Fwarehouse_id` int(10) DEFAULT NULL COMMENT '仓库id',
  `Fpurchase_aid` int(10) DEFAULT NULL COMMENT '采购负责人id',
  `Fenter_stock_status` tinyint(3) NOT NULL COMMENT '入库单状态:0-草稿,1-已接受;2-驳回;3-已入库',
  `Freject_reason` varchar(255) DEFAULT NULL COMMENT '驳回原因',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  `Fremark` varchar(255) DEFAULT NULL COMMENT '备注',
  `Finventory_id` varchar(32) DEFAULT NULL COMMENT '盘点单编号',
  `Fenter_stock_num` varchar(32) DEFAULT NULL COMMENT '入仓号',
  `fin_time` datetime DEFAULT NULL COMMENT '入库时间',
  `fcompany_Id` int(10) DEFAULT NULL COMMENT '供应商ID',
  PRIMARY KEY (`Fenter_stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='其他入库单';

-- ----------------------------
-- Table structure for t_bb_warehouse_other_enter_stock_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_other_enter_stock_sku`;
CREATE TABLE `t_bb_warehouse_other_enter_stock_sku` (
  `Fenter_stock_sku_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '其他入库sku明细id',
  `Fenter_stock_id` varchar(32) NOT NULL COMMENT '其他入库单id',
  `Fsku_id` varchar(32) NOT NULL COMMENT 'skuid',
  `Fstatus` tinyint(3) DEFAULT NULL COMMENT 'sku状态:0-良品;1-不良品;2-临期',
  `Factual_num` int(10) NOT NULL COMMENT '调入数量',
  `Fenter_stock_num` varchar(32) DEFAULT NULL COMMENT '入仓号',
  `Fvalidty_end` date DEFAULT NULL COMMENT '有效期至',
  `Fsku_batch` int(10) DEFAULT NULL COMMENT '商品批次号',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`Fenter_stock_sku_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='其他入库单sku明细';

-- ----------------------------
-- Table structure for t_bb_warehouse_other_out_stock
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_other_out_stock`;
CREATE TABLE `t_bb_warehouse_other_out_stock` (
  `Fout_stock_id` varchar(32) NOT NULL COMMENT '出库编号id',
  `Fout_stock_type` tinyint(3) NOT NULL COMMENT '出库类型:0-报损;1-盘亏出库;2-其他出库',
  `Fapplicant_id` int(10) NOT NULL COMMENT '申请人id',
  `Fwarehouse_id` int(10) NOT NULL COMMENT '仓库id',
  `Fpurchase_aid` int(10) DEFAULT NULL COMMENT '采购负责人id',
  `Fclient_id` int(10) DEFAULT NULL COMMENT '渠道客户id',
  `Fdestination` varchar(32) DEFAULT NULL COMMENT '目的地',
  `Fphone_number` varchar(16) DEFAULT NULL COMMENT '联系电话',
  `Fdelivery_address` varchar(255) DEFAULT NULL COMMENT '收货地址',
  `Fout_stock_status` tinyint(3) NOT NULL COMMENT '出库单状态:0-草稿,1-已接受;2-驳回;3-已出库',
  `Freject_reason` varchar(255) DEFAULT NULL COMMENT '驳回原因',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  `Fremark` varchar(255) DEFAULT NULL COMMENT '备注',
  `Finventory_id` varchar(32) DEFAULT NULL COMMENT '盘点单编号',
  `fout_time` datetime DEFAULT NULL COMMENT '出库时间',
  PRIMARY KEY (`Fout_stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='其他出库单';

-- ----------------------------
-- Table structure for t_bb_warehouse_other_out_stock_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_other_out_stock_sku`;
CREATE TABLE `t_bb_warehouse_other_out_stock_sku` (
  `Fout_stock_sku_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '其他出库sku明细id',
  `Fout_stock_id` varchar(32) NOT NULL COMMENT '其他出库单id',
  `Fsku_id` varchar(32) NOT NULL COMMENT 'skuid',
  `Fstatus` tinyint(3) DEFAULT NULL COMMENT 'sku状态:0-良品;1-不良品;2-临期',
  `Factual_num` int(10) NOT NULL COMMENT '调出数量',
  `Fenter_stock_num` varchar(32) DEFAULT NULL COMMENT '入仓号',
  `Fvalidty_end` date DEFAULT NULL COMMENT '有效期至',
  `Fsku_batch` int(10) DEFAULT NULL COMMENT '商品批次号',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`Fout_stock_sku_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='其他出库单sku明细';

-- ----------------------------
-- Table structure for t_bb_warehouse_po_enter_stock
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_po_enter_stock`;
CREATE TABLE `t_bb_warehouse_po_enter_stock` (
  `Fenter_stock_id` varchar(32) NOT NULL COMMENT '入库单id',
  `Fwarehouse_id` int(10) NOT NULL COMMENT '仓库id',
  `Fenter_stock_num` varchar(32) DEFAULT NULL COMMENT '入仓号',
  `Fenter_stock_remark` varchar(255) DEFAULT NULL COMMENT '仓库备注',
  `Fpurchase_order_enter_stock_id` varchar(32) NOT NULL COMMENT '采购入库通知单单号',
  `Fenter_stock_status` tinyint(3) NOT NULL COMMENT '入库单状态:0-草稿,1-已接受;2-驳回;3-已入库',
  `Freject_reason` varchar(255) DEFAULT NULL COMMENT '驳回原因',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  `Fin_time` datetime DEFAULT NULL COMMENT '入仓时间',
  PRIMARY KEY (`Fenter_stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='采购入库表';

-- ----------------------------
-- Table structure for t_bb_warehouse_po_enter_stock_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_po_enter_stock_sku`;
CREATE TABLE `t_bb_warehouse_po_enter_stock_sku` (
  `Fpo_enter_stock_sku_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '采购入库明细id',
  `Fpo_enter_stock_id` varchar(32) NOT NULL COMMENT '采购入库id',
  `Fpurchase_order_enter_stock_sku_id` int(10) NOT NULL COMMENT '采购入库通知skuid,对应t_bb_purchase_order_enter_stock_sku表',
  `Fsku_id` varchar(32) NOT NULL COMMENT 'skuid',
  `Fstatus` tinyint(3) DEFAULT NULL COMMENT 'sku状态:0-良品;1-不良品;2-临期',
  `Factual_num` int(10) NOT NULL COMMENT '实收数量',
  `Fvalidty_end` date DEFAULT NULL COMMENT '有效期至',
  `Fsku_batch` int(10) DEFAULT NULL COMMENT '商品批次号',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`Fpo_enter_stock_sku_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='采购入库sku明细';

-- ----------------------------
-- Table structure for t_bb_warehouse_po_return_out_stock
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_po_return_out_stock`;
CREATE TABLE `t_bb_warehouse_po_return_out_stock` (
  `Fout_stock_id` varchar(32) NOT NULL COMMENT '采购退货出库id',
  `Fwarehouse_id` int(10) NOT NULL COMMENT '仓库id',
  `Fpurchase_order_return_apply_id` varchar(32) DEFAULT NULL COMMENT '采购退货通知单id',
  `Fout_stock_remark` varchar(255) DEFAULT NULL COMMENT '出库备注',
  `Fout_stock_status` tinyint(3) NOT NULL COMMENT '出库单状态:0-草稿,1-已接受;2-驳回;3-已出库',
  `Freject_reason` varchar(255) DEFAULT NULL COMMENT '驳回原因',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  `Fout_time` datetime DEFAULT NULL COMMENT '出库时间',
  PRIMARY KEY (`Fout_stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='采购退货出库单';

-- ----------------------------
-- Table structure for t_bb_warehouse_po_return_out_stock_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_po_return_out_stock_sku`;
CREATE TABLE `t_bb_warehouse_po_return_out_stock_sku` (
  `Fpo_out_stock_sku_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '采购退货出库明细id',
  `Fpo_out_stock_id` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '采购退货出库单id',
  `Fpurchase_order_return_sku_id` int(10) NOT NULL COMMENT '采购退货出库通知skuid',
  `Fsku_id` varchar(32) COLLATE utf8_bin NOT NULL COMMENT 'skuid',
  `Fstatus` tinyint(3) DEFAULT NULL COMMENT 'sku状态:0-良品;1-不良品;2-临期',
  `Factual_num` int(10) NOT NULL COMMENT '实发数量',
  `Fenter_stock_num` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '入仓号',
  `Fvalidty_end` date DEFAULT NULL COMMENT '有效期至',
  `Fsku_batch` int(10) DEFAULT NULL COMMENT '商品批次号',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`Fpo_out_stock_sku_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='采购退货出库单sku明细 ';

-- ----------------------------
-- Table structure for t_bb_warehouse_so_out_stock
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_so_out_stock`;
CREATE TABLE `t_bb_warehouse_so_out_stock` (
  `Fout_stock_id` varchar(32) NOT NULL COMMENT '销售出库id',
  `Fwarehouse_id` int(10) NOT NULL COMMENT '仓库id',
  `Fsale_order_delivery_apply_id` varchar(32) NOT NULL COMMENT '销售出库通知单id',
  `Fcarrier` varchar(64) DEFAULT NULL COMMENT '承运商',
  `Fwaybill_no` varchar(32) DEFAULT NULL COMMENT '物流单号',
  `Fenter_stock_status` tinyint(3) NOT NULL COMMENT '出库单状态:0-草稿,1-已接受;2-驳回;3-已出库',
  `Freject_reason` varchar(255) DEFAULT NULL COMMENT '驳回原因',
  `Fout_stock_remark` varchar(255) DEFAULT NULL COMMENT '出库备注',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  `Fout_time` datetime DEFAULT NULL COMMENT '出库时间',
  PRIMARY KEY (`Fout_stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='销售出库单';

-- ----------------------------
-- Table structure for t_bb_warehouse_so_out_stock_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_so_out_stock_sku`;
CREATE TABLE `t_bb_warehouse_so_out_stock_sku` (
  `Fso_out_stock_sku_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '销售出库明细id',
  `Fso_out_stock_id` varchar(32) NOT NULL COMMENT '销售出库id',
  `Fsale_order_delivery_sku_info_id` int(10) NOT NULL COMMENT '销售出库通知skuid',
  `Fsku_id` varchar(32) NOT NULL COMMENT 'skuid',
  `Fstatus` tinyint(3) DEFAULT NULL COMMENT 'sku状态:0-良品;1-不良品;2-临期',
  `Factual_num` int(10) NOT NULL COMMENT '实发数量',
  `Fenter_stock_num` varchar(32) DEFAULT NULL COMMENT '入仓号',
  `Fvalidty_end` date DEFAULT NULL COMMENT '有效期至',
  `Fsku_batch` int(10) DEFAULT NULL COMMENT '商品批次号',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`Fso_out_stock_sku_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='销售出库单sku明细';

-- ----------------------------
-- Table structure for t_bb_warehouse_so_return_enter_stock
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_so_return_enter_stock`;
CREATE TABLE `t_bb_warehouse_so_return_enter_stock` (
  `Fenter_stock_id` varchar(32) NOT NULL COMMENT '入库单id',
  `Fwarehouse_id` int(10) NOT NULL COMMENT '仓库id',
  `Fenter_stock_num` varchar(32) DEFAULT NULL COMMENT '入仓号',
  `Fenter_stock_remark` varchar(255) DEFAULT NULL COMMENT '仓库备注',
  `Fsale_order_return_enter_stock_id` varchar(32) DEFAULT NULL COMMENT '销售退货入库通知单号',
  `Fenter_stock_status` tinyint(3) NOT NULL COMMENT '入库单状态:0-草稿,1-已接受;2-驳回;3-已入库',
  `Freject_reason` varchar(255) DEFAULT NULL COMMENT '驳回原因',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  `Fin_time` datetime DEFAULT NULL COMMENT '入库时间',
  PRIMARY KEY (`Fenter_stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='销售退货入库表';

-- ----------------------------
-- Table structure for t_bb_warehouse_so_return_enter_stock_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_so_return_enter_stock_sku`;
CREATE TABLE `t_bb_warehouse_so_return_enter_stock_sku` (
  `Fso_return_enter_stock_sku_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '销售退货入库明细id',
  `Fenter_stock_id` varchar(32) NOT NULL COMMENT '销售退货入库单id',
  `Fsale_order_return_enter_stock_sku_id` int(10) NOT NULL COMMENT '销售退货入库通知skuid,对应t_bb_sale_order_return_enter_stock_sku表',
  `Fsku_id` varchar(32) NOT NULL COMMENT 'skuid',
  `Fstatus` tinyint(4) DEFAULT NULL COMMENT 'sku状态:0-良品;1-不良品;2-临期',
  `Factual_num` int(10) NOT NULL COMMENT '实收数量',
  `Fvalidty_end` date DEFAULT NULL COMMENT '有效期至',
  `Fsku_batch` int(10) DEFAULT NULL COMMENT '商品批次号',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  `Fin_time` datetime DEFAULT NULL COMMENT '入库时间',
  PRIMARY KEY (`Fso_return_enter_stock_sku_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='销售退货入库sku明细';

-- ----------------------------
-- Table structure for t_bb_warehouse_status_change
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_status_change`;
CREATE TABLE `t_bb_warehouse_status_change` (
  `Fid` varchar(32) NOT NULL COMMENT '记录id',
  `Fwarehouse_id` int(10) NOT NULL COMMENT '仓库id',
  `Forigin_status` tinyint(3) NOT NULL COMMENT '原来状态:0-良品;1-不良品;2-临期;3-退货',
  `Fnew_status` tinyint(3) NOT NULL COMMENT '转换后的状态',
  `Fremark` varchar(255) DEFAULT NULL COMMENT '备注',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`Fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='状态变换主表';

-- ----------------------------
-- Table structure for t_bb_warehouse_status_change_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_status_change_sku`;
CREATE TABLE `t_bb_warehouse_status_change_sku` (
  `Fstatus_change_sku_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '状态转换明细id',
  `Fstatus_change_id` varchar(32) NOT NULL COMMENT '状态转换表id',
  `Fsku_id` varchar(32) NOT NULL COMMENT 'skuid',
  `Fstatus` tinyint(3) DEFAULT NULL COMMENT 'sku状态:0-良品;1-不良品;2-临期;3-退货',
  `Factual_num` int(10) NOT NULL COMMENT '数量',
  `Fvalidty_end` date DEFAULT NULL COMMENT '有效期至',
  `Fsku_batch` int(10) DEFAULT NULL COMMENT '商品批次号',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  `Fenter_stock_num` varchar(255) DEFAULT NULL COMMENT '入仓号',
  PRIMARY KEY (`Fstatus_change_sku_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='状态变换表明细';

-- ----------------------------
-- Table structure for t_bb_warehouse_stock
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_stock`;
CREATE TABLE `t_bb_warehouse_stock` (
  `Fstock_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '库存记录id',
  `Fwarehouse_id` int(10) NOT NULL COMMENT '仓库id',
  `Fsku_id` varchar(32) NOT NULL COMMENT 'skuid',
  `Famount` int(10) NOT NULL COMMENT '库存数量',
  `Fqualified_amount` int(10) DEFAULT NULL COMMENT '良品库存数量',
  `Fdefective_amount` int(10) DEFAULT NULL COMMENT '不良品库存数量',
  `Fnear_expire_amount` int(10) DEFAULT NULL COMMENT '临期数量',
  `Freturn_amount` int(10) DEFAULT NULL COMMENT '退货数量',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`Fstock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='库存表';

-- ----------------------------
-- Table structure for t_bb_warehouse_stock_flow
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_stock_flow`;
CREATE TABLE `t_bb_warehouse_stock_flow` (
  `Fflow_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '流水记录id',
  `Fbusiness_type` int(10) DEFAULT NULL COMMENT '业务类型:',
  `Fbill_type` tinyint(3) NOT NULL COMMENT '单据类型:0-采购入库;1-销售退货入库;2-调拨入库;3-其他入库;4-销售出库;5-采购退货出库;6-调拨出库;7-其他出库;8-状态转换;9-期初余额',
  `Fbill_num` varchar(32) DEFAULT NULL COMMENT '单据编号',
  `Fwarehouse_id` int(10) NOT NULL COMMENT '仓库id',
  `Fsupplier_id` int(10) DEFAULT NULL COMMENT '供应商id',
  `Fsku_id` varchar(32) DEFAULT NULL COMMENT 'skuid',
  `Fopen_balance` int(10) NOT NULL COMMENT '期初数量',
  `Famount` int(10) NOT NULL COMMENT '出入库数量',
  `Fclose_balance` int(10) NOT NULL COMMENT '期末数量',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`Fflow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='库存流水';

-- ----------------------------
-- Table structure for t_bb_warehouse_stock_state_batch_detail
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_stock_state_batch_detail`;
CREATE TABLE `t_bb_warehouse_stock_state_batch_detail` (
  `Fstock_detail_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '库存状态批次详细id',
  `Fwarehouse_id` int(10) NOT NULL COMMENT '仓库id',
  `Fskuid` varchar(32) NOT NULL COMMENT 'skuid',
  `Fstatus` tinyint(3) NOT NULL COMMENT '状态:0-良品;1-不良品;2-临期',
  `Fenter_stock_num` varchar(32) DEFAULT NULL COMMENT '入仓号',
  `Fstock_amount` int(10) NOT NULL COMMENT '库存数量',
  `Fvalidty_end` date DEFAULT NULL COMMENT '有效期至',
  `Fsku_batch` int(10) DEFAULT NULL COMMENT '商品批次号',
  `Fenter_stock_id` varchar(32) DEFAULT NULL COMMENT '关联入库单编号',
  `Fcreate_time` datetime DEFAULT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  `Fin_time` datetime DEFAULT NULL COMMENT '入库时间',
  `flong_in_time` bigint(11) DEFAULT NULL COMMENT '冗余字段，入货时间的长整型',
  PRIMARY KEY (`Fstock_detail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='库存分状态批次明细表';

-- ----------------------------
-- Table structure for t_bb_warehouse_transfer_enter_stock
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_transfer_enter_stock`;
CREATE TABLE `t_bb_warehouse_transfer_enter_stock` (
  `Fenter_stock_id` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '调拨入库id',
  `Fwarehouse_id` int(10) NOT NULL COMMENT '仓库id',
  `Ftransfer_enter_stock_id` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '调拨通知id',
  `Fenter_stock_num` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '入仓号',
  `Fenter_stock_status` tinyint(3) DEFAULT NULL COMMENT '入库单状态:0-草稿,1-已接受;2-驳回;3-已出库',
  `Fenter_stock_remark` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '入库备注',
  `Freject_reason` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '驳回原因',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  `Fout_stock_id` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '调拨出库id',
  `Fin_time` datetime DEFAULT NULL COMMENT '入库时间',
  `Fremark` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`Fenter_stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='调拨入库单 ';

-- ----------------------------
-- Table structure for t_bb_warehouse_transfer_enter_stock_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_transfer_enter_stock_sku`;
CREATE TABLE `t_bb_warehouse_transfer_enter_stock_sku` (
  `Fenter_stock_sku_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '调拨入库单明细id',
  `Fenter_stock_id` varchar(32) NOT NULL COMMENT '调拨入库单id',
  `Ftransfer_enter_stock_sku_id` int(10) NOT NULL COMMENT '调拨单通知skuid',
  `Fsku_id` varchar(32) NOT NULL COMMENT 'skuid',
  `Fstatus` tinyint(3) DEFAULT NULL COMMENT 'sku状态:0-良品;1-不良品;2-临期',
  `Factual_num` int(10) NOT NULL COMMENT '调入数量',
  `Fenter_stock_num` varchar(32) DEFAULT NULL COMMENT '入仓号',
  `Fvalidty_end` date DEFAULT NULL COMMENT '有效期至',
  `Fsku_batch` int(10) DEFAULT NULL COMMENT '商品批次号',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`Fenter_stock_sku_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='调拨入库单sku明细';

-- ----------------------------
-- Table structure for t_bb_warehouse_transfer_out_stock
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_transfer_out_stock`;
CREATE TABLE `t_bb_warehouse_transfer_out_stock` (
  `Fout_stock_id` varchar(32) NOT NULL COMMENT '调拨出库id',
  `Fwarehouse_id` int(10) NOT NULL COMMENT '仓库id',
  `Ftransfer_out_stock_id` varchar(32) NOT NULL COMMENT '调拨通知id',
  `Fout_stock_status` tinyint(3) NOT NULL COMMENT '出库单状态:0-草稿,1-已接受;2-驳回;3-已出库',
  `Fout_stock_remark` varchar(255) DEFAULT NULL COMMENT '出库备注',
  `Freject_reason` varchar(255) DEFAULT NULL COMMENT '驳回原因',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  `Fout_time` datetime DEFAULT NULL COMMENT '出库日期',
  `Fenter_stock_id` varchar(32) DEFAULT NULL COMMENT '调拨入库id',
  `Fremark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`Fout_stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='调拨出库单';

-- ----------------------------
-- Table structure for t_bb_warehouse_transfer_out_stock_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_bb_warehouse_transfer_out_stock_sku`;
CREATE TABLE `t_bb_warehouse_transfer_out_stock_sku` (
  `Fout_stock_sku_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '调拨出库单明细id',
  `Fout_stock_id` varchar(32) NOT NULL COMMENT '调拨出库单id',
  `Ftransfer_out_stock_sku_id` int(10) NOT NULL COMMENT '调拨单通知skuid',
  `Fsku_id` varchar(32) NOT NULL COMMENT 'skuid',
  `Fstatus` tinyint(3) DEFAULT NULL COMMENT 'sku状态:0-良品;1-不良品;2-临期',
  `Factual_num` int(10) NOT NULL COMMENT '调出数量',
  `Fenter_stock_num` varchar(32) DEFAULT NULL COMMENT '入仓号',
  `Fvalidty_end` date DEFAULT NULL COMMENT '有效期至',
  `Fsku_batch` int(10) DEFAULT NULL COMMENT '商品批次号',
  `Fcreate_time` datetime NOT NULL COMMENT '创建时间',
  `Fmodify_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`Fout_stock_sku_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='调拨出库单sku明细';
