# Spring配置文件
- bean
  - id bean的id
  - class bean的类
  - scope 作用范围
    - singleton： 单例的，每次返回同一个对象，容器加载时创建对象，容器存在就不回收，默认
    - prototype： 多例的，每次返回不同对象，需要容器返回对象时才创建，长时间不用销毁
    - request： request域
    - session： session域
    - global session： Portlet环境中使用
  - init-method:初始化方法名称
    - 创建对象时执行
  - destory-method：销毁方法
    - 销毁对象时执行

bean实例化方法：
1. 无参构造方法
   ```xml
    <bean id="userDao" class="top.snowlands.dao.impl.UserDaoImpl"></bean>
   ```
2. 工厂静态方法
   factory-method： 指定工厂方法
   ```xml
   <bean id="userDao" class="top.snowlands.factory.StaticFactory" factory-method="getUserDao"></bean>
   ```
3. 工厂实例方法
    ```xml
    <bean id="factory" class="top.snowlands.factory.DynamicFactory"></bean>
    <bean id="userDao" factory-bean="factory" factory-method="getUserDao"></bean>
    ```

依赖注入
自动给成员变量赋值
```xml
<bean id="userService" class="top.snowlands.service.impl.UserServiceImpl">
        <!--自动注入-->
        <property name="userDao" ref="userDao"></property>
</bean>
```

p命名空间注入
```xml
<bean id="userService" class="top.snowlands.service.impl.UserServiceImpl" p:userDao-ref="userDao"></bean>
```
   
有参构造
```xml
    <bean id="userService" class="top.snowlands.service.impl.UserServiceImpl">
        <constructor-arg name="userDao" ref="userDao"></constructor-arg>
    </bean>
```

普通属性值依赖注入
```xml
    <bean id="userDao" class="top.snowlands.dao.impl.UserDaoImpl" scope="prototype" init-method="init" destroy-method="destory">
        <property name="age" value="24"></property>
        <property name="username" value="jack"></property>
    </bean>
```

集合类的注入 list map properties
```xml
    <bean id="userDao" class="top.snowlands.dao.impl.UserDaoImpl" scope="prototype" init-method="init" destroy-method="destory">
        <property name="stringList" >
            <list>
                <value>jack</value>
                <value>tom</value>
                <value>tim</value>
            </list>
        </property>
        <property name="userMap">
            <map>
                <entry key="甲" value-ref="user1"></entry>
                <entry key="乙" value-ref="user2"></entry>
            </map>
        </property>
        <property name="properties">
            <props>
                <prop key="p1" >ppp1</prop>
                <prop key="p2" >ppp2</prop>
                <prop key="p3" >ppp3</prop>
            </props>
        </property>
    </bean>
```

- 分模块开发 import引入其他文件
```xml
    <import resource="applicationContext-user.xml"></import>
    <import resource="applicationContext-product.xml"></import>
```

spring API1
在类加载路径下的xml配置文件加载
```java
    ApplicationContext app=new ClassPathXmlApplicationContext("applicationContext.xml");
```
文件路径下的xml配置文件加载
```java
    ApplicationContext app=new FileSystemXmlApplicationContext("src\\main\\resources\\applicationContext.xml");
```

getBean()方法的使用
id或字节码类型