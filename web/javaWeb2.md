# JSP
## 指令
* 用于配置jsp页面，导入配置文件
* 格式:
```jsp
<%@ 指令名称 属性1=值1 属性2=值2 属性3=值3%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
```
* 分类：
   1. page:    配置jsp页面
   2. include: 页面包含的，导页面资源
   3. taglib:  导入资源

1. page指令:
   常见属性：
   - contentType:等同于response.setContentType();
     - 设置当前页面mime类型和字符集
     - 设置当前jsp页面编码（高级工具生效）可以用pageEncoding代替
   - language，只能写"java"
   - buffer: 缓冲区大小
   - import: 导包
   - errorPage: 当前页面发生错误后跳转到错误页面
   - isErrorPage: 标识当前页面是错误页面
     - true: 可以使用exception内置对象
     - false: 不可以使用默认对象
  导入标签库
2. 导入jstl jar包
```jsp
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
//1. prefix: 前缀，可以自定义
```
include
- 引入其他页面
```jsp
<%@include file="top.jsp"%>
```
## 注释
1. html注释
```html
<!-- 只对静态html有效-->
```
2. jsp注释(推荐)
```jsp
<%--可以注释jsp内容,不会在前端浏览器显示--%>
```
## 内置对象(九个)
|内置对象|类型|作用|
|--|--|--|
|pageContext     |PageContext          |当前页面共享数据|
|request         |HttpServletRequest   |一次请求访问多个资源(转发)|
|session         |HttpSessin           |一次会话多个请求间|
|application     |ServletContext       |所有用户间共享数据|
|response        |HttpServletResponse  |响应对象|
|page            |Object               |当前页面(Servlet)对象|
|out             |JspWriter            |输出对象，数据输出到页面上|
|config          |ServletConfig        |Servlet配置对象|
|exception       |Throwable            |异常对象|

## MVC开发模式
历史：
1. 早期Servlet，程序，response输出标签
2. 后来有了jsp,简化了servlet的开发，难于维护，难于分工合作
3. 再后来，web开发借鉴了mvc,来使得程序的设计更加的合理性
   1. jsp只干一件事，有这个能力，但是不干了，不允许在jsp中写java代码了只能用<%= %>,注释，page指令，taglib,include
   2. M, Model模型
        - 完成具体的业务操作，如查询数据库，封装对象
   3. V, View视图
        - 展示数据
   4. C, Controller控制器
- 获取用户输入
- 调用模型
- 将数据交给视图进行展示
- 优点：
  - 耦合性低，方便维护，利于分工协作
  - 重用性高
- 缺点：
  - 项目变得复杂，对开发人员要求高

## EL表达式
1. 概念：Expression Language 表达式语言
2. 作用：替换和简化JSP页面中java代码的编写
3. 语法：${表达式}
4. 注意：JSP默认支持EL表达式
5. 忽略EL表达式
   1. 设置jsp指令中isIgnred="true" 忽略当前jsp中的所有el表达式
   2. \${表达式}：忽略当前这个el表达式
使用方式
- 做运算
  - 算术运算符：+ - * /(div) %(mod)
  - 比较运算符：> < >= <= == !=
  - 逻辑运算符：&&(and) ||(or) !(not)
  - 空运算符： empty
    - 判断字符串，集合，数字对象长度是否为0活着为null
```jsp
${empty list} 
<!-- 返回Boolean -->
${not empty list}
<!-- 返回Boolean -->
```
- 获取值
  1. el表达式只能从域对象里面获取值
  2. 语法
     1. ${域名称.键名}：从指定的域中获取值
        * 域名称:

          |el对象|内置对象|
          |--|--|
          |pageScope|pageContext|
          |requestScope|request|
          |sessionScope|session|
          |applicationScope|application(ServletContext)|
      1. ${键名}依次从最小的域开始找是否有键对应的值，知道找到对应的为止
- 隐式对象
    1. EL里面有11个隐式对象

## JSTL
1. 概念：Java Server Pages Tag Library(JSP标准标签库)
   是由apache组织提供的开源免费标签库

2. 作用: 简化和替换jsp上面的java代码
- 是一个框架
- 导入jar包
3. 使用步骤：
   - 导入jstl相关jar包
   - 引入标签库: taglib指令: 
```jsp
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
```
1. 常用的jstl标签
   1. if
   属性：
    test 必须属性，接受boolean表达式
    如果表达式为true 则显示为if标签内容，如果为false，则不显示标签内容
   1. choose-when 类似switch-case
   2. foreach
```jsp
<c:forEach begin="1" end="10" var="i" step="2" varStatus="s">
${i}<br/>
${s.index}
${s.count}
</c:forEach>
```
items属性用于遍历list集合遍历
```jsp
  var为属性中临时遍历名
  varStatus:forEach提供的一个监控状态底层对象，内部有两个getter方法：
  getIndex();//s.index,list下标索引
  getCount();//s.count，当前循环次数，默认1开始
  //玩法2：
  begin:开始位置
  end:结束位置
  var:for中的变量i
  step:每次循环递增多少
```