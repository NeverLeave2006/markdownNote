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
    zip:
3. 进程隔离
4. 网络隔离
5. ftp
6. nfs
7. ssh
8. scp
9. 其他命令
10. 关机重启
