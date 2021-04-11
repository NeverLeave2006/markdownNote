# SQL优化

## mysql版本
目前最新的是8
主流5.x
    5.0-5.1:早期版本的延续，升级维护
    5.4-5.x:mysql整合了三方公司的新存储引擎(5.5-5.7)

linux rpm版本安装
```shell
rpm -ivh 软件包
```
启动
```shell
service mysql start
```
关闭
```shell
service mysql stop
```
重启
```shell
service mysql restart
```

登录
```shell
mysql -u用户名 -p
```

如果mysql服务没有启动
1. 每次使用前手动启动
```shell
/etc/init.d/mysql start    
```
2. 开机自启
```shell
chkconfig mysql on  #开机自启
chkconfig msyql off # 结束开机自启
ntsysv #检查是否开机自启
```

修改密码
```shell
mysqladmin -u root new-password
```

查看数据库存放目录
```mysql
ps -ef|grep mysql
```
数据库目录
pid文件目录
Mysql核心目录:
    安装目录
    配置文件
    命令目录



## 底层原理

逻辑分层
- 链接层
- 服务层，提供接口 crud,sql优化器
- 引擎层，各种存储数据的方式InnoDB(事务优先,行锁)和myISAM(性能优先,表锁)
```shell
show engines;#查询数据库引擎
show variables like '%storage_engine%'; #查看当前使用的引擎
```
- 存储层，存储数据


指定数据库对象引擎
```SQL
create table tb{
    id int(4) auto_increment,
    name varchar(5),
    dept varchar(5),
    primary key(id)
}ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
```

## SQL优化

原因：性能低，执行时间长，sql语句欠佳，索引失效，服务器参数设置不合理
a.sql
    编写过程：
    select distinct ... from ... join ... on ... where ... group by ... having ... order by ... limit ...
    解析过程：
        先解析from   ... on ... join ... where ... group by ... having ... select ... order by ... limit ...
        FO(n)JWGHSO(rder by)L
## 索引

b.sql优化，主要就是在优化索引
    索引： 相当于书的目录
    索引： index是帮助MySQL高效获取数据的数据结构。索引是数据结构（树:B树，Hash树...）
    索引弊端：
        1.索引本身很大，可以存放在内存，硬盘
        2.索引并不是所有情况都适用:a.少量数据，b频繁更新的字段，c.很少使用的字段
        3.索引确实可以提高查询的效率，但是降低增删改的效率
    优势: 1.提高查询效率(降低IO效率)
          2.降低CPU使用率(索引本身就是排好序的结构)
          3层B树可以放上百万条数据，一般是B+树，数据放叶节点
          B+树查询任意数据次数n次

索引分类
- 单值索引： 一个表可以有多个单值索引
- 唯一索引： 不能重复的索引
- 复合索引： 多个列构成，相当于书的二级目录


创建索引：
```sql
create 索引类型 索引名 on 表(字段);
-- 单值索引
create index dept_index on tb(dept);
-- 唯一索引
create unique index name_index on tb(name);
-- 复合索引
create index dept_name_index on tb(dept,name);

-- 删除索引
drop index 索引名 on 表名;
drop index name_index on table db;

-- 查看表名的索引
show index from 表名;
show index from 表名 /G
```
注意：如果一个字段是primary key 则该字段默认是主键索引，都是单值索引
    主键索引和唯一索引区别：主键不能为null,唯一索引可以是null
/g结尾和/G结尾不同

## SQL性能问题，优化方法

a. 分析SQL的**执行计划**：explain，模拟sql优化器，从而让开发人员知道自己开发的sql状况
b.mysql查询优化器会干扰我们的优化

优化方法，官网
查询执行方法：
```SQL
explain [sql语句];
explain select * from tb;

+----+-------------+-------+------+---------------+------+---------+------+------+-------+
| id | select_type | table | type | possible_keys | key  | key_len | ref  | rows | Extra |
+----+-------------+-------+------+---------------+------+---------+------+------+-------+
|  1 | SIMPLE      | city  | ALL  | NULL          | NULL | NULL    | NULL | 4321 |       |
+----+-------------+-------+------+---------------+------+---------+------+------+-------+
select_type: 查询类型
type：类型
possible_keys： 遇刺用到的索引
key：实际使用的索引
key_len：实际使用的索引长度
ref：表之间的引用
rows：通过索引查到的数据量
Extra：额外的信息
```
id值相同，从上到下顺序执行
数据小的表先查询，数据大的表往后放，根据**笛卡尔积**，数据量比较小，
id值不同，从上到下优先查询

多表查询转子查询

select_type:
PRIMARY：包含子查询SQL中的主查询(最外层)
SUBQUERY: 包含子查询SQL中的子查询(非最外层)
simple：简单查询
derived: 衍生查询(使用到了临时表)
    a.在from子查询中只有一张表
        select * from course where tid in (1,2)
    b.在from子查询中，如果有table1 union table2，则table1就是derived

## 优化案例

- id:
    id值相同 从上往下顺序执行，
    id值越大越优先查询(先外层，后内层)
        小表先执行笛卡尔积
- select_type:
    PRIMARY: 包含子查询SQL中的 主查询(最外层)
    SUBQUERY: 包含子查询SQL中的 子查询(非最外层)
    simple: 简单查询，无子查询 union
    derived: 衍生查询,用于临时表
    union result: 联合查询结果
- type: 索引类型,类型
  - system：表**只有一行记录**，相当于系统表
  - const：通过索引一次就找到，**只匹配一行数据**, 用于peimary key或者unique索引(类型与索引类型有关)
  - eq_ref: 唯一性索引扫描，对于每个索引键，表中只有一条记录与之匹配
  - **ref**：非唯一性索引扫描，返回匹配某个单独值的所有行用于=、<、> 操作符带索引的列，in有时候会失效
  - **range**：只检索给定范围的行，使用一个索引来选择行一般使用 between、<、>
  - index：只遍历索引树
  - ALL：全表扫描，性能最差   
对Type进行优化的前提是需要有索引

eq_ref: 结果多条，每条数据唯一
ref: 结果多条，每条数据是0或者多条

- possible_keys: 可能的索引,是一种预测，不准
- key：实际的索引
- key_len: 用于判断符合索引是否被完全使用(字符长度*column长度,复合索引多个相加，可用为null+1，可变长度+2)

- ref: 注意与type中的ref值区分。
        作用: 指明当前表所参照的字段。
        select ... where a.c=b.x;(其中b.x可以是常量)
- rows: 被索引优化查询的数据个数(实际通过索引而查询到的数据个数)
- Extra:
  - using filesort: 性能消耗大；需要"额外"的一次排序/查询
符合索引，不能跨列，(最佳左前缀)
where 和 order by 按照复合索引的顺序使用，不要跨列或者无序使用
  - using temporary 使用了临时表，一般出现在group by语句中, 尽量去掉
    - 出现原因: 已经有表了，但不适用，必须再来一张表
    - 避免: 查询哪些列就用哪些列分组
  - using where: 会查原表数据
  - using index: 性能提升了;索引覆盖,说明此次不读取源文件,只查索引, 只要使用到的列全部到索引中
  - impossible where: where子句为false
  - using join buffer: mysql  底层给你加了buffer缓存

总结：
1. 如果(a,b,c,d)复合索引和使用的顺序全部一致(且不跨列使用),则复合索引全部使用。如果部分一致(且不跨列使用),则使用部分索引。

优化案例
单表优化，两表优化，三表优化
最左前缀原则，范围查询放后面

小结:
a. 索引不能跨列使用
b. 索引需要逐步优化
c. 将含有in的条件查询放到最后,含in的查询可能会使索引失效

多表优化：
1. 小表驱动大表，小表放左边，大表放右边，减少遍历次数,对于双层循环，建议外小，内大
2. 索引建立在经常使用的字段上(对于左外连接，给左表加索引，右外连接给右表加索引)

三表优化:
a. 小表驱动大表
b. 索引建立在经常查询的字段上

## 避免索引失效(优化失败)的一些原则
a. 复合索引不要跨列或者无序使用(最佳左前缀)
b. 尽量使用全索引匹配
c. 不要在索引上进行操作，否则索引失效
d. 对于复合索引（a,b,c）,b失效，则c失效
e. 复合索引不能使用!=，或者is not null

sql优化器有一定概率，至于是否实际优化了需要explain,优化器可能影响我们的优化
一般而言，范围查询后的索引失效
补救：尽量使用索引覆盖(using index)，这个不会变

like尽量以常量开头，不要以%开头

尽量不要使用类型转换，显式，隐式都会使索引失效

尽量不要使用or否则索引失效(两边都失效)

## 一些其他优化方法
1. exist和in
   select ... from table where exist/in (子查询)
   如果主查询的数据集更大，则使用in
   如果子查询的数据集大，则使用exist
    exist语法: 将主查询的结果放到子查询中校验是否有数据(如果有数据，则成称为校验成功)
   select tname from teacher where exists (select * from teacher);

2. order by 优化:
- using filesort 有两种算法：双路排序，单路排序(IO次数)
Mysql4.1前 默认双路排序，4.1之后默认单路排序
IO非常消耗性能，单路只读取一次，比双路快，单路排序比双路占用更多buffer
max_length_for_sort_data值太低，mysql会从单路切换到双路
- 避免使用select *
- 复合索引，不要跨列使用，避免using filesort
- 保证全部排序字段排序的一致性(都是升序或者降序)

## SQL排查 - 慢查询日志
mysql提供的一种日志记录
- 检查是否开启慢查询日志:
show variables like '%slow_query_log%';

- 临时开启:
set global slow_query_log=1; --在内存中临时开启

- 永久开启:
/etc/my.cnf中追加设置
vi /etc/my.cnf
```cnf
[mysqld]
slow_query_log=1
slow_query_log_file=/var/lib/mysql/localhost-slow.log
```

- 慢查询阈值:
show variables like '%long_query_time%';

- 临时设置阈值:
set global long_query_time=5; --设置完毕后，重新登录起效(不需要重启服务)

- 永久设置阈值：
/etc/my.cnf中追加设置
vi /etc/my.cnf
```cnf
[mysqld]
long_query_time=3
```

- 查询超过阈值的SQL个数:
```sql
show global status like '%slow_queries%';--查询个数
```
- 查看慢查询日志:
```shell
cat /var/lib/mysql/localhost-slow.log
```
- 通过mysqldumpslow工具查看慢SQL,可用通过一些过滤条件 快速查找出需要定位的慢SQL
mysqldumpslow --help
s: 排序方式
r: 逆序
l: 锁定时间
g: 正则匹配模式
```sql
-- 获取返回记录组最多的3个SQL
mysqldumpslow -s R -T 3 /var/lib/mysql/localhost-slow.log

-- 获取访问次数最多的3个SQL
mysqldumpslow -s c -t 3 /var/lib/mysql/localhost-slow.log

-- 按照时间排序，前10条包含left join查询语句的SQL
mysqldumpslow -s t -t 10 "left join" /var/lib/mysql/localhost-slow.log

```

## 分析海量数据
a. 模拟海量数据


## 锁机制：解决因资源共享而造成的并发问题
## 主从复制