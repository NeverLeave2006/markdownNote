# 过滤器
## 作用
过滤器就是在请求传递过程中，对请求和响应做一些手脚
## 生命周期
pre:
在请求被路由之前被调用。我们可利用这种过滤器实现身份验证，在集群中选择请求的微服务，记录调试信息等
post
这种过滤器在路由到微服务以后执行。这种过滤器可用用来作为响应添加标准的HTTP Header、收集统计信息和指标，将响应从微服务发送给客户端等
## 分类
局部过滤器:作用在某个路由上
4.6.1: 内置局部过滤器
|过滤器工厂|作用|参数|
|---|---|---|
|AddRequestHeader|为原始请求添加Header|Header名称及值|
|AddRequestParameter|为原始请求添加请求参数|参数名称及值|
|AddResponseHeader|为原始响应添加Header|参数名称及值|
|DedupeResponseHeader|剔除响应头中重复的值|需要去重的Header名称及其去重策略|
|Hystrix|为路由引入Hystrix的断路器保护|Header的名称|
|FallbackHeaders|为fallbackUrl的请求头中添加具体的异常信息|Header的名称|
|PrefixPath|为原始请求路径添加前缀|前缀路径|
|PreserverHostHeader|为请求添加一个preserveHostHeader=true的1属性，路由过滤器会检查该属性以决定是否要发送原始的Host|无|
|RequestRateLimiter|用于对请求限流，限流算法为令牌桶|keyResolver,rateLimiter,statusCode,denyEmptyKey,emptyKeyStatus|
|RedirectTo|将原始请求重定向到指定的URL|http状态码及重定向的url|
|RemoveHopByHopHeadersFilter|为原始请求删除IETF组织规定的一系列Header|默认就会启用，可用通过配置指定仅删除那些Header|
|RemoveRequestHeader|为原始请求删除某个Header|Header名称|
|RemoveResponseHeader|为原始1响应删除某个Header|Header名称|
|RewritePath|重写原始的请求路径|原始请求路径的正则表达式及重写后路径的正则表达式|
|RewriteResponseHeader|重写原始响应中的某个Header|Header名称，值的正则表达式，重写后的值|
|saveSession|在转发请求前强制执行WebSession::save操作|无|
|secureHeaders|为原始响应添加一系列起安全作用的响应头|无,支持修改这些安全响应头的值|
|SetPath|修改原始的请求路径|修改后的路径|
|SetResponseHeader|修改原始响应中某个Headerd的值|Header名称，修改后的值|
|SetStatus|修改原始响应的状态码|HTTP状态码，可以是数字，也可以是字符串|
|StripPrefix|用于截断原始请求的路径|使用数字表示要阶段的路径的数量|
|Retry|针对不同的响应进行重试|retries,statuses,methods,series|
|RequeueSize|设置允许接受最大请求包的大小。如果请求包大小超过设置的值，则返回413 Payload Too Large|请求包大小，单位为字节，默认值为5M|
|ModifyRequestBody|转发请求之前修改原始请求体内容|修改后的请求体内容|
|ModifyResponseBody|修改原始响应体的内容|修改后的响应体内容|

全局路由器:作用在全部路由上