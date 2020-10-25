## exec函数族
fork后子进程执行程序调用
调用exec后进程id不变,子进程原有的内容没了
六种以exec开头的函数
1. int execl
没有当前目录，其余同下面的
2. int execlp(const char *file,const char *arg,...):
执行当前目录命令
    list path
```cpp
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main()
{
    pid_t pid;
    pid=fork();
    if(pid==-1){
        perror("fork error:");
        exit(1);
    }else if(pid>0){
        sleep(1);
        printf("parent\n");
    }else{ 
        execlp("ls","","-a",NULL);
    }
    return 0;
}
```
3. int execle
list environment
4. int execv
d
int execvp
int execve

dup2函数，文件描述符拷贝
1 stdin
2 stdout
3 stderr
4 file

dup2(2,3) 3->stderr

子进程打开文件输出文件
```cpp
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>

int main()
{
    int fd;
    fd=open("ps.out",O_WEONLY|OCREAT|O_TRUUNC,0644);
    if(fd<0){
        perror("open ps.out err");
        exit(1);
    }
    dup2(fd,STDOUT_FILENO);

    execlp("ps","ps","ax",NULL);

    return 0;
}
```

僵尸进程和孤儿进程
init进程, pid=1或者用户进程，父进程比子进程死的早
僵尸进程
子进程结束后还有一个PCB,父进程没处回收

回收僵尸进程
wait

1. 阻塞等子进程退出
2. 回收PCD
3. 获取子进程状态
```cpp
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>

int main()
{
    pid_t pid wpid
    pid=fork();
    if(pid==0){
        printf("--------------------------");
        sleep(10);
        printf("__________________________");
    }e1se if(pid>0){
        wpid=wait(&status);
        if(wpid){
            printf("++++++++++++++++++++++++++");
            sleep(1);
        }
    }else{
        perror("fork");
        return 0;
    }
}
```

wait回收子进程结果
子进程退出结果
1.  WIFEXITED(status)
    WEXITSTATUS(status)
2.  WIFSIGNALED(status)
    WTERMSIG(status)
waitpid
pid_t waitpid(pid_t pid,int *status,int options)

总结:
execlp p:path 系统可执行程序
execl  l:list 用户自定义可执行程序
execv  v:argv 命令行参数
execvp
execve e:environment
只有失败返回值

wait:  
     僵尸进程, PCB残留
        wait
        waitpid
        杀死父进程
     孤儿进程, init进程领养