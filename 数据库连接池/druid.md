druid数据库连接池
1. 导入jar包
druid-1.0.9
2. 定义配置文件:
- properties形式文件
```properties
# druid.properties
driverClassName=com.mysql.jdbc.Driver
url=jdbc:mysql:///day17
username=root
password=4004123a
# 初始化连接数量
initialSize=5
# 最大连接数
maxActive=10
# 最大等待时间
maxWait=3000
```
- 可以是任意名称，可以放在任意目录下
- 获取数据库连接池对象：通过工厂类获取
DruidDataScourceFactory
- 获取连接getConnection

```java
//1.导入jar包
//2.定义配置文件
//3.加载配置文件
Properties pro=new Properties();
InputStream is = DruidDemo.class.getClassLoader().getResourceAsStream("druid.properties");
pro.load(is);
//4.获取连接池对象
DataSource ds = DruidDataSourceFactory.createDataSource(pro);
//5.获取连接
Connection conn = ds.getConnection();
System.out.println(conn);
```
