## gdb调试
编译时需要加-g 参数
```shell
    gdb 包含调试信息的程序
```

1. l: 查看源代码(10行)
l select_sort.c:20
查看select_sort.c中第20行的内容

2. b: 打断点
b 22
b 15 if i==15: 在i=15的时候停止

3. i: 查看断点信息
i b

4. 执行程序
start: 开始执行，执行一步
run: 运行到断点 
n: next单步调试
c: continue继续，直到断点
s: step 单步，可以进入函数体内部
l: 查看函数内源代码代码
b 22: 加断点
p i: 查看变量值
ptype i: 查看变量类型
display i: 追踪变量值
info display: 获取追踪变量编号
undisplay 变量编号: 取消追踪变量编号
u: 跳出当前循环
finish: 跳出当前函数
d或者del 断点信息: 删除断点
set var i=10: 设置变量值
quit: 退出gdb

## makefile编写
```shell
gcc *.c -Iinclude ./ -Wall -g -O2 -D DEBUG
```
命名方式：
1. makefie
2. Makefile

makefile实例
```makefile
app:main.c add.c sub.c mul.c
    gcc main.c add.c sub.c mul.c -o app
```

目标:依赖
    命令
编译命令
make

分开编译
```makefile
app:main.o add.o sub.o mul.o
    gcc main.o add.o sub.o mul.o -o app

main.o:main.c
    gcc -c main.c
add.o:add.c
    gcc -c add.c
mul.o:mul.c
    gcc -c mul.c
sub.o:sub.c
    gcc -c sub.c
```
make会自动编译修改过的文件

makefile工作原理
从目标向下搜索，构建搜索树(后续遍历)
只有修改过的才会重新编译

makefile中的变量
变量不需要类型

`$(var)`获取变量

```makefile
%.o:%.c
    gcc -c $< -o $@

# 匹配
# %.o:%.c->main.o:main.c
    $(CC) -c $< -o $@
自动变量
$<: 第一个依赖 %.o main.o
$@: 规则中的目标
$^: 规则中所有的依赖
以上只能在规则中的命令中使用
```

```makefile
obj=main.o add.o sub.o mul.o
target=app
CC=cc
CPPFLAGS = -I # 预处理
CFLAGS = -WALL -g -c # 编译时使用
LDFLAGS = -L -l
$(target):$(obj)
    $(CC) main.o add.o sub.o mul.o -o app

%.o:%.c
    $(CC) -c $< -o $@
# 上面模式用于代替下面
main.o:main.c
    $(CC) -c main.c
add.o:add.c
    $(CC) -c add.c
mul.o:mul.c
    $(CC) -c mul.c
sub.o:sub.c
    $(CC) -c sub.c
```

makefile函数
1. makefile中所有的函数都是有返回值的
makefile提供的函数

wildcard 返回指定的文件名
patsubst 匹配替换函数(patsub 源 目标 输入)
```makefile
src=$(wildcard ./*.c)
obj=$(patsubst ./%.c, ./%.o $(src))
```

自定伪目标
```makefile
#清除生成目标 -f强制删除

#定义伪目标
.PHONY:clean
clean:
    -mkdir /aa #加-如果这条命令执行失败忽略这条命令
    rm $(obj) $(target) -f

hello:
    echo "hello"
```

调用clean目标
```shell
make clean
make hello
```

## C库函数
fopen
fclose
fread
fwrite
fgets
fputs
fscanf
fprintf
fseek
fputc
ftell
feof
fflush刷新缓冲区

虚拟地址空间0-3G
文件描述符
PCB

前三个:
    stdin
    stdout
    stderr
PCB控制块
每打开一个新文件打开一个文件描述符

file文件名，查看文件类型
C库函数调用系统api printf->writr(fd,"hello",5)->sys_write()->内核层设备驱动函数->通过设备驱动操作硬件

查询库函数
man 2 open

1. open
    打开方式:
        必选项:
            O_RDONLY
            O_WRONLY
            O_RWDR
        可选项:
            O_CREAT
                文件权限: 本地掩码
                    文件实际权限
                    和本地掩码取反再按位与
                    777
                    111111111
                    111111101
                    111111101
                    775
            O_TRUNC
            O_EXCL
            O_APPEND

    查询open函数文档
    man 2 open

    errno错误宏定义位置
    1-34: /usr/include/asm-generic/errno-bash.h
    35-133: /usr/include/asm-generic/errno.h
    perror函数: 将上一个函数发生错误的原因输出到标准设备

open函数的使用1
myopen.c
```c
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

int main()
{
    int fd;//文件描述符
    // 打开已经存在的文件
    fd=open("bucunz",O_RDWR);
    if(fd==-1){
        perror("open file");
        exit(1);
    }

    //创建新文件
    fd=open("myhello",O_RDWE|O_CREAT,0777);
    if(fd==-1){
        perror("open file");
        exit(1);
    }
    printf("fd= %d\n",fd);

    //关闭文件
    int ret=close(fd);
    if(ret == -1)
    {
        perror("close file");
        exit(1);
    }
    printf("ret= %d\n",ret);
}
```

open函数的使用2
```cpp
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

int main()
{
    int fd;//文件描述符
    //判断文件是否存在
    fd=open("bucunz",O_RDWR|O_CREAT|O_EXCL,0777);
    if(fd==-1){
        perror("open file");
        exit(1);
    }
    printf("File exists\n");

    //将文件截断为0
    fd=open("myhello",O_RDWR|O_TRUNC);
    if(fd==-1){
        perror("open file");
        exit(1);
    }
    printf("fd= %d\n",fd);

    //关闭文件
    int ret=close(fd);
    if(ret == -1)
    {
        perror("close file");
        exit(1);
    }
    printf("ret= %d\n",ret);
}
```

2. read
    返回值: ssize_t read(int fd, void *buf,size_t count);
    -1:读文件失败
    0:文件读完了
    >0: 读取的字节数

3. write
    返回值: ssize_t write(int fd,const void *buf,size_t count);
    -1:读文件失败

4. lseek
    返回值 off_t lseek(int fd, off_t offset,int whence);
    SEEK_SET
    SEEK_CUR
    SEEK_END

5. close
