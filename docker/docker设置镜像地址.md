NeverLeave2006: 安装docker 并制定镜像保存路径

GitHub Copilot: 在Linux系统中，你可以按照以下步骤安装Docker并指定镜像保存路径：

1. 首先，你需要安装Docker。在终端中运行以下命令：

```bash
sudo apt-get update
sudo apt-get install docker-ce
```

2. 确认Docker已经成功安装，运行：

```bash
docker --version
```

3. Docker的默认镜像存储路径是 `/var/lib/docker`。如果你想改变这个路径，你需要修改Docker的服务文件。首先找到Docker的服务文件，运行：

```bash
systemctl status docker | grep Loaded
```

4. 编辑找到的服务文件，例如：

```bash
sudo vi /lib/systemd/system/docker.service
```

5. 在服务文件中找到 `ExecStart=` 这一行，修改为：

```bash
ExecStart=/usr/bin/dockerd -g /your/docker/images/path -H fd:// --containerd=/run/containerd/containerd.sock
```

其中 `/your/docker/images/path` 是你想要设置的新的Docker镜像存储路径。

6. 保存并退出编辑器。然后重新加载服务文件，重启Docker服务：

```bash
sudo systemctl daemon-reload
sudo systemctl restart docker
```

7. 最后，验证新的镜像存储路径是否设置成功，运行：

```bash
docker info | grep "Docker Root Dir"
```

注意：这些步骤可能会因为你的操作系统和Docker版本的不同而有所不同。如果你使用的是Windows或Mac，Docker的安装和配置可能会有所不同。