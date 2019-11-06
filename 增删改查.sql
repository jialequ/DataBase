-----------------------------------------库操作-----------------------------------------------------------------

--创建数据库
create database 数据库名;
--查看数据库
show databases;
--创建一个使用utf8字符集的 db2 数据库
create database db2 charset=utf8;
--查看数据库支持的字符集校验规则
show collation;
--显示详细创建过程
show create database 数据库名；
--修改数据库
alter database 数据库名 [];
--删库
drop database [IF EXISTS] 数据库名;
--备份
mysqldump -uroot -B 数据库名 > 数据库备份存储的文件路径;
--查看连接情况
show processlist;

-----------------------------------------表操作-----------------------------------------------------------------

--创建表
create table 表名(
	变量名1 变量类型 参数 comment "注释";
	变量名2 变量类型 参数 comment "注释";
)character set 字符集 collate 校验规则 engine 存储引擎;
--删除表
drop table 表名;
--插入数据
insert into 表名 values (值1, 值2);
--查看表格
show tables;
--查看某个表格的详细信息
desc table_name;

--修改表(针对某一列)
1. alter table 表名 add column 列名 [类型] [约束] [first/after] [列名];
	--例 : alter table test add age int;
2. alter table 表名 drop 列名;
3. alter table 表名 modify 
	--不能修改字段名
	--例 : alter table users modify age tinyint unsigned;
4. alter table 表名 change age ages int;
	--可以修改字段名

--表重命名
rename table one to two;

--------------------------------------表中数据操作--------------------------------------------------------------
CREATE TABLE exam (
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(20) NOT NULL COMMENT '同学姓名',
	chinese float DEFAULT 0.0 COMMENT '语文成绩',
	math float DEFAULT 0.0 COMMENT '数学成绩',
	english float DEFAULT 0.0 COMMENT '英语成绩'
);
INSERT INTO exam (name, chinese, math, english) VALUES
	('屈佳乐', 67, 98, 56),
	('李少琦', 87, 78, 77),
	('白凯鹏', 88, 98, 90),
	('林佳', 82, 84, 67),
	('刘康', 55, 85, 45),
	('魏登', 70, 73, 78),
	('王猛', 75, 65, 30);
--增
insert into 表名 values ();
ON DUPLICATE KEY UPDATE
	--针对某个数据
REPLACE INTO students (sn, name) VALUES (20001, '曹阿瞒');
	--针对整行操作
	
--删-----------------------DELETE-----------------------------
	--(对行操作)
--删除整个表
1. delete from exam;    自增值不会消失
--删除屈佳乐的所有数据
2. delete from exam where name = "屈佳乐";
--截断表(整表操作, 自增值会消失, 比delete快)
3. truncate exam;

--改-----------------------UPDATE-----------------------------
--对单个数据操作
--将屈佳乐的数据成绩改为80
1. update exam set math = 80 where name = '屈佳乐';
--将李少琦同学的数学成绩变更为 60 分，语文成绩变更为 70 分
2. update exam set math = 60, chinese = 70 where name = "李少琦";
--将总成绩倒数前三的 3 位同学的数学成绩加上 30 分
3. update exam set math = math + 30 order by chinese + math + english desc limit 3;
--将所有同学的语文成绩更新为原来的两倍
4. update exam set chinese = 2 * chinese;

--查-----------------------SELECT-----------------------------
SELECT
	[DISTINCT] {* | {column [, column] ...}
	[FROM table_name]
	[WHERE ...]
	[ORDER BY column [ASC | DESC], ...]
	
	LIMIT ...
---------------------SELECT-------------------
1. select * from exam;
--查找某两列
2. select name,chinese from exam;
--查找时+10
3. select name, chinese + 10 from exam;
4. select name, format(sqrt(chinese) * 10, 2) from exam;
--查找时指定列名 as
5. select name, chinese + math + english as 总分 from exam;

--------------------DISTINCT------------------
6. select distinct name, math from exam;
--删除重复项
7. select distinct math from exam;
--将查询结果插入到新表中
8. insert into one select distinct * from two;

---------------------WHERE-------------------
--行筛选
--英语不及格
1. select name, english from exam where english < 60;
--语文在80 ~ 90
2_1. select name, chinese from exam where chinese <= 90 and chinese >= 80;
2_2. select name, chinese from exam where chinese between 80 and 90;
-- 数学成绩是 58 或者 59 或者 98 或者 99 分的同学及数学成绩
3_1. select name, math from exam where math in (58, 59, 98, 99);
3_2. select name, math from exam where math = 58 or math = 59 or math = 98 or math = 99;
--姓屈的
4_1. select id, name from exam where name like '屈%';
4_2. select id, name from exam where name like '屈__';
--语文比英语好
5. select name, chinese, english from exam where chinese > english;
--总分在 200 分以下的同学
6. select name, chinese + english + math as 总分 from exam where chinese + english + math < 200; 
--语文成绩 > 80 并且不姓李的同学
7. select name, chinese from exam where chinese > 80 and name not like '李%';
--屈某同学，否则要求总成绩 > 200 并且 语文成绩 < 数学成绩 并且 英语成绩 > 80
8. select name, chinese, math, english, chinese + english + math as 总分 from exam 
	where (name like '屈%') or (chinese + english + math > 200 and chinese < math and english > 80);
	
---------------------------排序-------------------------------
--升序, 默认不用写
1. select name, math from exam order by math;
--降序
2. select name, math from exam order by math DESC;
--复合排序, 数学相同用语文排序
3. select name, math, chinese from exam order by math, chinese;
--NULL比任何值都小
--总分前3
4. select name, math, chinese, english, math + chinese + english as 总分 from exam order by 总分 desc limit 3;
--跳过前3行后打印3行
5. select name, math, chinese, english, math + chinese + english as 总分 from exam order by 总分 desc limit 3,3;

----------------------------------------------------------------------------------------------------------------





