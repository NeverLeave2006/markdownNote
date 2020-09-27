1. U盘的挂载，卸载
mount /设备路径 /挂载点(最好是/mnt): 挂载 
umount 挂载点: 卸载挂载的硬盘,不能在挂载路径内执行该命令
sudo fdisk -l:列出所有设备信息
sda sdb
sda1-4: 主分区
sda5-:扩展分区
挂载非mnt命令会覆盖原来命令的内容

2. 压缩包管理
青春版:
    gzip: .gz文件
        gzip * .txt: 压缩所有txt,分别压缩，不保留源文件
        gunzpi *.gz: 还原所有.gz文件，不保留源文件
        不能压缩目录
    bzip2:  .bz2
        bzip2 * .txt: 压缩所有txt,分别压缩，不保留源文件
        bzip2 -k * .txt : 压缩所有txt,分别压缩，保留源文件
        bunzip2 *.gz: 还原所有.gz文件，不保留源文件
        不能压缩目录
尊享版:
    tar:
        参数：
        c: 创建
        x: 释放
        v: 显示提示信息
        f: 指定压缩文件名字

        z: 使用gzip方式压缩文件 .gz
        j: 使用bzip2方式压缩文件 .bz2
        zj不能同时使用

        压缩:
        tar zcvf 生成的压缩包名字 xxx.tar.gz 要压缩的文件/目录
        tar jcvf 生成压缩包的名字 xxx.tar.bz2 要压缩的文件/目录
        解压缩:
        tar jxvf xxx.tar.bz2 :解压xxx.tar.bz2文件
        tar zxvf xxx.tar.gz 解压xxx.tar.gz文件
        -C: 指定目录
        压缩包文件最好指定正确的名称
    rar:
        必须先安装该软件
        参数
        a: 压缩
        x: 解压缩
        示例:
        压缩：
            rar a 生成的压缩文件名字(temp) 压缩文件或者目录
        解压缩：
            rar x 要解压的文件 目标目录
    zip:
        参数:
        压缩：
            zip 压缩包的名字 压缩的文件或者目录
        解压缩:
            unzip 压缩包的名字: 释放到当前目录
            unzip 压缩包的名字 -d 解压目录

    总结: 相同之处
    tar/rar/zip 参数 生成的压缩文件的名字 压缩的文件或者目录 --- 压缩时候的语法
    tar/rar/unzip 参数 压缩包的名字 参数(rar没有参数) 解压缩目录 --- 解压缩语法
3. 进程管理
    who: 查看当前在线用户状况
        用户名 设备终端 登录到系统时间
        设备终端:
        tty1-tty6: 文字界面
        tty7: 图形化终端
        通过ctrl+alt+f1-f7切换
    ps: 查看进程信息
        参数：
            a: 列出所有进程
            u: 更详细信息，包括用户，cpu，内存使用率
            x: 查看没有终端的应用程序
        使用管道重定向 |(管道符号)
        ps aux | grep batch: 查找和batch有关的进程，包含这个命令自己
    kill: 杀死进程
        kill -9 进程号pid: 杀死对于进程
        参数：
        l: 查看进程信号（64个）
        -SIGKILL(9) 杀死进程
    env: 查看当前进程的环境变量
        env | grep PATH: 查看和PATH相关的内容
    > linux下环境变量的格式: KEY=value1:value2:value3:value4
        top: linux的任务管理器，动态
4. 网络管理
    ifconfig: 查看网络信息
        eth0: 当前电脑的网卡
            mac: 硬件地址
            广播地址：网段地址
        lo: 本地换回
    ping: 测试和远程ip能不能通信
        -c 4: 指定ping4条
        -i 5: 间隔多少秒给个回馈
    nslookup: 查看域名对应ip
5. ftp
    用户管理:
        adduser: 添加用户脚本
            adduser 用户名: 添加用户，用户组默认和用户名一样

        useradd: 添加用户命令
            -s: 指定命令解析器 /bin/bash
            -g: 创建用户所属的组, 没有用groupadd创建
            -d: 指定用户家目录
            -m: 如果没有目录就创建一个
        groupadd 用户组名称: 创建用户组
        passwd 用户名: 修改指定用户的密码, 用户名不写默认修改当前用户密码
        sudo passwd: 修改root用户

        deluser 用户名: 删除用户
        userdel -r 用户名: 删除用户，同时删除用户所在家目录

        查看当前系统所有用户的配置文件
        /etc/passwd
    
    ftp服务器搭建: --使用vsftp
    ftp服务器，负责文件上传和下载

    1. 服务器端:
        1. 修改配置文件
        /etc/vsftpd.conf
        anonymous_enable=YES    允许匿名登录
        local_enable=YES        允许本地用户登录
        write_enable=YES        实名用户拥有写权限
        local_umask=022         本地掩码
        anon_upload_enable=YES  匿名用户可以象ftp服务器上传数据
        anno_mkdir_write_enable=YES 匿名用户可以在ftp服务器上面上传数据
        2. 重启服务
        sudo service vsftpd restart
    2. 客户端:
        1. 实名用户登录
        ftp + IP(server)
        输入用户名 密码

        文件的上传和下载
            上传: put file
            下载: get file
        2. 匿名用户登录
        ftp + serverIP
        用户名 snonymous
        密码 直接回车

        不允许匿名用户在任意目录切换

        3. lftp客户端访问ftp服务器, 可以操作目录
            安装: sudo apt-get install lftp
            匿名: 
            lftp ip
            login
            实名：
            lftp 用户名@ip
            输入服务器密码

            lcd: 切换目录
            put:  上传文件
            mput: 同时上传多个文件
            get: 下载文件
            mget: 同时下载多个文件
            mirror: 下载整个目录及其子目录
            mirror -R: 上传整个目录及其子目录
6. nfs: 网络共享服务器
    安装:
        sudo apt-get install nfs-kernel-server
    1. 服务器端
        1. 创建共享目录
            mkdir dir
        2. 修改配置文件 /etc/exports
            共享目录路径 ip网段地址(* 所有人) (访问权限, sync实时更新)
            示例:
            /home/Robin/NfsShare *(rw, sync)  
        3. 重启服务
            sudo service nfs-kernel-server restart
    2. 客户端:
        1. 挂载服务器共享目录
            mount serverIP:sharedir /mnt
            cd /mnt 切换到挂载的共享目录

7. ssh
    1. 服务器端
        sudo apt-get install openssh-server
        查看ssh是否安装：
            sudo aptitude show openssh-server
    2. 客户端
        登陆:
            ssh 用户名@ip:port
            第一次登录需要yes保存rsa
        退出:
            logout

8. scp
    scp  == super copy 超级拷贝
    使用命令前提条件 openssh-server
    使用格式:
        scp -r 目标用户名@目标主机IP地址:/目标文件的绝对路径 /保存到本机的绝对/相对路径
        示例:
        scp -r itcast@192.168.1.100:/home/itcast/QQ_dir ./mytest/300
        拷贝目录需要加参数-r
9. 其他命令
    1. 终端翻页
        shift + PageUp -> 上翻页
        shift + PageDown -> 下翻页
    2. 清屏
        clear
        Ctrl + L

    3. 创建终端
        Ctrl + Alt + T(Ubuntu)
        Ctrl + Shift + T (添加新标签页)

    4. 看手册
        man man: 共九个章节
        1. 可执行程序或者shell命令
        2. 系统调用 内核提供的函数
        3. 库调用(程序库中提供的函数)
        4. 特殊文件
        5. 文件格式和规范
        6. 游戏
        7. 杂项
        8. 系统管理命令
        9. 内核例程

    5. 设置或者查看别名
        查看: alias
        设置：alias pag='ps aus|grep '
10. 关机重启

