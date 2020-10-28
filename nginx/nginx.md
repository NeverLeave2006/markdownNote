# nginx
## nginx基本概念
1. nginx是什么，做什么事情
nginx简介
高性能的http和反向代理的web服务器，同时提供多种服务。内存小，并发强。
专门为性能开发，单线程50000并发，热部署
2. 反向代理
正向代理: 在客户端配置代理服务器，通过代理服务器进行访问
反向代理: 客户端对代理无感知，反向代理服务器和目标服务器对外就是一个服务器,暴露代理服务器，隐藏真实服务器
3. 负载均衡
设置多个服务器,将前端请求负载分发到多个服务器
4. 动静分离
加快网站解析速度，将动态页面和静态业务交给不同服务器来解析，加快解析速度。降低原来单个服务器压力。

## nginx 安装，常用命令和配置文件
1. 在linux系统中安装nginx
怎么简单怎么来,略

```shell
# firewall 查看开放的端口号
firewall-cmd --list-all 

# 设置开放的端口号
firewall-cmd --add-service=http -permanent
sudo firewall-cmd -add-port=80/tcp --permanent
```
2. nginx常用命令
```shell
# 使用目录时需要进入nginx目录/usr/local/nginx/sbin, 除非的通过源安装的

# 查看nginx版本号
nginx -v

# 停止nginx
nginx -s stop

# 启动nginx
nginx 

# 重新加载
nginx -s reload

```
3. nginx配置文件
位置/usr/local/nginx/conf/nginx.conf
组成
```conf
; 由三部分组成
; 全局块, 影响服务器整体运行的配置指令
work_processes # 值越大，可以支持的并发值也就越多
; events块 影响nginx服务器于用户网络的连接
work_connections 1024 #支持的最大连接数为1024
; http块 配置最频繁的部分
# 包含http全局块和http server块
#server块分为全局server和location
server{
    listen 80; # 目前监听80端口
    server_name localhost; 主机名称

    location / {
        root html;
        index index.html index.htm;
    }
}

```

## nginx配置实例1-反向代理
### 实例1: 反向代理一个tomcat
1. 准备tomcat，略
2. 具体配置
确认hosts文件 
ip 域名
3. nginx.conf
```conf
server{
    listen 10080;
    server_name 127.0.0.1
    location / {
        root html;
        proxy_pass http://127.0.0.1:18080;
        index index.html index.htm;
    }
}
```

## nginx配置实例2-负载均衡

```conf
http{
    upstream myserver{
        ip_hash;
        server 192.168.0.101 weight=1;
        server 192.168.0.102 weight=1;
    }

    server{
        location /{
            ...
            proxy_pass http://myserver;
            proxy_connect_timeout 10;
        }
    }
}
```

## nginx配置实例3-动静分离
```conf
# 对于静态资源
location /www/{
    root /data/;
    index index.html index.htm;
}

location /image/ {
    root /data/;
    autoindex on; 自动列出文件夹内容
}
```
## nginx配置高可用集群
安装keepalived
主备模式:

## nginx原理


## nginx 反向代理数据库
```conf
stream { 
    upstream mysql { 
        zone myapp1 64k; 
        server localhost:13306 weight=1 max_fails=3 fail_timeout=30s; 
        #server 192.168.1.221:3306 weight=1 max_fails=2 fail_timeout=30s;    
    } 
    server { 
            listen 18888; 
            proxy_connect_timeout 1s; 
            proxy_timeout 3s; 
            proxy_pass mysql; 
    } 
}
```