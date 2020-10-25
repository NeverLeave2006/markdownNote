# IPC 进程间通讯
1. 管道
    pipe
        一般读写行为
    fifo:(有名管道)
        非血缘关系进程间通信
    共享内存
        
2. 信号
3. 共享映射区
    mmap
        函数参数使用注意事项
        用于非血缘关系进程间通信
4. 本地套接字(最稳定)

管道
    - 文件
    d 目录
    l 符号连接
    伪文件:
    s 套接字
    b 块设备
    c 字符设备
    p 管道

管道读写示例
```cpp
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main()
{
    int fd[2];
    pid_t pid;

    int ret =pipe(fd);
    if(ret==-1){    //获取管道
        perror("pipe error:");
        exit(1);
    }
    pid=fork();
    if(pid==-1){
        perror("pipe error:");
        exit(1);
    }else if(pid==0){ //子进程 读数据
        close(fd[1]);
        char buf[1024];
        ret=read(fd[0],buf,sizeof(buf));
        if(ret==0){
            printf("----------------\n");
        }
        write(STDOUT_FILENO,buf,ret);
    }else{
        close(fd[0]);
        char *std="hello pipe\n";
        write(fd[1],"hello pipe\n",strlen("hello pipe\n"));
    }
    return 0;
}
```

## mmap共享内存

    mmap函数:
    void *mmap(void *addr, size_t length, int prot, int flags,int fd, off_t offset);
        参数：
            addr: 建立映射区的首地址
            length: 欲创建映射区的大小
            prot: 映射区权限PROT_READ,PROT_WRITE,PROT_READ|PROT_WRITE
            flags: 标志位参数
                MAP_SHARED: 会将映射区所做的操作反射到物理设备(磁盘上)
                MAP_PRIVATE: 映射区的修改不会反映到物理设备
            fd: 用来建立映射区的文件描述符
            offset: 映射文件偏移(4K的整数倍)
    int munmap(void *addr, size_t length);

    借助共享内存访问存放磁盘文件
        借助指针访问磁盘文件

    父子进程，血缘关系进程 通信

    匿名映射区