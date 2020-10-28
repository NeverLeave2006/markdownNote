# day03

## 接口（续）

1. 如何定义接口
```java
public interface 接口名{//告诉JVM这是在定义一个接口，后面是接口的名称，后面的大括号是接口的范围

}
```
在IDEA中, 右键->new->Interface
2. 如何实现接口
```java
//类实现接口，接口是规范
public class 类名 implements 接口名{//implements表明了1一个类在实现接口

}
```
3. 不能被实例化，可以通过实现类多态实例化
```java
接口名 x=new 接口实现类构造方法();//接口多态
//接口和实现类之间不是继承关系
```

4. 接口的实现类

5. 多态：
- 接口多态(最常用)
- 抽象类多态(常用)
- 具体类多态（基本不用）

6. 接口成员：
- 成员变量：
  - 只能是常量
  - 默认修饰符为public static final
  - 建议手动给出默认修饰符
- 没有构造方法，不能直接创建对象
- 成员方法：
  - 只能是抽象方法，默认修饰符public，手动写出修饰符更好

那些抽象方法要放在抽象类中：
父类的所有子类共有功能

那些抽象方法要放在接口中
和父类无关的额外的行为

7. 接口和接口的关系：
   - 接口可以多继承
```java
public class InterImpl implements Inter1,Inter2{

}
```
8. 接口和接口可以单继承和多继承
9. 抽象方法没有方法体，所以直接继承两个相同方法名的方法不用管

抽象类和接口的区别：
抽象类：变量，常量；有构造方法；抽象方法，非抽象方法
接口：常量；无构造方法；抽象方法

关系区别：
类和类：继承关系，单继承
类和接口：实现关系，单实现，多实现
接口和接口：继承关系，单继承，多继承

设计理念：
抽象类：抽取共性功能
抽象类是对事物的抽象，接口是对行为的抽象

## 内部类

- 类名作为形参和返回值
1. 基本数据类型
   byte， short, int, long, float, double, char, boolean 
2. 引用数据类型
   类：API, 自定义
   数组
   接口


方法声明
```java
修饰符 返回值 方法名(数据类型 变量名){//形参是数据类型
    XXX
}
```

类名作为形参和返回值
- 类名作为形参
  方法的形参是类名，其实需要的是该类的对象3
- 类名作为返回值

抽象类作为形参和返回值：
接受或者返回抽象类的子类

接口作为形参和返回值：
接受或返回实现类或其子类的对象

内部类
在一个类中定义一个类

- 成员内部类
```java
    Outer.Inner oi=new Outer().new Inner();//获取内部类对象
    外部类名.内部类名 变量名 = new 外部类().new 内部类();
```
- 局部内部类
  只能在方法内，局部内部类定义下面创建类对象，在使用类方法
  局部内部类访问局部变量，该变量必须是一个常量，防止被垃圾回收器回收，如果是常量，会放在常量池，不会被释放
- 匿名内部类(创建对象)
  
匿名内部类（重点->转化为$\lambda$表达式）
- 局部内部类的一种形式
- 是一个==对象==
```java
类名或者接口名 变量=new 类名或者接口名(){//本质是一个继承了该类或者实现了该接口的匿名对象
    重写方法
};
```
