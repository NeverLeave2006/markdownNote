# 网站首页高可用nginx+lua

## lua
1. lua介绍
- 1993年
- 巴西
- 通过灵活嵌入应用程序中从而为应用程序提供灵活的扩展和定制功能
- 由标准C编写成，可以在所有平台运行
- 没有强大的库，不适合开发独立应用程序
- 有一个JIT项目，特定平台上的即时编译

> 清凉小巧的脚本语言，标准C写成，开源，嵌入应用程序，提供灵活的扩展和定制功能

特定：
- 支持面向过程和函数式编程
- 自动内存管理，只提供了一种通用类型table, 可以实现数组，哈希表，集合，对象
- 内置模式匹配；闭包，函数看作一个值；多线程（协同进程，不是操作系统进程）
- 可以通过闭包支持面向对象的一些关键机制
  

应用场景
- 游戏开发
- 独立应用脚本
- Web应用脚本
- 扩展和数据库插件如: MySQL Peoxy 和 MySQL WorkBench
- 安全系统，如入侵检测系统
- redis中嵌套调用实现类似事务的功能
- web容器中应用处理一些过滤 缓存等等的逻辑， 例如nginx.

### lua基本语法

- lua有交互式编程和脚本式编程
  - 交互式编程就是直接输入语法到lua控制台程序，直接执行
  - 脚本式编程需要编写脚本文件，然后再执行
> 一般采用脚本式编程。（例如编写一个hello.lua文件，输入文件内容，并执行lua hello.lua即可）

- lua注释

单行注释
```lua
-- 这是lua注释
```

多行注释
```lua
--[[
    多行注释
    多行注释
]]
```

- lua关键字

|          |       |       |        |
| -------- | ----- | ----- | ------ |
| and      | break | do    | else   |
| elseif   | end   | false | for    |
| function | if    | in    | local  |
| nil      | not   | or    | repeat |
| return   | then  | true  | until  |
| while    |       |       |        |

- 定义变量
默认全局变量，局部变量要使用local关键字
```lua
-- 全局变量赋值
a=1
-- 局部变量赋值
local b=2
```

- lua中的数据类型
1. 动态类型语言，不需要定义变量类型，值可以存储在变量中，作为参数传递或结果返回
2. lua中有8个基本类型，分别为: nil,boolean,number,string,userdata,function,thread和table



| 数据类型 | 描述                                                         |
| -------- | ------------------------------------------------------------ |
| nil      | 这个最简单，只有值nil属于该类，表示一个无效值（在条件表达式中相当于false）。 |
| boolean  | 包含两个值：false和true。                                    |
| number   | 表示双精度类型的实浮点数                                     |
| string   | 字符串由一对双引号或单引号来表示                             |
| function | 由 C 或 Lua 编写的函数                                       |
| userdata | 表示任意存储在变量中的C数据结构                              |
| thread   | 表示执行的独立线路，用于执行协同程序                         |
| table    | Lua 中的表（table）其实是一个"关联数组"（associative arrays），数组的索引可以是数字、字符串或表类型。在 Lua 里，table 的创建是通过"构造表达式"来完成，最简单构造表达式是`{}`，用来创建一个空表。 |

- 流程控制
如下，类似于if else

```lua
-- [0 为 true]
if(0) then
  print("0为true")
else
  print("0不为true")
end
```

- 函数
lua也可以定义函数，类似于java中的方法，例如:
```lua
-- [[函数返回两个值的最大值]]
function max(num1,num2)
  if(num1>num2) then
    result = num1; --这里result是全局变量
  else
    result = num2;
  end;
  return result;
end

--调用函数
print("两值比较最大值为",max(10,4))
print("两值比较最大值为",max(5,6))
```

- require函数
require函数用于引入其他模块类似于java中对类的引用
用法
```lua
require "<模块名>"
```

# nignx+lua+redis实现广告缓存

## OpenResty
基于nginx实现的可伸缩的web平台
相当于封装了nginx并且集成了LUA脚本

## 缓存预热
先读取一部分数据

## 二级缓存是数据读取
