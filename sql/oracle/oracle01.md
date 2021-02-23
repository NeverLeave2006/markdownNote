oracle数据库
甲骨文

命令行操作
1. 登录
sqlplus 用户名/密码 [as sysdba]

sqlplus scott/tiger

2. 查看当前连数据库的用户
show user
3. 连接/切换用户
conn sys/sys as sysdba
4. 查看当前用户下的表
select * from tab;
5. 