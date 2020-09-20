## Spring JDBC
- Spring 框架对JDBC的简单封装。提供了一个JDBCTemplate对象简化JDBC的开发
- 步骤：
  1. 导入jar包
  2. 创建JdbcTemplate对象。依赖于数据源DataSource
    - JdbcTemplate template=new JdbcTemplate(ds);
  3. 对应JdbcTemplate的方法完成crud操作
    - update():执行DML语句。增删改语句
    - queryForMap:查询结果，将结果集封装为map集合
    - 查询结果，将结果集封装为lits集合
    - query():查询结果，将结果封装为JavaBean对象
    - queryForObject:查询结果，将结果集封装为对象
```java
//1.导入jar包
//2.创建JDBCTemplate对象
JdbcTemplate template=new JdbcTemplate(JDBCUtils.getDataSource());
//3.调用方法
String sql="update user set qq = 12345 where id = ?";
int count = template.update(sql, 1);
System.out.println(count);
```
