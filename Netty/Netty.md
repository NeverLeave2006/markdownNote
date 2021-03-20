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
