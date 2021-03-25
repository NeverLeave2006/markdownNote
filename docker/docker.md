# docker
运维部署相关的技术
## 初始docker
- 开发环境：开发人员代码打war包
- 测试环境：测试人员代码给运维
- 生产环境：运维，用户

把容器打包，发给不同人员
规避软件跨环境迁移问题

Docker是一个开源的应用容器引擎
2013初，基于Go语言
让开发者打包应用到一个容器中，然后发布到流行的Linux机器上
使用沙箱机制，相互隔离
容器性能开销低
17.3之后分为CE,EE两种版本

> Docker是一种容器技战术，规避跨环境迁移问题
### 安装Docker
CentOS7版本

### Docker架构
Clients-Hosts-Registeries
镜像创建容器
仓库
客户端

### 配置镜像加速器
docker hub
国内镜像加速器
阿里云镜像加速器

```shell
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://qf3nhp3e.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
```

## Docker命令
### 服务相关命令
- 开启Docker
```shell
systemctl start docker
```
- 关闭Docker
```
systemctl stop docker
```
- 重启Docker
```
systemctl restart docker
```
- 查看状态
```
systemctl status docker
```
- 开机启动
```shell
systemctl enable docker
```

### 镜像相关命令
- 查看本地镜像
```shell
docker images
```

- 搜索镜像
```shell
docker search [镜像]
```

- 下载镜像
```shell
docker pull [镜像]
```

- 拉取镜像
```shell
docker pull [镜像:版本号]
```

- 删除镜像
```shell
docker rmi [镜像id或镜像名称]
```

- 删除全部镜像
```shell
docker rmi docker images -p
```

### docker容器相关命令
- 创建容器
```shell
# -i 一直运行
# -t 分配终端
# -d 后台守护进程运行
# -it
# -id
# --name=c1 容器取名
# 镜像名称
# 初始化命令 
docker run -it --name=c1 centos:7 /bin/bash

# 推出终端
exit
```

- 查看容器
```shell
# 查看正在运行的容器
docker ps
# 查看全部容器
docker ps -a
```

- 进入容器
```shell
# -i 一直运行
# -t 分配终端
# -d 后台守护进程运行
# -it
# -id
# --name=c1 容器取名
# 镜像名称
# 初始化命令 
docker exec [容器id或名称]
# 这样退出不会关闭
```

- 启动容器
```shell
docker start [容器id或名称]
```

- 停止容器
```shell
docker stop [容器id或名称]
```

- 删除容器
```shell
# 开启的容器不能被删除
docker rm [容器id或名称]
```

- 查看容器信息
```shell
docker inspect [容器id或名称]
```

### 容器的是数据卷
数据卷：理解为一个文件活着目录

- 删除容器后，容器里面的数据还在吗？
  - 不在了

- 可以和外部直接交互吗？
  - 不可以

- 数据卷
  - 宿主机中的目录活着文件
  - 映射容器的目录

#### 配置数据卷
```shell
# 创建活着启动容器时使用-v参数设置数据卷
docker run ... -v 宿主机目录(文件):容器内目录(文件)
# 目录必须是绝对路径
# 目录不存在，会自动创建
# 可以使用多个 -v命令创建多个数据卷
# 可以多个容器挂同一个数据卷实现数据交换
```

#### 数据卷容器
- 多容器进行数据交换
1. 多容器挂同一个数据卷
2. 数据卷容器
```shell
# 1.创建启动c3数据卷容器，使用-v参数 设置数据卷
docker run -it --name=c3 -v /volume centos:7 /bin/bash
# 2.创建启动从c1 c2 容器， 使用 --volumn-from 参数设置数据卷
docker run -it --name=c1 --volumns-from c3 centos:7 /bin/bash
docker run -it --name=c2 --volumns-from c3 centos:7 /bin/bash
```

## Docker应用部署

### 部署mysql
1. 搜索mysql镜像
2. 拉取mysql镜像
3. 创建容器
4. 操作容器中的mysql

需求：外部访问MySQL容器
容器和宿主机端口映射


```shell
docker search mysql
docker pull mysql 5.6
docker run -id -p 3307:3306 --name=c_mysql -v $PWD/conf:/etc/mysql/conf.d -v $PWD/logs:/logs -v $PWD/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 mysql:5.6
```

### tomcat部署
部署tomcat容器，并通过外部访问

1. 搜索tomcat镜像
2. 拉取tomcat镜像
3. 创建容器
4. 操作容器中的tomcat
```shell
docker search tomcat
docker pull  tomcat
mkdir ~/tomcat
cd ~/tomcat
docker run -id --name-c_tomcat -p 8080:8080 -v $PWD:/usr/local/tomcat/webapps tomcat
```

### 部署nginx
部署nginx容器，并通过外部访问

1. 搜索nginx镜像
2. 拉取nginx镜像
3. 创建容器
4. 操作容器中的nginx

```shell
docker search nginx
docker pull nginx
#在/root目录下创建nginx目录用于存储nginx信息
mkdir ~/nginx
cd ~/nginx
mkdir conf
cd conf
# 在~/nginx/conf下创建nginx.conf文件，粘贴并访问
vim nginx.conf

#nginx.conf

docker run -id --name=c_nginx -p 80:80 -v $PWD/conf/nginx.conf:/etc/nginx/nginx.conf -v $PWD/logs:/var/log/nginx -v $PWD/html:/usr/share/nginx/html nginx
```

### redis部署

部署redis容器，并通过外部访问

1. 搜索redis镜像
2. 拉取redis镜像
3. 创建容器
4. 操作容器中的redis

```shell
docker search redis
docker pull redis:5.0
docker eun -id --name=c_redis -p 6379:6379 redis:5.0
# 使用外部机器访问
./redis-cli.exe -h [ip] -p 6379
```

## 备份与迁移

## Dockerfile
用于制作镜像

#### 镜像原理
原理：
1. 本质：分层文件系统
   镜像由特殊的文件系统叠加而成，使用宿主机的bootfs,复用
    rootfs, 基础镜像 base image
    往上可以叠加其他镜像文件
    统一文件系统(Union File System)
    镜像可以叠加
    启动容器时，可以在最顶层加载一个读写系统作为容器
2. 系统镜像和iso文件大小对比
   复用
3. 软件镜像和安装包大小对比
   基础镜像+上层

### Docker镜像制作
1. 容器转为镜像
```shell
#容器转镜像
docker commit [容器id] [镜像名称:版本号]
#镜像转压缩文件
docker save -o [压缩文件名称] [镜像名称:版本号]
#压缩文件还原镜像
docker load -i [压缩文件名称]
```
2. dockerfile
- dockerfile是一个文本文件
- 包含了一条条指令
- 每一个指令构建一层，基于基础镜像，最终构建出一个新的镜像
- 对于开发人员： 可以为开发人员提供一个完全一致的开发环境
- 对于测试人员： 可以直接拿开发时所构建的镜像或通过Dockerfile文件构建一个新的镜像开始工作了
- 对于运维人员: 在部署时，可以实现应用的无缝移植

关键字：

| 关键字      | 作用                     | 备注                                                         |
| ----------- | ------------------------ | ------------------------------------------------------------ |
| FROM        | 指定父镜像               | 指定dockerfile基于哪个image构建                              |
| MAINTAINER  | 作者信息                 | 用来标明这个dockerfile谁写的                                 |
| LABEL       | 标签                     | 用来标明dockerfile的标签 可以使用Label代替Maintainer 最终都是在docker image基本信息中可以查看 |
| RUN         | 执行命令                 | 执行一段命令 默认是/bin/sh 格式: RUN command 或者 RUN ["command" , "param1","param2"] |
| CMD         | 容器启动命令             | 提供启动容器时候的默认命令 和ENTRYPOINT配合使用.格式 CMD command param1 param2 或者 CMD ["command" , "param1","param2"] |
| ENTRYPOINT  | 入口                     | 一般在制作一些执行就关闭的容器中会使用                       |
| COPY        | 复制文件                 | build的时候复制文件到image中                                 |
| ADD         | 添加文件                 | build的时候添加文件到image中 不仅仅局限于当前build上下文 可以来源于远程服务 |
| ENV         | 环境变量                 | 指定build时候的环境变量 可以在启动的容器的时候 通过-e覆盖 格式ENV name=value |
| ARG         | 构建参数                 | 构建参数 只在构建的时候使用的参数 如果有ENV 那么ENV的相同名字的值始终覆盖arg的参数 |
| VOLUME      | 定义外部可以挂载的数据卷 | 指定build的image那些目录可以启动的时候挂载到文件系统中 启动容器的时候使用 -v 绑定 格式 VOLUME ["目录"] |
| EXPOSE      | 暴露端口                 | 定义容器运行的时候监听的端口 启动容器的使用-p来绑定暴露端口 格式: EXPOSE 8080 或者 EXPOSE 8080/udp |
| WORKDIR     | 工作目录                 | 指定容器内部的工作目录 如果没有创建则自动创建 如果指定/ 使用的是绝对地址 如果不是/开头那么是在上一条workdir的路径的相对路径 |
| USER        | 指定执行用户             | 指定build或者启动的时候 用户 在RUN CMD ENTRYPONT执行的时候的用户 |
| HEALTHCHECK | 健康检查                 | 指定监测当前容器的健康监测的命令 基本上没用 因为很多时候 应用本身有健康监测机制 |
| ONBUILD     | 触发器                   | 当存在ONBUILD关键字的镜像作为基础镜像的时候 当执行FROM完成之后 会执行 ONBUILD的命令 但是不影响当前镜像 用处也不怎么大 |
| STOPSIGNAL  | 发送信号量到宿主机       | 该STOPSIGNAL指令设置将发送到容器的系统调用信号以退出。       |
| SHELL       | 指定执行脚本的shell      | 指定RUN CMD ENTRYPOINT 执行命令的时候 使用的shell            |

#### dockerfile案例 自定义centos
要求：
1. 默认登录路径为/usr
2. 可以使用vim

步骤：
1. 定义父镜像：
```dockerfile
FROM centos:7
```

2. 定义作者信息：
```dockerfile
MAINTAINER snowlands <snowlands@126.cn>
```



3. 执行安卓vim命令：
```dockerfile
RUN yum install -y vim
```

4. 定义默认的工作目录：
```dockerfile
WORKDIR /usr
```

5. 定义容器启动时执行的命令：
```dockerfile
CMD /bin/bash
```

最后的得到的dockerfile文件
```dockerfile
FROM centos:7
MAINTAINER snowlands <snowlands@126.com>
RUN yum install -y vim
WORKDIR /usr
CMD /bin/bash
```

构建：
```shell
docker build -f [dockerfile文件] -t[镜像名称:版本号] .
# 最后一个点代表寻址路径
```

> dockerfile 每一行构建一层文件

#### docker案例2发布springboot项目
定义dockerfile发布springboot项目
helloworld项目springboot

1. springboot项目打包
2. 上传到对应目录
3. 编辑dockerfile

实现步骤：

1. 定义父镜像
```dockerfile
FROM java:8
```

2. 定义作者信息
```dockerfile
MAINTAINER snowlands <snowlands@126.com>
```

3. 将jar包添加到容器
```dockerfile
ADD springboot.jar app jar
```

4. 定义容器启动执行命令
```dockerfile
CMD java -jar app.jar
```

5. 通过dockerfile构建镜像
```shell
docker build -f [dockerfile文件路径] -t [镜像名称:版本]
```

## 服务编排

- 微服务架构中一般包含若干个服务，每个服务有多个实例，如果每个微服务都要手工维护，工作量会很大
- build或pull 很多 image
- 创建多个container
- 管理(启动，停止，删除)container

服务编排就是按照一定规则批量管理容器

### docker compose 概述

Docker Compose是一个编排多容器分布式部署的工具，提供命令集管理容器的完整开发周期
1. 利用Dockerfile定义运行环境镜像
2. 使用docker-compose.yml定义组成应用的各服务
3. 运行docker-compose up 启动服务

- 安装Docker Compose
```shell
#linux 安装方法
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#授予可执行权限
sudo chmod +x /usr/local/bin/docker-compose

#查看版本信息
docker-compose -version
```

- 卸载Docker Compose
```shell
#移除文件目录即可
rm /usr/local/bin/docker-compose
```

使用步骤
- 使用 Dockerfile 定义应用程序的环境。
- 使用 docker-compose.yml 定义构成应用程序的服务，这样它们可以在隔离环境中一起运行。
- 最后，执行 docker-compose up 命令来启动并运行整个应用程序。

docker容器日志查看：
```shell
docker logs [OPTIONS] CONTAINER
#  Options:
#        --details        显示更多的信息
#    -f, --follow         跟踪实时日志
#        --since string   显示自某个timestamp之后的日志，或相对时间，如42m（即42分钟）
#        --tail string    从日志末尾显示多少行日志， 默认是all
#    -t, --timestamps     显示时间戳
#        --until string   显示自某个timestamp之前的日志，或相对时间，如42m（即42分钟）
```