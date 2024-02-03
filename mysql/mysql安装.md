在 Linux 系统中，你可以通过以下步骤使用 tar 包安装 MySQL：

1. **下载 MySQL**：首先，你需要从 MySQL 的官方网站下载 MySQL 的 tar 包。你可以选择适合你的系统和版本的 tar 包。

2. **解压 tar 包**：下载完成后，你可以使用 `tar` 命令来解压 tar 包。例如：

   ```bash
   tar -xvf mysql-8.0.23-linux-glibc2.12-x86_64.tar.xz
   ```

3. **创建 MySQL 用户和组**：为了安全，你应该为 MySQL 创建一个专门的用户和组。例如：

   ```bash
   groupadd mysql
   useradd -r -g mysql -s /bin/false mysql
   ```

4. **初始化数据库**：然后，你需要初始化 MySQL 的数据库。你可以使用 MySQL 的 `mysqld` 命令来完成这个操作。例如：

   ```bash
   cd mysql-8.0.23-linux-glibc2.12-x86_64
   bin/mysqld --initialize --user=mysql
   ```

你遇到的这个问题是因为 MySQL 需要 `libaio` 库，但是你的系统中没有安装这个库。

你可以使用以下命令来安装 `libaio`：

如果你的系统是基于 Debian 的（如 Ubuntu），你可以使用 `apt-get`：

```bash
sudo apt-get update
sudo apt-get install libaio1
```

如果你的系统是基于 Red Hat 的（如 CentOS），你可以使用 `yum`：

```bash
sudo yum install libaio
```

安装完成后，你应该就可以正常使用 MySQL 了。


5. **配置 MySQL**：你可能需要修改 MySQL 的配置文件，以便根据你的需求配置 MySQL。你可以在 `my.cnf` 文件中修改这些配置。

6. **启动 MySQL**：最后，你可以使用 `mysqld_safe` 命令来启动 MySQL。例如：

   ```bash
   bin/mysqld_safe --user=mysql &
   ```

你遇到的这个问题是因为 MySQL 需要 `libncurses` 库，但是你的系统中没有安装这个库。

你可以使用以下命令来安装 `libncurses`：

如果你的系统是基于 Debian 的（如 Ubuntu 或 Kali Linux），你可以使用 `apt-get`：

```bash
sudo apt-get update
sudo apt-get install libncurses5-dev libncursesw5-dev
```

如果你的系统是基于 Red Hat 的（如 CentOS），你可以使用 `yum`：

```bash
sudo yum install ncurses-devel
```

安装完成后，你应该就可以正常使用 MySQL 了。

以上是使用 tar 包安装 MySQL 的基本步骤，实际操作中可能需要根据你的系统和需求进行一些调整。你可以参考 MySQL 的官方文档来获取更多的信息。

7. 修改mysql密码

    在 MySQL 中，你可以使用 `ALTER USER` 语句来修改用户的密码。以下是具体的步骤：

    1. **登录 MySQL**：首先，你需要使用 `mysql` 命令来登录 MySQL。例如：

    ```bash
    mysql -u root -p
    ```

    这个命令会提示你输入 root 用户的密码。

    2. **修改密码**：登录成功后，你可以使用 `ALTER USER` 语句来修改密码。例如，如果你想将 root 用户的密码修改为 `new_password`，你可以执行以下命令：

    ```sql
    ALTER USER 'root'@'localhost' IDENTIFIED BY 'new_password';
    ```

    请注意，你应该将 `new_password` 替换为你想要设置的新密码。

    3. **退出 MySQL**：最后，你可以使用 `exit` 命令来退出 MySQL。

    以上是在 MySQL 中修改用户密码的基本步骤，实际操作中可能需要根据你的系统和需求进行一些调整。

    4. 允许远程访问

    在 MySQL 8 中，你可以通过以下步骤来使 root 账户支持远程访问：

    
    - **修改 root 用户的主机**：登录成功后，你可以使用 `ALTER USER` 语句来修改 root 用户的主机。例如，如果你想让 root 用户可以从任何主机登录，你可以执行以下命令：

    ```sql
    ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
    CREATE USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'password';
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
    ```

    请注意，你应该将 `password` 替换为 root 用户的密码。

    - **刷新权限**：然后，你需要使用 `FLUSH PRIVILEGES` 命令来刷新权限：

    ```sql
    FLUSH PRIVILEGES;
    ```

    - **修改配置文件**：你可能还需要修改 MySQL 的配置文件（通常是 `my.cnf` 或 `mysqld.cnf`），将 `bind-address` 设置为 `0.0.0.0`。例如：

    ```ini
    [mysqld]
    bind-address = 0.0.0.0
    ```

    - **重启 MySQL**：最后，你需要重启 MySQL 来使这些更改生效。





