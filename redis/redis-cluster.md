# redis集群配置
每个redis进程配置
```conf
bind 0.0.0.0
port 7001 #可以是其他端口
daemonize yes
appendonly yes
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
```

开启每个进程后

集群配置，举例，便于查看，其实没有换行：

```shell
redis-cli --cluster create 
127.0.0.1:7001 
127.0.0.1:7002 
127.0.0.1:7003 
127.0.0.1:7004 
127.0.0.1:7005 
127.0.0.1:7006 
--cluster-replicas 1
```

集群使用

```shel
redis-cli -p 7001 -c
```



