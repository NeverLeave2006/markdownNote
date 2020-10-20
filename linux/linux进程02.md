## exec函数族
六种以exec开头的函数
int execl
int execlp(const char *file,const char *arg,...):

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
int execle
int execv
int execvp
int execve