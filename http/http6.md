# HTTPS协议概述

- HTTPS可以认为是HTTP+TLS

- TLS是传输层加密协议，它的前身是SSL协议

## HTTPS功能介绍

- 内容加密

非对称密钥交换
对称内容加密

- 身份认证

数字证书

- 数据完整性

## HTTPS使用成本

- 证书费用已经更新维护
- HTTPS降低用户访问速度
- 消耗CPU资源，需要增加大量机器

## HTTPS对性能的影响

- 协议交互所增加的网络RTT

- 加解密相关的计算耗时

- 浏览器计算耗时

- 服务端计算耗时

## HTTPS常见问题

- https加密，是不是需要我们在电脑上安装证书/保存密码？

- https=http+证书+浏览器+跳转+流量转发。。。

- https解决了所以劫持问题吗？ 不能

## 补充：springboot配置https的方法

### 单体(待测试)

要在Spring Boot项目中启用HTTPS，你需要进行以下步骤：

1. 首先，你需要一个SSL证书。你可以购买一个，或者使用Java的`keytool`命令生成一个自签名的证书。

2. 然后，你需要在Spring Boot的配置文件（如`application.properties`或`application.yml`）中配置SSL。

以下是如何使用`keytool`生成自签名证书的命令：

```bash
keytool -genkey -alias selfsigned_localhost_sslserver -keyalg RSA -storetype PKCS12 -keysize 2048 -keystore keystore.p12 -validity 3650
```

这将生成一个名为`keystore.p12`的密钥库文件，你需要在命令提示符中输入一些信息，如密钥库和密钥的密码，以及证书的各种用户信息。

然后，你可以在`application.properties`文件中添加以下配置：

```properties
server.port=8443
server.ssl.key-store-type=PKCS12
server.ssl.key-store=classpath:keystore.p12
server.ssl.key-store-password=yourpassword
server.ssl.key-alias=selfsigned_localhost_sslserver
```

这里，`server.ssl.key-store`指向你的`.p12`文件，`server.ssl.key-store-password`和`server.ssl.key-alias`应该与你在生成密钥库时输入的值相匹配。

现在，你的Spring Boot应用应该已经可以通过HTTPS在端口8443上运行了。

### 网关(待测试)

要在Spring Cloud Alibaba的网关（比如Spring Cloud Gateway）中配置HTTPS，你需要进行以下步骤：

1. 首先，你需要一个SSL证书。你可以购买一个，或者使用Java的`keytool`命令生成一个自签名的证书。

2. 然后，你需要在Spring Cloud Gateway的配置文件（如`application.yml`或`application.properties`）中配置SSL。

以下是如何使用`keytool`生成自签名证书的命令：

```bash
keytool -genkey -alias selfsigned_localhost_sslserver -keyalg RSA -storetype PKCS12 -keysize 2048 -keystore keystore.p12 -validity 3650
```

这将生成一个名为`keystore.p12`的密钥库文件，你需要在命令提示符中输入一些信息，如密钥库和密钥的密码，以及证书的各种用户信息。

然后，你可以在`application.yml`文件中添加以下配置：

```yaml
server:
  port: 8443
  ssl:
    key-store-type: PKCS12
    key-store: classpath:keystore.p12
    key-store-password: yourpassword
    key-alias: selfsigned_localhost_sslserver
```

这里，`server.ssl.key-store`指向你的`.p12`文件，`server.ssl.key-store-password`和`server.ssl.key-alias`应该与你在生成密钥库时输入的值相匹配。

现在，你的Spring Cloud Gateway应该已经可以通过HTTPS在端口8443上运行了。

### nginx(待测试)

要在Nginx中启用HTTPS，你需要进行以下步骤：

1. 首先，你需要一个SSL证书。你可以购买一个，或者使用OpenSSL生成一个自签名的证书。

2. 然后，你需要在Nginx的配置文件中配置SSL。

以下是如何使用OpenSSL生成自签名证书的命令：

```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt
```

这将在`/etc/nginx/ssl/`目录下生成一个名为`nginx.key`的私钥文件和一个名为`nginx.crt`的证书文件。

然后，你可以在Nginx的配置文件（通常位于`/etc/nginx/sites-available/default`）中添加以下配置：

```nginx
server {
    listen 80;
    listen 443 ssl;

    server_name your_domain.com;

    ssl_certificate /etc/nginx/ssl/nginx.crt;
    ssl_certificate_key /etc/nginx/ssl/nginx.key;

    location / {
        proxy_pass http://your_upstream;
    }
}
```

这里，`ssl_certificate`指向你的`.crt`文件，`ssl_certificate_key`指向你的`.key`文件。`your_domain.com`应该替换为你的域名，`http://your_upstream`应该替换为你的上游服务器地址。

现在，你的Nginx服务器应该已经可以通过HTTPS运行了。c/cdcd