# 1.设置IP地址

在不修改路由器的情况下，你可以在你的设备上设置静态IP地址。这样，即使路由器重启，你的设备的IP地址也不会改变。但是，你需要确保你选择的静态IP地址不在路由器的DHCP范围内，否则可能会导致IP地址冲突。

以下是在Ubuntu上设置静态IP地址的步骤：

1. 打开网络接口配置文件。在终端中输入以下命令：

```shell
sudo nano /etc/netplan/01-netcfg.yaml
```

2. 在打开的文件中，找到你的网络接口（例如，`eth0`或`ens160`），并添加以下内容：

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    wlx60ee5c1ef39f:
      dhcp4: no
      addresses: [192.168.1.103/24]
      gateway4: 192.168.1.1
      nameservers:
        addresses: [8.8.8.8,8.8.4.4,114.114.114.114]
```

在这个例子中，我们设置了IP地址为`192.168.1.100`，子网掩码为`255.255.255.0`（`/24`），网关为`192.168.1.1`，并使用了Google的公共DNS服务器`8.8.8.8`和`8.8.4.4`。

3. 保存并关闭文件。

4. 应用新的网络配置。在终端中输入以下命令：

```shell
sudo netplan apply
```

5. 验证新的IP地址。在终端中输入以下命令：

```shell
ip addr show ens160
```

请将`ens160`替换为你的网络接口名称。

注意：在进行这些操作之前，你需要确保你选择的IP地址是可用的，并且不会与网络中的其他设备冲突。

编辑/etc/hosts文件

```
192.168.0.103 master
192.168.0.105 worker1
```

# 同步时间

```shell
ntpdate time1.aliyun.com
```

# 内核网桥过滤

```shell
sudo cat  << EOF | tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF
overlay
br_netfiler

```

启动

```shell
sudo modprobe overlay
sudo modprobe br_netfilter
```

检查挂在

```shell
lsmod |egrep "overlay"
lsmod |egrep "br_netfilter"
```

# 安装Containerd容器

