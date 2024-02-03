# 设置全局git加速:

```shell
git config --global url."https://gitclone.com/".insteadOf https://

git clone https://github.com/espnet/espnet.git
```


上面的命令会将镜像代理的前缀写入 ~/.gitconfig

然后直接使用 git clone github地址 就可以加速了，不需要每次再设置前缀

只有当前用户可用


如果是多用户的系统，请使用下面的命令

```shell
git config --system url."https://gitclone.com/".insteadOf https://

git clone https://github.com/espnet/espnet.git
```

恢复：

如果你想要取消之前设置的 Git 加速，你可以使用 `git config --unset` 命令来移除之前设置的 URL 替换规则。

如果你之前是设置的全局配置，你可以使用以下命令来移除：

```bash
git config --global --unset url."https://gitclone.com/".insteadOf
```

如果你之前是设置的系统配置，你可以使用以下命令来移除：

```bash
git config --system --unset url."https://gitclone.com/".insteadOf
```

这些命令会移除之前设置的 URL 替换规则，恢复 Git 到默认的行为。之后，当你使用 `git clone` 命令时，Git 将直接从原始的 URL 克隆仓库，而不会再使用 `gitclone.com` 的镜像服务。