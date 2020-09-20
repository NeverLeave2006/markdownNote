# javaWeb
网络通信的三要素： 
- ip: 电子设备在网络中的唯一标识
- 端口 8080 3306: 应用程序在计算机中的唯一标识 
- 客户端和 服务器端 数据报文传输时是需要  “协议”的 
  - 基础协议：
    - tcp: 安全协议，三次握手，速度慢
    - udp：不安全协议，速度快

例如：MySQL是一个软件，用于存储数据
MySQL服务器指装了MySQL的服务器

## Web回顾
- 软件架构 C/S,B/S
  - c/s：客户/服务器端
  - b/s:浏览器/服务器端
    - 浏览器：
    - 服务器：
      - 静态：不同用户看到的结果一样 html,css,javascript,由浏览器解析展示
      - 动态：每个用户访问相同资源后得到的结构不一样servlet,jsp,php,asp，由服务器解析，浏览器展示
- 资源分类，静态，动态
- 网络通信三要素 IP，端口，传输协议
  
# web服务器软件
    - 服务器: 安装了服务器软件的计算机
    - 服务器软件：接受用户请求，处理请求，做出响应
    - web服务器软件： 接受用户的请求，处理请求，做出相应
      - 在web服务器中我们可以部署web项目，让用户通过浏览器来访问这些项目
      - web容器


    - 常见的java相关的web服务器软件:
      - weblogic: oracle公司, 大型JavaEE服务器，支持所有的JavaEE规范，收费的
      - WebSphere: IBM公司, 大型JavaEE服务器，支持所有的JavaEE规范，收费的
      - JBOSS: JBOSS公司的, 大型JavaEE服务器，支持所有的JavaEE规范，收费的
      - Tomcat: Apache基金组织，中小型JavaEE服务器， 仅仅支持少量JavaEE规范的JSP/servlet。 开源的，免费的

tomcat的servlet给我们提供的都是接口和抽象类，我们的代码要想被执行要依靠tomcat去调用，我们的项目没有main方法
