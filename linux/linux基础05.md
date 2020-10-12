1.使用read,write读写大文件
```cpp
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

int main()
{
    //打开一个已经存在的文件
    int fd=open("english.txt",O_RDONLY);
    if(fd==-1){
        perror("open");
        exit(1);
    }

    //创建一个新文件 -- 写操作
    int fd1=open("newfile",O_CREAT|O_WRONLY,0664);
    if(fd1==-1){
        perror("open1");
        exit(1);
    }

    //read 
    char buf[2048]={0};
    int count=read(fd,buf,sizeof(bud));
    if(count==-1){
        perror("open1");
        exit(1);
    }
    while(count)
    {
        //将读出的数据写入另一个文件中
        int ret=write(fd1,buf,count);
        printf("write bytes %d\n",ret);
        //continue read file
        int count=read(fd,buf,sizeof(bud));
    }
    //close file
    close(fd);
    close(fd1);
}
```

## lseek
1. 获取文件大小
2. 移动文件指针
3. 文件拓展

```cpp
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

int main()
{
    //打开一个已经存在的文件
    int fd=open("aa",O_RDWR);
    if(fd==-1){
        perror("open");
        exit(1);
    }

    int ret=lseek(fd,0,SEEK_END);
    printf("file lenght = %d\n",ret);

    //文件拓展
    int ret=lseek(fd,2000,SEEK_END);
    printf("return value %d\n",ret);

    //实现文件拓展，需要再最后做一次写操作
    write(fd,"a",1);
    close(fd);
    return 0;
}
```

文件拓展，下载的时候使用文件拓展，占用空间。多线程，任意移动文件指针。

## stat函数
获取文件属性信息
stat 命令
stat 文件名

int stat(const char *pathname, struct stat *statbuf);
int fstat(int fd, struct stat *statbuf);
int lstat(const char *pathname, struct stat *statbuf);

成功0
失败1

//stat结构体
```c
    struct stat {
        dev_t     st_dev;         /* ID of device containing file */
        ino_t     st_ino;         /* Inode number */
        mode_t    st_mode;        /* File type and mode */
        nlink_t   st_nlink;       /* Number of hard links */
        uid_t     st_uid;         /* User ID of owner */
        gid_t     st_gid;         /* Group ID of owner */
        dev_t     st_rdev;        /* Device ID (if special file) */
        off_t     st_size;        /* Total size, in bytes */
        blksize_t st_blksize;     /* Block size for filesystem I/O */
        blkcnt_t  st_blocks;      /* Number of 512B blocks allocated */

        /* Since Linux 2.6, the kernel supports nanosecond
            precision for the following timestamp fields.
            For the details before Linux 2.6, see NOTES. */

        struct timespec st_atim;  /* Time of last access */
        struct timespec st_mtim;  /* Time of last modification */
        struct timespec st_ctim;  /* Time of last status change */

    #define st_atime st_atim.tv_sec      /* Backward compatibility */
    #define st_mtime st_mtim.tv_sec
    #define st_ctime st_ctim.tv_sec
    };
```

stat函数
    穿透(追踪)函数 -- 软连接指向的文件
lstat函数
    不穿透(追踪) 只返回软连接信息
