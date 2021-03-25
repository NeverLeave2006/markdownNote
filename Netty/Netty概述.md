# Netty模型
Netty主要基于主从Reactor多线程模型做了一定的改进，其中主从Reactor多线程模型有多个Reactor
1. BossGroup维护Selector只关心accept事件
2. 当接收到Accept事件，获取到对应的SocketChannel，封装成NIOSocket
   注册到Worker线程(事件循环)，并进行维护
3. 当Worker线程监听到selector中的通道发生自己兴趣的事件后，就进行处理(就由handler),注意handler已经加入到通道中

工作原理
1. Netty抽象出两组线程池BossGroup,WorkGroup
2. BossGroup和WorkerGroup类型都是NioEventLoopGroup
3. NioEventLoopGroup相当于一个事件循环组，这个组中含有多个事件循环，每一个事件循环是NioEventLoop
4. NioEventLoop表示一个不断循环的执行处理任务的线程，每个NioEventLoop都有一个Selector，用于监听绑定在其上的socket网络通讯
5. NioEventLoop可以有多个线程，即可以含有多个NioEventLoop
6. 每个Boss NioEventLoop执行的步骤有散步
   1. 轮询accept事件
   2. 处理accept事件，与client建立连接，生成NioSocketChannel,并将其注册到某个worker NIOEventLoop上的selector
   3. 处理任务队列的任务，即runAllTasks
7. 每个Worker NIOEventLoop循环执行的步骤
   1. 轮询read,write事件
   2. 处理I/O事件，即read,write事件，在对应的NioSocketChannel上处理
   3. 处理任务队列的任务，即runAllTasks
8. 每个Worker NIOEventLoop处理业务时，会使用pipeline(管道)，pipeline中包含了channel,即通过pipeline可以获取到对应的通道，管道中维护了很多的处理器

# Netty模型
任务队列中Task有3种典型的使用场景
1. 用户程序自定义的普通任务
2. 用户自定义定时任务
3. 非当前Reactor线程调用Channel的各种方法
   例如在啊推送系统的业务线程里面，更具用户标识，找到对应的Channel应用，然后调用Write类方法向该用户推送消息，就会进入到这种场景。最终的Write会提交到任务队列中后被异步消费

