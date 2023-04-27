# 内存结构

## 1. 程序计数器
program counter register程序计数器(寄存器)
作用:记住下一条指令的执行地址,在CPU中用寄存器实现
特点:
   - 线程私有
   - 唯一不会内存溢出的区

## 2. 虚拟机栈
作用:线程运行时的内存空间,栈内由多个**栈帧**组成
栈帧: 每个方法运行时需要的内存(参数,局部变量,返回地址)
每个线程只有一个活动栈帧,对应当前的正在执行的方法

问题:
1. 垃圾回收是否涉及栈内存?
> 不需要,方法运行完自动弹出!
2. 栈内存分配越大越好吗?
> -Xss: 设置栈大小(stack size)的参数</br>
> 默认大小1024KB(Linux/x64,macOS),Linux根据虚拟内存来影响栈大小</br>
> 实例:</br>
> ```
> -Xss 1m
> -Xss 1024k
> -Xss 1048576
> ```
> 栈越大,线程越少.栈越大,可以多次递归调用!</br>
3. 方法内的局部变量是否线程安全?
> 如果方法内局部变量没有逃离方法内的作用返回,它是线程安全的</br>
> 如果是局部变量引用对象,并逃离了方法的作业范围,需要考虑线程安全</br>
> 没有入参，没有返回值

### 栈内存溢出 StackOverFlowError
- 栈帧过多: 递归过多
- 栈帧过大: 

### 线程运行诊断
案例1: cpu占用过多
- top命令,定位占CPU用过高的进程
- ps H -eo pid,tid,%cpu|grep 进程id定位哪个线程引起的cpu占用过高
- jstack命令进程id查看,找对应的线程编号(nid换算),定位代码
  - 可以根据线程id找到有问题的线程,进一步定位到问题代码的源码行数

案例2: 程序运行很长时间没有结果
- jstack 进程号 对应进程,查死锁

## 3. 本地方法栈
非java代码方法
例如Object中的clone，hashcode,notify,wait方法


## 4. 堆

- 通过new关键字, 创建的对象都会使用堆内存

### 4.1 特点: 

- 它是线程共享的, 堆中对象需要考虑线程安全问题
- 有垃圾回收机制

### 堆内存溢出 OutOfMemoryError
-Xmx4G

## 堆内存诊断

1. jps
  - 查看当前系统中有哪些进程
2. jmap工具
jmap -heap 检查堆内存占用
  - 查看堆内存占用情况
3. jconsole工具
  - 图形界面的,多功能的检测工具, 可以连续监测
4. jvisualvm
  - oracle才有的，更全面

案例

- 多次回收后占用还是很高
jps
jcousole gc


5. 方法区

- 所以java虚拟机线程共享的区
- 类相关的信息(成员等),运行时常量池
- 逻辑上是堆的组成部分，不强制位置(oracle是永久代，1.8之后是元空间)

1.8以前是永久代

1.8以后是元空间

设置最大有永久代空间大小

-XX:MaxPermSize=8m

设置最大元空间大小

-XX:MaxMetaspaaceSize=8m 

场景 cglib

- spring

- mybatis

javap -v 反编译字节码

# 面试题 StringTable

## StringTable特性

- 常亮池中的字符串仅是符号，第一次用到时才变为对象
- 利用串池机制，来避免重复创建字符串对象
- 字符串变量拼接的原理是StringBuilder
- 字符串拼接的原理是编译期优化
- 可以使用intern方法,主动将串池中还没有的字符串对象放入串池

intern() 1.6之前是复制一份(不同对象)放入串池，1.6之后是(同一对象)直接放入串池


关闭 "过长的定义是，超过98%的时间用来做GC并且回收了不到2%的堆内存。用来避免内存过小造成应用不能正常工作。" 策略

-XX:-UseGCOverheadLimit

## StringTable垃圾回收机制

-XX:+PrintStringTableStatistics 打印字符串表的统计信息

-XX:+PrintGCDetails -verbose:gc 打印大集会上详细信息

-XX:StringTableSize=200000 StringTable桶个数为200000，字符串常量非常多的话应该设置大一点


没有引用的常量会被垃圾回收


StringTable类似HashTable实现


# 直接内存

属于系统内存

- 常见于NIO操作时, 用于数据缓冲区
- 分配回收成本较高, 但读写性能高
- 不受JVM内存回收管理

基本使用, 比虚拟机栈速度更快


使用Unsafe对象释放内存

ByteBuffer中集成了Unsafe对象回收对象

-XX:+DisableExplicitGC 禁用显式垃圾回收 代码中的System.gc()无效 可能导致被分配的直接内存无法回收

# 垃圾回收机制/

1. 如何判断对象可以回收
2. 垃圾回收算法
3. 分代垃圾回收
4. 垃圾回收器
5. 垃圾回收调优

## 如何判断对象可以回收

引用计数: 记录引用次数，但是无法防止循环引用，早期python虚拟机使用了该技术

可达性分析算法: 根对象扫描, 不能被扫描到的算法被回收

- Java虚拟机中的垃圾回收采用可达性分析来探索所有存活的对象
- 扫描堆中的对象， 看是否能够沿着GC Root对象为起点的引用链找到该对象,找不到，表示可以回收
- 哪些对象可以作为GC Root?

Eclipse MAT工具 堆分析工具

抓取内存快照
jmap -dump:format=b,live,file=1.bin 21384(pid)

根对象：

- 系统类 Object Hashmap String
- Native Stack 本地方法
- BusyMOnitor synchonize关键字枷锁
- 线程对象

## 五种引用


- 强引用 根对象直接能找到的引用
- 软引用 根对象间接引用,没有被其他强引用直接引用。垃圾回收内存空间不够的时候会被回收
- 弱引用 强引用间接引用，垃圾回收时不管内存够不够都会被回收

引用队列, 释放软弱引用的对象

以下两种需要配合应引用队列使用

- 虚引用 ByteBuffer 内有Cleaner回收分配的直接内存,在回收ButeBuffer时,首先释放虚引用,由referenceHandler对象回收
- 终结器引用 垃圾回收时Object的finalize()方法被调用时,将其加入引用队列,效率低,不推荐

软引用应用:
用SoftRefference引用不重要的对象

引用队列清理软引用

弱引用应用
WeakReference


## 垃圾回收算法

- 标记清除胡算法：先标记再清除

优点: 速度快
缺点: 内存碎片，造成空间不连续

- 标记整理: 标记完成在整理,防止内存碎片

优点: 没有内存碎片
缺点: 速度慢

- 复制算法: 复制未被清理的内容到一个新的空白内存，再交换位置

优点: 没有内存碎片
缺点：占用双倍的内存空间

### 分代回收

新生代，老年代

minior gc: eden->form->to---15次GC以后或者to内存空间不够-->老年代
引发stop the world 暂停其他线程,暂停时间不长
对象超过阈值时,晋升到老年代。最大寿命15

FUll gc: 全部包含老年代的垃圾回收


- 对象首先分配在伊甸园区
- 新生代空间不足时触发minor gc,伊甸园和from存活的对象使用copy复制到to中, 存活的对象年龄加1并且交换from to
- minor gc会引发stop the world, 暂停其他用户的线程,等回收结束才恢复运行
- 当对象寿命超过阈值时会晋升至老年代,最大寿命是15(4bit)
- 当老年代空间不足,会先尝试触发minor gc，如果之后空间仍不足,那么触发full gc, STW(stop the world)时间更长

相关VM参数

|含义|参数|
|----|----|
|堆初始大小|-Xms|
|堆最大大小|-Xmx或-XX:MaxHeapSize=size|
|新生代大小|-Xmn或-XX:NewSize=size + -XX:MaxNewSize=size|
|幸存区比例(动态)|-XX:InitialSurvivorRatio=ratio和-XX:+UseAdaptiveSizePolicy|
|幸存区比例|-XX:SurvivorRatio=ratio|
|晋升阈值|-XX:MaxTenuringThreshold=threshold|
|晋升详情|-XX:+PrintTenuringDistribution|
|GC详情|-XX:+printGCDetails -verbose:gc|
|FullGC前MinorGC|-XX:+ScavengeBeforeFullGC|

##  垃圾回收器

1. 串行
- 单线程
- 堆内存较小，适合个人电脑

1. 吞吐量优先
- 多线程
- 堆内存较大，多核CPU
- 让单位时间内STW的时间最短
   
1. 响应时间优先
- 多线程
- 堆内存较大，多核CPU
- 尽可能让STW的时间最短


### 串行垃圾回收器
-XX:+UseSerialGC=Serial+SerialOld 开启串行垃圾回收器,包括新生代和老生代的垃圾回收器

所有线程在安全点先停下来,其中一个垃圾回收线程运行，其他的阻塞

### 吞吐量优先的垃圾回收器
-XX:+UseParallelGC ~ -XX:+UseParallelOldGC 1.8默认开启并行GC,开启其中一个会开启另一个 老年代使用标记整理算法
-XX:+UseAdaptiveSizePolicy 新生代自适应调整大小
-XX:GCTimeRatio=ratio 垃圾回收时间占用率
-XX:MaxGCPauseMillis=ms 最大暂停时间 默认200ms
-XX:ParallelGCThreads=n 垃圾回收线程数


### 响应时间优先

-XX:+UseConcMarkSweepGC ~ -XX:+UseParNewGC ~SerialOld 开启并发标记清除垃圾回收器
-XX:ParallelGCThreads=n ~ -XX:ConcGCThreads=threads 并行，并发线程数
-XX:CMSInitiatinggOccupancyFraction=percent 执行CMS的内存占比
-XX:+CMSScavengeBeforeRemark 重新标记时做一下minor GC

内存碎片过多会导致并发失败

# G1

定义: Garbage First (优先收集垃圾最多的区域)

- 2004论文发布
- 2009 JDK6u14体验
- 2012 JDK 7u4官方支持
- 2017 JDK 9 默认

适用场景

- 同时注重吞吐量(Throughput)和低延迟(Low latency),默认暂停目标是200ms
- 超大堆内存,会将堆划分为多个大小相等的Region
- 整体上是标记+整理算法,两个区域之间是复制算法

相关JVM参数
-XX:+UseG1GC 使用G1垃圾回收器(jdk9之后默认的)
-XX:G1HeapRegionSize=size
-XX:MaxGCPauseMillis=time(ms)
 
## G1垃圾回收阶段

### 三阶段循环

1. young Collection

- 新生代垃圾收集
- 会STW(时间短)
- eden区域->s幸存区
- s幸存区->o老年代


2. Young Collection + Collection Mark 新生代的垃圾回收和并发标记

   - 在Young GC时会进行GC Root 的初始标记
   - 老年代占用堆内存比例达到阈值时,进行并发标记(不会STW), 由下面的JVM参数决定

   -XX:InitiatingHeapOccupancyPercent=percent (默认45%)

3. Mixed Collection
 
  会对E,S,O进行全面垃圾回收

  - 最终标记(Remark)会STW

  - 拷贝存活(Evacuation)会STW

  -XX:MaxGCPauseMillis=ms
  从老年代挑出部分回收价值最高的进行回收

## Full GC

- serialGC
  - 新生代内存不足发生的垃圾收集 minor gc
  - 老年代内存不足发生的垃圾收集 full gc
- ParallelGC
  - 新生代内存不足发生的垃圾收集 minor gc
  - 老年代内存不足发生的垃圾收集 full gc
- CMS
  - 新生代内存不足发生的垃圾收集 minor gc
  - 老年代内存不足 
- G1
  - 新生代内存不足发生的垃圾收集 minor gc
  - 老年代内存不足 达到阈值,并发标记+混合收集

6) Young Collection 跨代应用

  - 新生代回收的跨代引用(老年代引用新生代)问题

  - 卡表与Remembered Set
  - 在引用变更时通过post-write barrier+dirtyy card queue
  - connect refinement threads 更新 Remembered Set

7) remark 重新标记

8) jdk 8u20 字符串去重

节省内存

9) 并发标记类卸载

-XX:+ClassUnloadingWithConcurrentMark 默认启用

10） 回收巨型对象

- 一个对象大于region的一半时, 称为巨型对象
- G1不会对巨型对象进行拷贝
- 回收时被优先考虑
- G1会跟踪老年代所有incoming引用, 这样老年代incoming引用为0的巨型对象就可以在新生代垃圾回收时处理掉

11) JDK9并发标记时间的调整

- 并发标记时间必须在堆空间占满前完成， 否则退化为 FullGC
- JDK9之前需要使用 -XX:InitiatingHeapOccupancyPercent
- JDK9可以动态调整
  - -XX:InitiatingHeapOccupancyPercent用来设置初始值
  - 进行数据采样并动态调整
  - 总会添加一个安全的空挡空间

12) 更高效的回收

# 垃圾回收调优

预备知识

- 掌握GC相关的VM参数, 会基本的空间调整
- 掌握相关工具
- 准则: 调优跟2应用, 环境有关, 没有同意的法则

java -XX:+PrintFlagFinal -versiion | findstr "GC" //查看虚拟机垃圾回收参数

