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
```cpp
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

int main(int agrc,char* argv[1])
{
    if(argc<2){
        printf("./a.out filename\n");
        exit(1);
    }
    struct stat st;
    // struct stat* st;
    stat(argv[1],&st);
    if(ret==-1){
        perror("stat");
        exit(1);
    }
    //获取文件大小
    int size=(int)st.st_size;

    lstat(argv[1],&st);
    if(ret==-1){
        perror("stat");
        exit(1);
    }
    //获取文件大小
    int lsize=(int)st.st_size;
    printf("file size = %d\n",lsize);
}
```

一些系统文件函数介绍:

access
测试某个权限是否有某种权限
int access(const char* pathname,int mode)
mode权限类别
W_OK: 写权限
R_OK：读权限
X_OK：执行权限
F_OK：文件存在
返回：0：所有权限通过检查
     -1：有权限被禁止

chmod
改变文件类型
int chmod(const char *path,mode_t mode);
int fchmod(int fd,mode_t mode);

strtol函数
long int strtol(const char *nptr,char **endptr,int base);
字符转进制数

chown

truncate

link

symlink

readlink

unlink
用于制作临时文件, 自动删除释放文件
int unlink(const char * pathname)
```cpp
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

int main()
{
    int fd=open("tempfile",O_CREAT|O_RDWR,0644);
    if(fd==-1){
        perror("open");
        exit(1);
    }

    //删除临时file
    int ret=unlink("tempfile");

    //因为文件已经打开了，所以还可以写，关闭文件后就删除了
    write(fd,"hello\n",6);

    //重置文件指针
    lseek(fd,0,SEEK_SET);
    //read file
    char buf[24]={0};
    int len=read(fd,buf,sizeof(buf));

    //将读出的内容写到屏幕上
    write(1,buf,len);
    
    //close file
    close(fd);
    return 0;
}
```

rename 文件重命名函数
int rename(const char *oldpath,const char *newpath);

chadir 修改当前进程的路径,不是shell的当前路径

getcwd 获取当前进程工作目录

mkdir 创建目录

rmdir 删除一个空目录

opendir: 库函数

readdir: 库函数

closedir

递归读目录获取文件个数
```cpp
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

int getFileNum(char* root){
    //open dir
    DIR* dir=NULL;
    dir=opendir(root);
    if(dir==NULL){
        perror("opendir");
        exit(1);
    }

    //遍历当前打开的目录
    struct dirent* ptr=NULL;
    char path[1024]={0};
    int total=0;
    while((ptr=readdir(dir))!=NULL){
        //过滤. 和..
        if(strcmp(ptr->d_name,".")==0||strcmp(ptr->d_name,"..")==0)
        {
            continue;
        }
        //如果说目录
        if(ptr->d_type==DT_DIR)
        {
            //递归 读目录
            sprintf(path,"%s/%s",root,ptr->d_name);
            total+=getFileNum(path);
        }
        //如果是普通文件
        if(ptr->d_type==DT_REG)
        {
            total++;
        }
    }
    closedir(dir);
    return total;
}

int main(int argc,char* argcv[])
{
    int (argc<2>){
        printf("./a.out dir\n");
        exit(1);
    }
    int total=getFileNum(argv[1]);
    printf("%s has file numbers %d\n",argv[1],total);
    return 0;
}
```