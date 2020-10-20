# 简介
1. 进程相关概念
并发
单道程序设计
多道程序设计
cpu/mmu
进程控制块
进程状态
2. 环境变量
常用的环境变量/作用
函数
3. 进程控制原语
fork函数
循环创建子进程的架构
exec函数
各个函数的参数使用方法/作用
wait/waitid
回收子进程的一般方式

# 进程相关的概念
## 程序和进程
程序，编译好的二进制文件，在磁盘上，不占用系统资源
进程，是一个抽象概念，与操作系统原理联系紧密。进程是活跃的程序，占用系统资源。在内存中执行(程序运行起来，产生一个进程)
并发
在操作系统中，一段时间内运行的多个程序

# CPU和MMU
CPU: 主要
多级存储: 硬盘->寄存器->cpu预取器—>译码->ALU->回写

## MMU: 内存管理单元，虚拟内存空间(4G)
映射虚拟地址，可用的地址空间可以有4G
CPU四种访问级别
用户空间4级 内核空间0级
.text
.rodate
.data
.bss 未初始化区域
heap
共享库
stack
环境变量/命令行参数
内核: 进程控制块(PCB, 进程描述符)
不同虚拟内存地址互相独立

## 进程控制块
本质是tast_struct结构体
查找原型
grep -r "task_struct" /usr/src
vim %定位大括号结束位置
结构体成员:
进程id
进程状态：初始化，就绪（等CPU），运行(得到cpu)，挂起(等资源)，停止
进程切换时需要保存或者切换的一些寄存器
描述虚拟地址空间的信息
描述控制终端的信息
当前工作目录
umask掩码：保存文件创建或者修改权限
文件描述符表，指向文件的指针
信号相关的信息
用户id和组id
会话和进程组
进程可以使用的资源上限()
    ulimit -a命令: 查看资源上限

## 环境变量简介
以用户为单位，配置环境变量
是指在操作系统在运行中指定操作系统运行信息的参数
特点: 字符串
      统一格式存储
      使用形式于命令行类似
      加载位置
      引入环境变量表须要声明环境变量 extern char** environ;

PATH: 可执行文件的搜索路径
SHELL: 当前shell
HOME: 当前家目录
LANG: 

查看环境变量
打印所有环境变量
```cpp
#include <stdio.h>

extern char** environ;
int main(){
    int i;
    for(i=0;environ[i];i++){
        printf("%s\n",environ[i]);
    }
    return 0;
}
```

getenv函数:
    获取环境变量的值
    char *getenv(const char *name);
    char *secure_getenv(const char *name);
    成功，返回环境变量的值, 失败NULL那么不存在
    练习: 编程实现getenv函数

setenv函数:
    设置环境变量的值
    int setenv(const char* name,const char *value,int overwrite);
    成功0, 失败1
    overwirte：
        1: 覆盖
        2: 添加

unsetenv函数:
    int unsetenv(const char *name);


进程控制
    fork函数
    创建进程: 运行一个可执行函数

    fork 用于创建子进程
    fork 函数返回值 
        1. 返回子进程pid(非负整数) 父进程
        2. 返回0                  子进程
    循环创建子进程的架构

代码示例
```cpp
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main()
{
    pid_t pid;
    printf("XXXXXXXXXX\n");
    pid=fork();
    if(pid==-1){
        perror("fork error;");
        exit(1);
    }else if(pid==0){
        printf("I'm child, pid=%u\n ppid=%u\n",getpid(),getppid());
    }else{
        printf("I'm parent, pid=%u\n",getppid());
    }
    printf("YYYYYYYYYYYYY");

    return 0;
}

```

循环创建n个子进程
```cpp
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main()
{
    pid_t pid;
    printf("XXXXXXXXXX\n");
    int i=0;

    for(i=0;i<50;i++>){
        pid=fork();
        if(pid==-1){
            perror("fork error;");
            exit(1);
        }else if(pid==0){
            break;
        }
        
    }
    if(i<5){
        sleep(i);
        printf("I am %dth child\n",i+1,getpid());
    }else{
        sleep(i);
        printf("I am parent\n",i+1,getpid());
    }
    
    printf("YYYYYYYYYYYYY");

    return 0;
}

```


getuid: 获取实际ID

geteuid: 获取有效id

父子进程共享
父子进程共用的: 全局变量, .data .text 栈，堆，环境变量 用户id 宿主目录 进程工作目录 信号处理方式
父子进程不同的: 进程ID fork返回值 父进程id 进行运行时间 闹钟 未决信号集

gdb调试

set follow-fork-mode child 跟踪子进程
set follow-fork-mode parent 跟踪父进程

