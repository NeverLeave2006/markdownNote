# 微服务网关概述

不同微服务会有不同的网络地址，外部客户端可能需要调用多个服务的接口才能完成一个业务需求，如果让客户端直接与各个微服务通信，会有以下问题:
- 客户端会有多次请求不同的微服务，增加了客户端的复杂性
- 存在跨域请求，在一定场景下处理相对复杂
- 认证复杂，每个服务需要独立认证
- 难以重构，随着项目的迭代，可能需要重新划分微服务。 例如: 可能将多个服务合并成一个或者将一个服务拆分为多个，如果客户端直接与微服务通信，那么重构将会很难实现

网关：转发，授权，限流

- 安全: 只有网关系统对外网进行暴露， 微服务可以隐藏在内网， 提供防火墙保护
- 易于监控: 可以在网关手机监控数据并将其推送到外部系统进行分析
- 易于统一认证授权，可以在网关上进行认证，然后再将请求转发到后端的微服务，而无需在每个微服务中进行认证
- 减少了客户端与各个微服务之间的交互次数

总结：微服务网关就是一个系统，通过暴露该微服务网关系统，方便我们进行相关的鉴权，安全控制，日志统一处理，易于监控的相关功能

实现网关的技术：
- nginx
- zuul
- spring-cloud-gateway(wei比zuul性能好)

# 微服务网关微服务搭建

# 加密算法

## 可逆加密算法和不可逆加密算法

- 可逆加密算法
  - 对称加密：收发双方使用同样的密钥
  - 非对称加密：收发双方使用不同密钥
    - 公钥：客户端
    - 私钥：服务器端
- 不可逆加密算法
  一旦加密不可以直接逆向解密
  一般用于保存不可解迷的用户关键信息

  Base64是编码方式，不是加密方式，用于传输一些较长的标识性的信息


  微服务鉴权：在网关中看用户是否有使用某项微服务的权利


# JWT
JSON Web Token, 在服务器端和web端进行安全可靠的web信息传递
JWT本质是一个字符串，内部由头部，载荷和签名组成

## jwt入门
```java
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtBuilder;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import java.util.Date;

public class JwtTest {
    public static void main(String[] args) {

        //获取系统的当前时间
        long currentTimeMillis = System.currentTimeMillis();
        Date date = new Date(currentTimeMillis);


        //生成jwt令牌
        JwtBuilder jwtBuilder = Jwts.builder()
                .setId("66")//设置jwt编码
                .setSubject("拾取时间的精彩")//设置jwt主题
                .setIssuedAt(new Date())//设置签发日期
                //.setExpiration(date)//设置jwt的过期时间
                .claim("roles","admin")//添加自定义信息，添加信息会使令牌信息变长
                .claim("company","itheima")
                .signWith(SignatureAlgorithm.HS256, "itheima");
        //生成jwt令牌
        String jwtToken = jwtBuilder.compact();
        System.out.println(jwtToken);

        //解析jwt令牌，得到其数据
        Claims claims = Jwts.parser().setSigningKey("itheima").parseClaimsJws(jwtToken).getBody();
        System.out.println(claims);
    }
}

```