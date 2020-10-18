# 文件和目录操作
 
1. 快捷键
    方向上键，ctrl+p： 历史记录列表向上滚动
    方向下键，ctrl+n： 历史记录列表向下滚动
    ctrl+b：向前移动
    ctrl+f: 向后移动
    ctrl+a: 移动到当前行行首
    ctrl+e: 移动到当前行行尾
    backspace,ctrl+h: 往前删
    delete,ctrl+d: 往后删
    ctrl+u：删除光标前面的

    clear: 清屏
    ls: 列出当前文件
    date：看世界
    history: 用户输入的历史命令
    cd: 跳转路径
    tab键：自动填充命令或者路径，按两次列出所有命令，供我们选择
2. linux目录结构
    1. /根目录:  包含以下目录
    2. /bin：   包含常用命令文件
    3. /boot:   开机启动项文件
    4. /dev:    设备文件，linux下面一切都是文件
    5. /etc：   操作系统所需要的配置文件和子目录
    6. /home：  所有用户的主目录，root除外
    7. /lib:    动态链接库(共享库)
    8. /lost-found: 非法关机后的文件碎片
    9. /media： 挂载外设，自动挂载
    10. /mnt：  挂载外设，手动挂载
    11. /opt:   第三方软件
    12. /proc:  虚拟目录，对内存的映射
    13. /root:  root用户的主目录
    14. /sbin:  s是supervisor管理员使用的命令
    15. /usr：   user software resource用户软件资源目录
    不要随便删除目录，否则影响操作    

3. 用户目录：
    1. 绝对路径： 从根目录开始写 /home/snowlands/aaa
    2. 相对路径:  相对于当前的工作目录 bb
        . -> 当前目录
        .. -> 当前的上一级目录
        - -> 在临近的两个目录之间切换 cd -
    3. snowlands@ubuntu: ~$
        snowlands: 当前登录用户
        @ at 在
        Ubuntu 主机名
        ~：home目录
        $：当前用户是一个普通用户
        #：当前用户是root超级用户
    4. 直接cd 回到家目录
4. 文件和目录操作：
    1. 查看资产：
    tree:  需要先安装
           tree 路径，不写为当前目录 
            白色，普通文件
            蓝色，目录
            绿色，可执行文件
            红色，压缩包
            青色，链接文件
            黄色，设备文件
            灰色，其他文件
    ls: 目录下面的内容
        ls -a 看当前目录下面的全部目录
        前面带点的文件是隐藏文件
        ls -l 查看详细信息
            drwxr-xr-x 1 root root 512 Sep 21 00:54 hello/
            前十个字母：
            第一个：文件类型 d(文件夹)
            第2-4个：文件所有者权限 rwx
            5-7个：同组人所有的权限 r-x
            8-10个：其他人所有的权限 r-x
            文件所有者 root
            文件所有者所在组 root
            文件大小 512
            创建日期 Sep 21 00:54
            文件名 hello/
    2. 切换目录
        cd 路径: 切换路径
        pwd：查看当前路径
    3. 删除空目录
        mkdir -p 创建多层目录
        rmdir 删除空目录
        rm -r 递归删除一个目录
        rm -ri 带提升的一个一个删除
    4. 创建文件
        touch 文件路径: 创建新的文件，如果文件名称已经存在，修改文件时间
        rm 文件名：删除文件
        rm -i 文件名：带提示删除文件
    5. 文件和目录拷贝
        cp 源文件 目标文件：拷贝文件，目标文件不存在，就创建，存在就覆盖
        cp 源目录 目标目录：递归拷贝 -r
    6. 查看文件内容
        cat 文件名：查看文件全文
        more 文件名：按回车键一行一行向下显示，空格键翻页，q键退出
        less 文件名：同上，ctrl+b向前翻页，ctrl+f向后翻页
        head 文件名：查看前几行
        tail 文件名：查看后几行的内容
    7. 补充：
        ls -la: 详细查看所有文件
        cd .： 还是在当前目录
        cd ..: 上一级目录
        cd /home/itcast
        cd ~: 会home目录
        cd: :回home目录
    8. 文件重命名方法
        mv 文件原名，文件新名称
    
    软连接：其实是个快捷方式
    ln -s a a.soft
    硬链接：不占用磁盘空间,创建硬链接对应文件会有一个磁盘i节点计数的增加，否则减少,只有文件才能创建硬链接
        ln a a.hard:

    9. 文件或目录属性
        wc: 获取文本文件信息 行数，单词数 字节数 文件名
        od: 查看二进制文件 
            -t 参数：
                c: ascii数码
                d：有符号十进制数
                f: 浮点数
                o: 八进制
                u: 无符号十进制数
                x: 十六进制数字
        du: 查看当前目录大小
            -h 以人能看懂的方式显示
        df: 查看磁盘使用量
            -h 以人能看懂的方式显示
    
    10. which命令
        查找使用的命外部令在上面位置
        从bin目录搜索
        内建命令像cd查不到

    11. 修改文件权限
        whoami: 查看我是谁
        1. 文字设定法
            chmod [who] [+|-|=] [mode] 文件名
                who:
                    文件所有者:     u
                    文件按所属组:   g
                    其他人:        o
                    所有人(默认)：        a
                +: 添加权限
                -：减少权限
                =：覆盖原来的权限
                mode:
                    r: 读
                    w: 写
                    x: 执行
            实例
            chmod o+w temp
        2. 数字设定法
            -: 没有权限
            r: 4
            w: 2
            765
            7   rwx 文件所有者
            6   rw- 文件所属的组
            5   r-x 其他人
            示例：
            chmod -001 tmp
    12. 修改文件所有者和所属组
        chown 新的所有者 文件名
        chown 新的所有者:所属组 文件名
        需要管理员权限
        chgrp 所有组 文件名
        注意: 目录必须有执行权限x
    
    13. 文件的查找和检索
        1. 按照文件名查找
        find 查找的目录 -name "文件名字"
        示例：
        find /home/snowlands -name "hello.c"
        find /home/snowlands -name "hello.*"
        find /home/snowlands -name "hello.?"
        2. 按照文件大小查找
        find 目录 -size[+|-|=]大小
        +: 大于
        -：小于
        =: 等于
        实例：
        find ~ +10K
        find ~ -size +10M -size -100M
        3. 按照文件类型dlbcsp查找
        find 文件查找目录 -type [f|d|l|b|c|s|p]
        示例:
        find ~ -type f
        4. 按照文件内容查找
        grep -r "查找内容" 查找路径
        -r: 递归查找
        示例：
        grep -r "stdio.h" ~

    14. 安装软件
        1. apt-get
            1. 安装
                apt-get install 软件名
                示例：
                sudo apt-get install tree
            2. 移除
                apt-get remove 软件名
                示例：
                sudo apt-get remove tree
            3. 更新
                1. 从官方服务器（软件源）更新软件列表
                apt-get update
                2. 安装软件列表更新软件
                apt-get upgrade
            4. 清理下载的安装包
                apt-get clean
        2. aptitude
            同上
        3. dpkg
            1. 安装
                dpkg -i 安装包
            2. 卸载
                dpkg -r 软件名
        4. 源码安装
            1. 下载源码, 解压缩
            2. 进入目录
            3. ./config
            4. make
            5. make install
            6. 删除
            make distclean
            (以上步骤看情况)
