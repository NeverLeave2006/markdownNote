- NIO和BIO的比较
  - NIO以流的方式处理数据，而NIO以块的方式处理数据，块I/O的效率比流I/O高很多
  
  - BIO是阻塞的，而NIO是非阻塞的
  
  - BIO基于字节流和字符流进行操作，而NIO基于Channel(通道)和Buffer(缓冲区)进行操作，数据总是从通道读取到缓冲区中，或者从缓冲区写入到通道中。
  
  - Selector(选择器)用于监听多个通道的事件(比如：连接请求，数据到达等)，因此使用单个线程就可以监听多个客户端通道
  
  NIO三大核心原理示意图
  1. 每个Channel对应一个Buffer
  2. Selector对应一个线程，一个线程对应多个Channel(Channel注册到Selector)
  3. 每个channel对应一个Buffer
  4. 程序切换到哪个channel是由事件决定的，Event是一个重要的概念
  5. Selector会根据不同的事件在各个通道上切换
  6. Buffer就是一个内存块，底层是有一个数组的
  7. 数据的读取写入是通过Buffer，这个和BIO,BIO中要么是输入流，或者是输出流，不能双向，但是NIO的Buffer是可以读也可以写的，但是需要flip切换
  8. channel是双向的，可以返回底层操作系统的情况，比如UNIX底层操作系统是双向的

# Java NIO介绍
Java NIO基本介绍
1. java NIO全称java non-blocking IO，是指JDK提供的新API。 从JDK1.4开始，Java提供了一系列改进的输入/输出新特性，被统称为NIO(即New IO)，是同步非阻塞的
2. NIO相关类都放在java.nio及其子包下，并且对原java.io包中的很多类进行改写
3. NIO有三大核心部分，Channel(通道)，Buffer(缓冲区)，Selector(选择器)
4. NIO是面向缓冲区，或者面向块编程的。数据处理到一个他稍后处理的缓冲区，需要时可在缓冲区中前后移动，这就增加了处理过程中的灵活性，使用它可以提供非阻塞式的高伸缩网络。

# 缓冲区(Buffer)
基本介绍
缓冲区(Buffer)：缓冲区本质上是一个可以读写数据的内存块，可以理解成是一个容器对象(含数组)，该对象提供了一组方法，可以更轻松地使用内存块，缓冲区对象内置了一些机制，能够跟踪和记录缓冲区的状态变化情况。Channel提供从文件、网络读取数据的渠道，但是读取或者写入数据必须经由Buffer


# 通道(Channel)
1. NIO通道类似于流，但有些区别如下
   - 通道可以同时进行读写，而流只能读或者只能写
   - 通道可以实现异步读写数据
   - 通道可以从缓存读数据，也可以写数据到缓冲:

2. BIO中的stream是单向的，例如FileInputStream对象只能进行读取数据的操作，而NIO中的通道是双向的，可以读操作，也可以写操作
3. Channel在NIO中是一个接口
public interface Channel extends CloseAble{}
4. 常用的Channel的类有: FileChannel、DatagramChannel、ServerSocketChannel和SocketChannel
5. FileChannel用于文件的数据读写，DatagramChannel用于UDP数据读写，ServerSockethChannel和SocketChannel用于TCP的数据读写

## FileChannel类
FileChannel类主要用来对本地文件进行IO操作，常见的方法有
1. public int read(ByteBuffer dst),从通道读取数据并放到缓冲区
2. public int write(ByteBuffer src),把缓冲区的数据写到通道中
3. public long transferForm(ReadableByteChannel src,long position,long count),从目标通道中复制数据到当前通道
4. public long transferTo(long position,long count,WriteByteChannel target),把数据从当前通道复制给目标通道

## 关于Buffer和Channel的注意事项和细节
1. ByteBuffer支持类型化的put和get, put放入的是什么数据类型，get就应该使用响应的数据类型来取出，否则可能有BufferUnderflowException异常。
2. 可以将一个普通Buffer转成只读Buffer
3. NIO还提供了MapperedbyteBuffer, 可以让文件直接在内存(堆外的内存)中进行修改，而如何同步文件由NIO来完成。
4. 前面我们讲的读写操作，都是通过一个Buffer完成的，NIO还支持通过多个Buffer(即Buffer数组)完成读写操作，即Scattering和Gatering

# Selector(选择器)
基本介绍
1. Java的NIO,用非阻塞的IO方式。可以用一个线程，处理多个的客户端连接，就会使用到selector
2. Selector能够检测多个注册的通道上是否有事件发生(注意: 多个Channel以事件的方式可以注册到同一个Selector),如果有事件发生，便获取事件然后针对事件进行相应的处理。这样就可以只用一个单线程去管理多个通道，也就是管理多个连接和请求。
3. 只有在连接真正有读写事件发生时，才会进行读写，就大大减少了系统开销，而且不必为每个连接都创建一个线程，不用去维护多个线程
4. 避免了多线程之间的上下文切换导致的开销

特点再说明
1. Netty的IO线程NioEventLoop聚合了Selector(选择器，也叫多路复用器), 可以同时并发处理成百上千个客户端连接。
2. 当线程从客户端Socket通道进行读写认为时，若没有数据可用时，该线程可以进行其他任务。
3. 线程通常将非阻塞IO的空闲时间用在其他通道上执行IO操作，所以单独的线程可以管理多个输入和输出通道
4. 由于读写操作都是非阻塞的，这样就可以充分提升IO线程的运行效率，避免由于频繁I/O阻塞导致的线程挂起
5. 一个I/O线程可以并发处理N个客户端连接和读写操作，这从根本上解决了传统同步阻塞I/O一连接一线程模型，架构的性能，弹性伸缩能力和可靠性都得到了极大的提升

# Selector(选择器)
Selector是一个抽象类，常用方法和说明如下:
```java
public abstract class Selector Implements Cloeseable{
  public static Selector open();//得到一个选择器对象
  public int select(long timeout);//监控所有注册的通道，当其中有IO可以操作时，将对应的SelectorKey加入到内部集合中并返回，参数用来设置超时时间
  public Set<SelectionKey> selectedKeys();//从内部集合中得到所有的SelectionKey
}
```

## Selector(选择器)
注意事项
1. NIO中的ServerSocketChannel功能类似ServerSocket,ServerSocket功能类似Socket
2. selector相关方法说明
```java
selector.select();//阻塞
selector.select(1000);//阻塞1000毫秒，在1000毫秒后返回
selector.select();//唤醒selector
selector.selectNow();//不阻塞,立马返还
```

说明:
1. 当客户端连接时，会通过ServerSocketChannel 得到SocketChannel
2. selector开始监听
3. 将socketChannel注册到Selector上，register(Selector sel,int pos), 一个selector上可以注册多个SocketChannel
4. 注册后返回一个SelectionKey,会和该Selector关联(集合)
5. Selctor进行监听，select方法，返回有事件发生的通道个数。
6. 进一步得到各个SelectionKey(有事件发生)
7. 在通过SelectionKey反向获取SocketChannl channel();
8. 可以通过得到的channel完成业务处理



# SelectionKey
1. SelectionKey,表示Selector和网络通道的注册关系，共四种
int OP_ACCEPT: 有新的网络连接可以accept, 值为16
int OP_CONNECT: 代表连接已建立, 值为8

int OP_READ: 代表读操作, 值为1
int OP_WRITE: 代表写操作, 值为4
源码中:
public static final int OP_READ=1<<0;
public static final int OP_WRITE=1<<2;
public static final int OP_CONNECT=1<<3;
public static final int OP_ACCEPT=1<<4;

## ServerSocketChannel
1. 在服务器端监听新的客户端连接
2. 相关方法如下
```java
public abstract class ServerSocketChannel extends AbstractSelectableChannel implements NetworkChannel{
  public static ServerSocketChannel open();//得到一个ServerSocketChannel通道
  public final ServerSocketChannel bind(SocketAddress loacl);//设置服务端口号
  public final SelectableChannel configureBlocking(boolean block);//设置阻塞或者非阻塞模式,取值false表示采用非阻塞模式
  public SocketChannel accept();//介绍一个连接，返回代表这个连接的通道对象
  public final SelectionKey register(Selector sel,int ops);//注册一个选择器并设置监听事件
}
```

## SocketChannel
1. SocketChannel, 网络IO通道，具体负责读写操作。NIO把缓冲区的数据写入通道，或者把通道里的数据读到缓冲区
2. 相关方法如下
```java
public abstract class SocketChannel
extends AbstractSelectableChannel
implements ByteChannel,ScatteringByteChannel,GatheringByteChannel,NetworkChannel{
  public static SocketChannel open();//得到一个SocketChannel通道
  public final SelectableChannel configureBlocking(boolean block);//设置阻塞或者非阻塞模式，取值false表示采用非阻塞模式
  public boolean connect(SocketAddress remote);//连接服务器
  public boolean finishConnect();//如果上面的方法连接失败，接下来就要通过该方法完成连接操作
  public int write(ByteBuffer src);//往通道里写数据
  public int read(ByteBuffer dst);//往通道里读数据
  public final SelectionKey register(Selector sel,int ops,Object att);//注册一个选择器并设置监听事件，最后一个参数可以设置共享数据
  public final void close();//关闭通道
}
```

## NIO网络编程应用实例实例1：群聊系统
实例要求:
1. 编写一个NIO群聊系统，实现服务器和客户端之间的数据简单通讯(非阻塞)
2. 实现多群聊
3. 服务器端，可以检测用户上线，离线，并实现消息转发功能
4. 客户端: 通过channel可以无阻塞发送消息给其他所有用户,同时可以接受其他用户发送的消息(由服务器转发啊得到)
5. 目的: 进一步理解NIO非阻塞网络编程机制

# 零拷贝
## 零拷贝基本介绍
1. 零拷贝是网络编程的关键，很多性能优化离不开
2. 在Java程序中，常用的零拷贝有mmap(内存映射)和sendFile。那么，在OS里，到底是怎么样的一个设计?我们分析mmap和sendFile这两个零拷贝。
3. 另外，我们看下NIO中如何使用零拷贝(没有CPU拷贝)

## 传统IO数据读写
1. Java传统IO和网络编程的一段代码
```java
File file=new File("text.txt");
RandomAccessFile raf=new RandomAccessFile(file,"rw");

byte[] arr=new byte[(int)file.length()];
raf.read(arr);

Socket socket=new ServerSocket(8080).accept();
socket.getOutputStream().write(arr);
```

## mmap优化
1. mmap通过内存映射，将文件映射到内核缓冲区，同时，用户空间可以共享内核空间的数据。这样，在进行网络传输时，就可以减少内核空间到用户控件的拷贝次数。

## sendFile优化
1. Linux2.1版本提供了sendFile函数，其基本原理如下:
数据根本不经过用户态直接从内核缓冲区进入到SocketBuffer,同时，由于和用户态完全无关，就减少了一次上下文切换
提示: 零拷贝是指从操作系统角度没有CPU拷贝的
2. 在Linux2.4版本中，做了一些修改，避免了从内核缓冲区拷贝到Socket buffer的操作，直接拷贝到协议栈，从而再一次减少了数据拷贝。
这里其实有一次cpu拷贝kernel buffer->socket buffer 但是，拷贝的信息很少，比如length，offset，消耗低，可以忽略

## 零拷贝再次理解
1. 我们说零拷贝，是从操作系统角度来说的。因为内核缓冲区之间，没有数据是重复的(只有kernel buffer有一份数据)
2. 零拷贝不仅仅带来更少的数据复制，还能带来其他的性能优势，例如更少的上下文切换，更少的CPU缓冲伪共享以及无CPU校验和计算。

## mmap和sendFile的区别
1. mmap适合小数据量读写，sendFile适合大数据量传输
2. mmap需要4次上下文切换，3次数据拷贝;sendFile需要3次上下文切换，最少2次数据拷贝
3. sendFile可以利用DMA方式，减少CPU拷贝，mmap则不能(必须从内核拷贝到Socke)

# Java AIO基本介绍
1. JDK7引入了Asynchronous I/O, 即AIO。在进行I/O编程中，常用到两种模式：Reactor和Proactor。Java的NIO就是Reactor,当有事件法硕时，服务器端得到通知，进行相应的处理
2. AIO即NIO2.0,叫做异步不阻塞IO。AIO引入了异步通道的概念，采用了Proactor模式，简化了程序编写，有效的请求才启动线程，它的特点是先由操作系统完成后才通知服务端程序启动线程去处理，一般用于连接数较多且连接时间较长的应用
3. 目前AIO还没有广泛应用，Netty也是基于NIO而不是AIO,因此我们就不详解了。

|      | BIO |  NIO | AIO |
| ---- | ---- | ---- | ---- |
|IO模型 |同步阻塞|同步非阻塞(多路复用)|异步非阻塞|
|编程难度|简单|复杂|复杂|
|可靠性|好|好|好|
|吞吐量|低|高|高|

## 举例说明
1. 同步阻塞: 到理发店理发，就一直等理发师, 直到轮到自己理发
2. 同步非阻塞: 到理发店理发，发现前面有其他人理发，给理发师说下，先干其他事情，一会过来看是否轮到自己
3. 异步非阻塞: 给理发师打电话，让理发师上门服务，自己干其他事情，理发师来家给你理发

# 原生NIO存在的问题
1. NIO类库和API繁杂，使用麻烦: 需要熟练掌握Selector, ServerSocketChannel, SOcketChannel, ByteBuffer等
2. 需要具备其他的额外技能: 要熟悉Java多线程编程, 因为NIO编程涉及到Reactor模式, 必须熟悉多线程和网络编程, 才能编写出高质量的NIO程序
3. 开发工作量和难度非常大: 例如客户端面临断连重连、网络闪断、半包读写、失败缓存、网络拥塞和异常流的处理等等。
4. JDK NIO的Bug: 例如臭名昭著的Epoll Bug, 会导致Selector空轮询, 最终导致CPU 100%。 直到JDK 1.7版本该问题仍旧存在，没有根本解决

## Netty官网说明
1. Netty是JBOSS提供的一个Java开源框架。Netty提供异步的，基于事件驱动的网络应用程序框架，用以快速开发高性能，高可靠性的网络IO程序
2. Netty可以帮助你快速，简单开发出一个网络应用，相当于简化和流程化了NIO的开发流程
3. Netty是目前最流行的NIO框架，Netty在互联网领域、大数据分布式计算领域、游戏行业、通信行业等获得了广泛的应用，知名的Elasticsearch,Dubbo框架内部都采用了Netty。

## Netty的优点
Netty对JDK自带的NIO的API进行了封装，解决了上述问题
1. 设计优雅: 适用于各种传输类型的统一API阻塞和非阻塞Socket; 基于灵活且可扩展的事件模型，可以清晰地分离关注点；高度可定制的线程模型-单线程，一个或多个线程池。
2. 使用方便：详细记录的JavaDoc,用户指南和示例；没有其他依赖项，JDK 5(Netty3.x)或者6(Netty4.x)就足够了
3. 高性能、吞吐量更高；延迟更低；减少资源消耗；最小化不必要的内存复制。
4. 安全: 完整的SSL/TLS和StartTLS支持
5. 社区活跃、不断更新: 社区活跃，版本迭代周期短，发现的Bug可以被及时修复，同时，更多的新功能会被加入。

## Netty版本说明
1. Netty版本为netty3.x和netty4.x、netty5.x
2. 因为Netty5出现重大bug,已经被官网废弃了，目前推荐使用的是Netty4.x的稳定版本
3. 目前在官网可下载的版本是netty3.x,netty4.x和netty4.1.x

# Netty高性能架构设计
## 线程模型基本介绍
1. 不同的线程模式对程序的性能有很大影响，为了搞清Netty线程模式，我们来系统讲解下各个线程模式，最后看Netty线程模型有什么优越性
2. 目前存在的线程模型有：
   **传统阻塞I/O服务模型**
   **Reactor模式**
3. 根据Reactor的数量和处理资源池线程数量不同， 有三种典型的实现
- 单Reactor单线程
- 单Reactor多线程
- 主从Reactor多线程
4. Netty线程模式(Netty主要基于主从Reactor多线程模型做了一定的改进，其中主从Reactor多线程模型有多个Reactor)

## 传统阻塞IO服务模型
模型特点：
1. 采用阻塞IO模式获取输入的数据
2. 每个连接都需要独立的线程完成数据的输入,业务处理,数据返回
问题分析
1. 当并发数很大，就会创建大量的线程，占用很大的系统资源
2. 连接创建后，如果当前线程暂时没有数据可读，该线程会阻塞在read操作，造成线程资源浪费

## Reactor模式
针对传统阻塞I/O服务模型的2个缺点，解决方案:
1. 基于I/O复用模型: 多个连接共有一个阻塞对象，应用程序只需要在一个阻塞对象等待，无需阻塞等待所有连接。当某个连接有新的数据可以处理时，操作系统通知应用程序，线程从阻塞状态返回，开始进行业务处理
   Reactor对应叫法: 
   1. 反应器模式
   2. 分发者模式
   3. 通知者模式
2. 基于线程池复用线程资源: 不必再为每个连接创建线程，将连接完成后的业务处理任务分配给线程进行处理，一个线程可以处理多个连接的业务

说明:
1. Reactor模式，通过一个或多个输入同时传递给服务处理器的模式(基于事件)
2. 服务器程序处理传入的多个请求, 并将它们同步分派到相应的处理线程, 因此Reactor模式也叫Dispatcher模式
3. Reactor模式使用IO复用监听事件，收到事件后，分发给某个线程(进程),这点就是网络服务高并发处理关键

- Reactor模式
## Reactor模式中核心组成
1. Reactor: Reactor在一个单独的线程中运行，允许监听和分发事件，分发给适当的处理程序来对IO事件作出反应。它就像公司的电话接线员，它接听来自客户的电话并将线路转移到适当的联系人
2. Handlers: 处理程序执行I/O事件要完成的实际事件，类似客户想要与之交谈的公司中的实际官员。Reactor通过调度适当的处理程序来相应I/O事件，处理程序执行非阻塞操作

## 单Reactor单线程模式
方案说明
1. Select是前面I/O复用模型介绍的标准网络编程API,可以实现应用程序通过一个阻塞对象监听多路连接请求
2. Reactor对象通过监控客户端请求事件，收到事件后通过Dispath进行分发
3. 如果是建立连接请求事件，则由Acceptor通过Accept处理连接请求，然后创建一个Handler对象处理连接完成后的后续业务处理
4. 如果不是建立连接事件，则Reactor会分发调用连接对应的Handler来响应
5. Handler会完成Read->业务处理->send的完整业务流程

结合实例：服务器端调用了一个线程通过多路复用搞点所有的IO操作(包括连接，读写等)，编码简单，清晰明了，但是如果客户端连接数量较多，将无法支持，前面的NIO案例就属于这种模型

方案优缺点分析
1. 优点: 模型简单，没有多线程，进程通信，竞争的问题，全部都在一个线程中完成
2. 缺点: 性能问题，只有一个线程，无法完全发挥多核CPU的性能。Handler在处理某个连接上的业务时，整个进程无法处理其他连接事件，很容易导致性能瓶颈
3. 缺点: 可靠性问题，线程意外终止，或者进入死循环，会导致整个系统通信模块不可用，不能接收和处理外部信息，造成节点故障
4. 使用场景，客户端数量有限，业务处理非常快速，比如Redis在业务处理的时间复杂度O(1)的情况

## 单Reactor多线程
方案说明
1. Reactor对象通过select监控客户端请求时间，收到事件后，通过dispatcher进行分发
2. 如果建立连接请求，则由Acceptor通过accept处理连接请求，然后创建一个Handler对象处理完成连接后的各种事件
3. 如果不是连接请求，则由reactor分发调用连接对应的handler来处理
4. handler只负责响应事件，不做具体的业务处理，通过read读取数据后，会分发给后面的worker线程池的某个线程处理业务
5. worker线程会分配一个独立的线程完成真正的业务，并将结果返回给Handler
6. handler收到响应后，通过send将结果返回给client

方案优缺点分析
1. 优点: 可以充分利用多核cpu的处理能力
2. 缺点： 多线程数据共享和访问比较复杂，Reactor处理所有的事件的监听和响应，在单线程运行，在高并发场景容易进入性能瓶颈

## 主从Reactor多线程
针对单Reactor多线程模型中，Reactor在单线程中运行，高并发场景下容易变成性能瓶颈，额可以让Reactor在多线程中运行

方案说明
1. Reactor主线程MainReactor对象通过select监听连接事件，收到事件后，通过Acceptor处理连接事件
2. 当Acceptor处理连接事件后，MainReactor将连接分配给SubReactor
3. subReactor将连接加入到连接队列进行监听，并创建handler进行各种事件处理
4. 当有新事件发生时，subreactor就会调用对应的handler进行处理
5. handler通过read读取数据，分发给后面的worker线程处理
6. worker线程池分配独立的worker线程进行业务处理，并返回结果
7. handler收到响应的结果后，再通过send返回给client
8. Reactor主线程可以对应多个reactor子线程，即MainReactor可以关联多核SubReactor

方案优缺点说明：
1. 优点: 父线程与子线程数据交互简单，职责明确，父线程只需要接受新连接，子线程完成后续的业务处理
2. 优点：父线程与子线程的数据交互简单，Reactor主线程只需要把新连接传给子线程，子线程无需返回数据
3. 缺点：编程复杂度较高

结合实例：这种模型在许多项目中广泛使用，包括Nginx主从Reactor多进程模型，Mencahched主从多线程，Netty主从多线程模型的支持

3种模式用生活案例来理解
1. 单Reactor单线程，前台接待员和服务员是同一个人，全程为顾客服务
2. 单Reactor多线程，1个前台接待员，多个服务员，接待员只负责接待
3. 主从Reactor多线程，多个前台接待员，多个服务生

Reactor模式具有如下的优点
1. 响应快，不必为单个同步时间所阻塞，虽然Reactor本身依然是同步的
2. 可以最大程度的避免复杂度多线程及同步问题，并且避免了多线程/进程的切换开销
3. 扩展性好，可以方便的通过增加Reactor实例个数来充分利用CPU资源
4. 复用性好，Reactor模型本身与具体事件处理无关，具有很高的复用性
