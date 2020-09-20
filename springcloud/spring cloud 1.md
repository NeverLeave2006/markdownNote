# Consul入门
下载

https://www.consul.io/downloads.html

启动

```shell
./consul agent -dev
```

控制台

localhost:8500

代码：

1. 搭建Provider和Consumer服务
2. 使用RestTemplate完成远程调用
3. 把provider注册到consul中
4. consumer服务通过Consul中抓取的Provider地址完成远程调用

配置：
```properties
spring.cloud.consul.host=localhost 
spring.cloud.consul.port=8500
spring.cloud.consul.discovery.service-name=${spring.application.name}
#注册ip
spring.cloud.consul.discovery.prefer-ip-address=true
```