# Thymeleaf

模板引擎可以和spring boot整合
开箱即用
可以处理六种模板

- xml
- 有效的xml
- XHTML
- 

入门案例
pom依赖

```xml
<dependencies>
    <!--web起步依赖-->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>

    <!--thymeleaf配置-->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-thymeleaf</artifactId>
    </dependency>
</dependencies>
```

application.yml配置
```yml
spring:
  thymeleaf:
    cache: false

```

写一个指向模板文件的controller
```java

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/demo")
public class DemoController {
    @GetMapping("/test")
    public String test(Model model){
        //写入参数
        model.addAttribute("hello","hello world");
        return "demo";
    }
}

```


在resources文件夹下创建tempplates文件夹
新建模板文件demo.html

```html
<!DOCTYPE html>
<!-- 引入thymeleaf支持 -->
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<p th:text="${hello}"></p>
</body>
</html>
```

# Thymeleaf基本语法

1. th:action

提交路径：
`@{路径}`

```html
<form th:action="@{/test/hello}">
    <input th:type="text" th:name="id"/>
    <button>提交</button>
</form>
```

2. th:each

```java
    List<User> userList=new ArrayList<>();
    userList.add(new User(1,"zs","bj"));
    userList.add(new User(2,"ls","hlj"));
    userList.add(new User(3,"ww","harbin"));
```

```html
    <tr th:each="user,userStat:${userList}">
        <td>
            <span th:text="${userStat.index}"></span>
        </td>
        <td th:text="${user.id}"></td>
        <td th:text="${user.name}"></td>
        <td th:text="${user.address}"></td>
    </tr>
```

3. map取值

```java
Map<String,Object> dataMap=new HashMap<>();
dataMap.put("No","123");
dataMap.put("address","bj");
model.addAttribute("dataMap",dataMap);
```

```html
<div th:each="map,mapStat:${dataMap}">
    <div th:text="${map}"></div>
    key:<span th:text="${mapStat.current.key}"></span><br/>
    value:<span th:text="${mapStat.current.value}"></span><br/>
======================================================
</div>

```

4. 数组遍历

```java
String[] names={"张三","李四","王五"};
model.addAttribute("names",names);
```

```html
<div th:each="nm,nmStat:${names}">
    <span th:text="${nmStat.count}"></span>
    <span th:text="${nm}"></span>
======================================================
</div>
```

5. 日期显示

```java
model.addAttribute("now",new Date());
```

```html
<div>
    <span th:text="${#dates.format(now,'yyyy-MM-dd hh:mm:ss')}"></span>
</div>
```

6. th:if条件

```java
model.addAttribute("age",25);
```


```html
<div>
    <!--花括号里面需要再加一个小括号-->
    <span th:if="${(age>=18)}">终于成年了</span>
</div>
```

7. 定义一个模块

新建一个文件footer.html
```html
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>fragment</title>
</head>
<body>
<div id="C" th:fragment="copy">
    关于我们<hr/>
</div>
</body>
</html>
```


8. 包含

在demo.html中添加
```html
<div id="“w" th:include="footer::copy">
</div>
```