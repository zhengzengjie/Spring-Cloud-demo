# Spring-Cloud-demo 2018-04-10 by zhengzengjie
#### eureka-server:服务注册发现中心
#### config-server:配置中心
#### service-demo:微服务demo,从配置中心读取数据,通过feign访问service-demo-1的接口
#### service-demo-1:微服务demo1,从配置中心读取数据
#### zuul:网关,路由策略为/demo/*的访问service-demo，/demo1/*的访问service-demo-1
#### client:客户端，通过zuul访问service-demo和service-demo-1的服务
#### zipkin-server:服务调用追踪器,包含service-demo/service-demo-1/zuul/client之间的调用关系链及调用次数及时长等信息
