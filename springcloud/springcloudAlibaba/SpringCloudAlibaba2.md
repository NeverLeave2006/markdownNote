# 服务雪崩效应
在分布式系统中，由于网络原因或者自身的原因，服务一般无法保证100%可用。如果一个服务出现了问题，调用这个服务就会出现线程阻塞的情况，此时若有大量的请求涌入，就会出现多条线程阻塞等待，进而导致服务瘫痪。

# 网关
## 网关原理
1. GateWayClient向GateWay Server发送请求
2. 请求会被HttpWebHandlerAdapter进行提取组装成网关上下文
3. 然后网关的上下文传递到DispatcherHandler,它负责将请求转发给RouterPredicateHandlerMapping
4. RouterPredicateHandlerMapping负责路由查找，并根据路由断言路由是否可用
5. 如果断言成功，由FilteringWebHandlere创建过滤器链并调用
6. 请求会一次经过PreFilter-微服务-PosterFilter方法，最终返回响应

## 断言
Predicate(断言)用于进行条件判断，只有断言都返回真，才会执行真正的执行路由
### 内置路由断言工厂
SpringCloud GateWay包括很多内置的断言工厂，所有这些断言都与HTTP请求的不同属性匹配，具体如下：
- 基于DateTime类的断言工厂
  此类型根据时间做判断，主要有个:
  AfterRoutePredicateFactory:  接受一个日期