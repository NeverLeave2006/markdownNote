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
start: 开始执行
n: next单步调试
c: continue继续，直到断点
s: step 进入函数体内部
l: 查看函数内源代码代码
b 22: 加断点
p i: 查看变量值
ptype i: 查看变量类型
display i: 追踪变量值
info display: 获取追踪变量编号
undisplay 变量编号: 不追踪变量编号
u: 跳出单次循环
finish: 跳出当前函数
d或者del 断点信息: 删除断点
set var i=10: 设置变量值
quit: 退出gdb