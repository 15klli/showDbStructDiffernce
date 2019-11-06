# showDbStructDiffernce

#### 介绍

寻找两个数据库结构的不同之处，并生成对应的能保证两个数据库结构一致的sql

#### 用途

1. 用于项目上线时，对比 **正式服务器中的数据库** 与 **测试服务器中的数据库**之间的改动，以便快速、无遗漏地上线
2. 对比两个 数据库的区别，以便发现索引、字符编码、主键变化等隐秘地方的区别

#### 1.0版本使用说明

1. 使用`Navicat`软件导出 正式服数据库 以及 测试服服务器 数据库的表结构，获得两个 `sql`。![export_sql](https://gitee.com/klli852/showDbStructDiffernce/blob/master/src/main/resources/imgFolder/export_sql.png)
2. 将两个文件放在`src/main/resources/sqlDir`下
3. 然后在 `Demo`类中指定相应的文件，运行即可
   
   > 1. `fromFileName` 为待升级的数据库`sql`文件，如 正式服的数据库
   > 2. `toFileName` 为想把待升级数据库 变成什么样的目标数据库`sql`文件，如 测试服的数据库
4. `GeneratorUtils.generate()`方法返回一个`SQLResult`对象，
5.  `SQLResult.getCanRunSqlString()`返回的是可以直接运行的`sql`语句，这里仅含**增加表格/增加字段/修改字段（不含删除）** 的操作，如
   
   ```sql
   /*==================【Start】创建表格语句==================*/
   
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
   /*==================【End】创建表格语句==================*/
   
   /*==================【Start】以下是修改表格语句==================*/

   
   /*--------------------【START】表格t_bb_oa_comment的修改SQL语句-----------------------*/

   
   ALTER TABLE `t_bb_oa_comment` ADD COLUMN `Fprocess_id1` INT(11) NOT NULL   COMMENT "流程id";
   ALTER TABLE `t_bb_oa_comment` MODIFY COLUMN `Fhandle_time` DATETIME NULL   COMMENT "处理时间";
   ALTER TABLE `t_bb_oa_comment` ADD COLUMN `Fpayment_desc_page_num` INT(11) NULL DEFAULT NULL  COMMENT "账期描述合同页码";
   ALTER TABLE `t_bb_oa_comment` MODIFY COLUMN `Fmodify_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "修改时间";
   
   /*--------------------【END】表格t_bb_oa_comment的修改SQL语句-----------------------*/
   
   /*==================【End】修改语句结束==================*/
   ```
   
   
6. `SQLResult.getNeedHandleSqlString()`返回的是需要人工处理的`sql`语句，包含了会改变表结构的 **删除/重命名**等操作。如：
   
   ```sql
   /*--------------------分割线A开始-----------------------*/
   
   -- ----------------------------
   --  字段重命名检测：【t_bb_oa_comment】表格中的 【Fprocess_id】字段名可能改成了 【Fprocess_id1】
   --  如果不是，请运行以下语句删除旧数据列
   --  ALTER TABLE `t_bb_oa_comment` DROP COLUMN `Fprocess_id`;
   --  如果是,请运行以下语句
   -- ----------------------------
   ALTER TABLE `t_bb_oa_comment` DROP COLUMN `Fprocess_id1`;
   ALTER TABLE `t_bb_oa_comment` CHANGE COLUMN `Fprocess_id` `Fprocess_id1` INT(11) NOT NULL   COMMENT "流程id";
   
   
   /*--------------------分割线A结束-----------------------*/
   ```
   
   

#### 注意事项

1. `1.0` 版本只支持 `Navicat` 导出的`sql`文件，导出后请不要修改，保持导出文件原封不动，以免识别有误

2. `SQLResult.getCanRunSqlString()`返回的`sql`语句可以直接执行，但`SQLResult.getNeedHandleSqlString()`返回的`sql`语句*一定要人工处理* ，否则可能会出现数据被误删

3. 目前只支持 `Innodb`引擎

#### 默认规则

1. **表格名相同**以及**表格相似度超过阈值-0.8**的两个超过视作同一个表格

2. **字段名相同**以及**字段相似度超过阈值-0.8**的两个超过视作同一个表格

> 阈值可以在 `Constants`类中进行设置。表格相似度阈值-`TABLE_SAME_THRESHOLD`；字段相似度阈值-`ROW_SAME_THRESHOLD`。相似度的计算法则在`PercentCalculateUtils`类中

#### 软件架构

##### 数据类

* `Table`类：将`Mysql`的表格信息提取成为`Table`的数据

* `Row`类：表格中的各个字段，有数据类型、字段名、长度等属性

* `TableIndex`类：记录非主键索引信息的类

* `SQLResult`类：返回生成的 `sql`语句予用户
  
  ##### 工具类

* `InitDataFromFile`类：从文件中读取内容并组装 `Table` 类

* `SQLUtils`类：该工具类用于以后直接从数据库读取信息初始化`Table`类所用

* `Generator`类：生成`sql`的具体生成逻辑，相当于操作人，调用`SqlFactory`的静态方法

* `SqlFactory`类：生产所有`sql`语句以及提示语的工厂类

* `GeneratorUtils`类：与用户交互的类

* `PercentCalculateUtils`类：对比两不同名的表格之间以及两个不同名的字段之间的相似度，当相似度超过相应阈值后，视作同一个表格/字段
  
  ##### Common类

* 包括异常、枚举类等

#### TODO

1. 允许连接数据库直接获取Table信息，跳过导出`sql`文件的步骤

2. 优化相似度计算法则

3. 优化：使用正则表达式在处理之前筛选不支持的文件

4. 优化：错误提示

#### 联系我

* Email: 852778163@qq.com
