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

