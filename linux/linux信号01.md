# 信号
1. 信号的概念
    基本属性

    信号四要素：

2. 产生信号的5种方式
    kill
    alarm函数
    setitimer函数
3. 信号集操作函数
    信号屏蔽字
    未决信号集
4. 信号的捕捉
    注册信号捕捉函数
    signaction函数(重点)

##  信号的概念
简单
不能携带大量信息
满足某个特设条件才能发送
##  信号的机制
信号 又称软中断

## 信号相关的事件和状态
产生信号:
    1. 按键产生: ctrl+c, ctrl+z, ctrl+/
    2. 系统调用产生: kill,raise,abort
    3. 软件条件产生: 定时器alarm
    4. 硬件异常产生: 非法访问内存，除0错误，内存对齐错误
    5. 命令产生: kill命令
通达: 递送并且到达进程
未决: 产生和递达之间的状态，主要用于阻塞(屏蔽)导致该状态
信号的处理方式:
    1. 执行默认动作
    2. 忽略(丢弃)
    3. 捕捉(调取用户处理函数)
   linux内核的进程控制块PCB是一个结构体, task_struct, 除了包含进程id, 状态，工作目录, 用户id, 组id, 文件描述符号表, 还包含了信号相关的信息, 主要指阻塞信号集和未决信号集


## 信号四要素
每个信号必备四要素,分别是:
1.编号, 2.名称, 3.事件, 4.默认处理动作
可以通过man 7 signal查看

1-31信号
unix高级环境编程
处理方式:
1. Term终止进程
2. Ign忽略信号(默认操作)
3. Core中止进程，生成core文件(用于内核调试)
4. Stop暂停进程
5. Continue继续进程

## 信号的产生
终端按键产生信号
ctrl+c -> 2 SIGINT(中止/终端) "INT" interrupt
ctrl+z -> 20 SIGTSTP(暂停/中止) "T" Terminal
ctrl+\ -> 3 SIGQUIT(退出)

硬件异常产生信号
除0操作 -> 8 SIGFPE(浮点数例外) "F" float浮点操作数
非法访问内存 -> 11 SIGSEGC(段错误)
总线错误 -> 7 SIGBUS

kill函数/命令产生信号
-9 杀死进程

kill函数
```cpp
int kill(pid_t pid,int sig);

//给当前进程传入杀死信号
int ret=kill(getpid(),SIGKILL);

//杀死其他进程
int i;
pid_t pid,q;

for(i=0;i<N;i++){
    pid=fork();
    if(pid==0){
        break;
    }
    if(i==2){
        q=pid;
    }
}

if(i<5){
    while(1){
        printf("I'am child &d,getpid=%d\n",i,getpid());
        sleep(1);
    }
}else{
    kill(q,SIGKILL);
}

int ret=kill(getpid(),SIGKILL);
if(ret==-1){
    exit(1);
}
```
kill函数和kill命令效果相同

abort();直接接受进程
raise(SIGINT);发信号，同上同ctrl+c

软件条件产生信号
**每个进程有且只要一个定时器**
alarm函数
alarm()
取消定时器alarm(0),返回闹钟余下秒数

```cpp
#include <stdio.h>
#include <unistd.h>

int main()
{
    int i;
    alarm(1);//定时1秒
    for(int i=0;;i++){
        printf("%d",i);
    }
    return 0;
}
```

实际时间=系统时间+用户时间+等待时间

settimmer函数
设置定时器(闹钟), 可以替代alarm函数，精度微妙us,可以实现周期定时
返回值显示函数是否调用成功
成功返回0,失败返回-1

int setitimer(int which,const struct itimerval * new value,struct itimerval *old value);
which: 定时开始时间
newvalue:
oldvalue:定时剩余的

which指定定时方式
ITIMER_REAL: 自然定时 alarm信号
ITIMER_VIRTURE: 虚拟，用户空间计时 signVT信号
ITIMER_PROF: 运行即使 用户空间+内核空间的计时

itimerval结构体
struct itimerval {
    struct timeval it_interval;//下一次定时的值
    struct timeval it_value;   //当前定时的值，微秒
}

```cpp
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

unsigned int my_alarm(unsigned int sec){
    struct itimercal it,oldit;
    int ret;

    it.t_value.tv_sec=sec;
    it.t_value.tv_usec=0;
    it.it_interval.tv_sec=0;
    it.it_interval.tv_usec=0;

    ret=setitimer(ITIMER_REAL,&it,&oldit);
    if(ret==-1){
        perror("setitimer");
        exit(1);
    }
    return oldit.it_value.tv_sec;
}

int main()
{
    int i;
    my_alarm(1);

    for(int i=0;;i++){
        printf("%d\n",i);
    }
    return 0;
}
```

