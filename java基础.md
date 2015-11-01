---
title: java相关知识记录
tags: java基础 开源框架 数据库 jvm相关 设计模式
---

 


 ## java基础 ##
 

 - **封装、继承、多态**
 

 
 1.封装
封装就是把过程和数据包围起来，对数据的访问只能通过已经定义的公开的接口，封装是一种信息隐藏技术，用户无需知道内部具体实现，只需要调用对象对外提供的接口就可以访问该对象数据。在java中使用设置访问权限来控制来实现封装。通过封装可以控制用户对类的修改和数据访问程度。
2.继承
继承就是个性对共性的属性与方法的接受，并加入个性的属性方法的实现。如果一个类继承另一个类，继承的那个类就叫子类，被继承的就是父类。子类继承父类就拥有了父类的所有方法和属性（私有的属性和构造方法不可继承），子类可以在此基础上实现更精确的功能。
3.多态
多态就是一种行为可以有多种形态，多态是基于抽象的基础上的，也就是一相同的行为，比如跑，人是两只脚跑步，而有些动物是四条腿跑。这就是一种多态，一种行为多种形态，多态通过抽象和接口来实现。


 - **抽象和接口的区别**
 


 1.抽象（abstract）当我们发现不同的类有共同的方法，我们会将它们向上抽取出来，但是因为多态，相同的行为可以有多种形态，我们并不能直接写出具体的实现，那么现在我们就可以给该类当作抽象类，不能确定具体实现的方法叫抽象方法，在方法加上abstract关键字。抽象类也需要abstract关键字，抽象类里面也可以定义具体实现方法，和全局变量。其他类通过继承的方式来实现具体方法。
 2.接口（interface）interface可以看成是一个特殊的抽象类，在interface里面定义的都是抽象方法，而没有具体实现，并且在interface里面不可以定义全局变量，就算是定义了也会在编译的时候自动加上static final 关键字。其他类通过实现（implements）来实现interface，一个类可以实现多个接口，一个接口也可以继承多个接口，从某种意义上行弥补了类不能多继承的缺陷。
 
 - **object中equals方法和hashcode方法**
 在java中要比较两个对象是否相同需要equals方法和hashcode方法配合使用，通过hashcode方法判断为true的两个对象不一定相同必须再通过equals方法判断相同才可以。并且通过自定义的对象需要重写equals方法和hashcode方法。
 
 - **java中序列化和反序列化**
 
 java中把对象转换为字节序列的过程称为对象的序列化。
 把字节序列恢复为对象的过程称为对象的反序列化。
 java序列化的两个作用：
 1.需要将对象保存到物理硬盘中
 2.需要将对象在网络上远程传输 
java中要想将对象序列化必须实现seralizable接口，并且可以通过java.io.objectOutputstream的objectWrite(Object obj)方法将序列化，通过java.io.objectInputStream的objectRead(object obj)方法将字节序列反序列化成对象。
 - **java中sleep()和wait()方法的区别**
 1.sleep()方法是thread类的方法，并且是一个静态方法，所以调用的时候需要通过类名调用。执行sleep方法会导致当前线程暂停一定时间，将执行机会让给其他线程，时间到就继续执行，但是在暂停过程中一直处于监控状态，并不会放弃对象锁。
 2.wait()方法是object类的方法，当对某线程调用wait方法，当前线程放弃对象锁，进入等待池，只有通过notify方法或者notifyAll方法才能唤醒当前线程重新去获取对象锁来获取执行权。
 - **集合框架**
 1.arrayList
arrayList继承abstractList实现list接口，内部使用对象数组的数据结构。因为使用数组，所以开辟的是一片连续的内存空间，所以查找快，而插入删除慢（因为插入删除涉及元素的移动）。arrayList允许元素为空，并且允许元素重复，arrayList并不是线程安全的，如果对线程安全要求很高可以使用vector，arrayList初始大小是10，当元素大于10时，arrayList会自动扩容，扩容机制是在原来的基础上增加50%（newcapacity=oldcapacity+oldcapacity<<1）。如果说能初步确定需要的大概容量直接通过ensurecapacity方法来一次性扩容，可以避免多次扩容提高性能。
 2.linkedList
linkedList内部使用双向链表，因为使用链表嘛，内存空间只需要逻辑连续而不需要物理连续，所以插入删除快，然而查找速度却不如arrayList。
 3.hashmap
hashmap使用键值对的形式存取元素，hashmap内部使用hash表的数据结构，hashmap是线程不安全的，并且hashmap允许元素为空，有两个因素会影响hashmap的性能，一个是初始容量initial capacity，默认的初始容量是16，另一个就是装载因子，装载因子是衡量hashmap能装多满的度量，如果存储的元素个数大于初始容量乘以装载因子时就自动扩容，扩容机制是将当前容量扩大一倍（oldcapacity*2），hashmap通过put（k，v）来保存元素，通过get(k)来获取元素，当调用put方法时，首先通过key来获取hash值，找到对应的bucket，接着看当前是否已经有元素，接着通过equals方法判断是否为相同的元素，有元素就说明发生冲突，因为hahsmap处理冲突的方法是链地址法，在该bucket上使用链表，将元素插入到链表上。当调用get方法时，首先通过计算key的hash值，找到相应的bucket，同时再通过equals方法来找到对应的元素。值得注意的是hashmap无论是初始容量还是自定义容量，都是2的n次方（不是的直接设定成最接近你定义的那个数的2的n次方），这么做是有原因的，因为在为元素分配位置时也就是indexfor方法（h&length-1）这样计算保证了计算的索引值都在length范围内。
 4.hashtable
hashtable内部也是使用hash表的数据结构，与hashmap非常相似，仅有hashtable是线程安全的并且不允许元素为空，还有hashtable的初始容量为11，并且计算key的hash值的方法不同，hashmap是计算hashcode之后再进行一系列的移位运算，而hashtable直接返回hashcode。还有一点不同的是hahstable继承dictionary。

 

 - **反射机制**
 在运行状态下，对任意的一个类，都能知道该类的任意方法和属性，对任意一个类都能动态构造该类的对象并调用该对象的方法和属性。这种动态获取类的信息的方式称为java的反射机制。
反射机制提供以下功能：
1.获取该对象的所属的类。
2.获取该类的field。
3.获取该类的构造方法。
4.获取该类的method。
5.获取类并动态生成实例对象。

 

 - String，stringbuffer，stringbuild
 

 -**开源框架**

  1.struts2：
首先我们在web.xml中配置struts的strutsprepareandexcuteFilter，当我们启动程序的时候就会完成dispachter的初始化、actionMapper的初始化和configurationManager的初始化，当我们客户端发出request请求时，strutsprepareandexcuteFilter根据我们配置的策略来拦截请求（一般是拦截所有），接着将请求封装并且与actionMapper相匹配（通过请求找到相应的actionMapper），如果没有找到对应的actionMapper，那么返回路径找不到异常，如果actionmapper存在，那么控制权就交到了actionproxy手里，actionproxy是通过actionmapper的各种信息来动态生成的action代理类，这里使用了动态代理，其主要功能由actioninvocationHandler完成，在这里会通过configurationManager查找struts配置文件找到我们要调用的action和要调用的方法，同时将action交给actionproxy代理，在执行action的前后我们还可以调用多个拦截器，在struts2中管这个叫拦截器栈，因为拦截器都是按顺序执行，而action处于相当于栈底的位置，执行顺序自上到下，再按逆序返回。在执行完action之后struts2会根据你在配置文件中配置的result返回对应的视图，这样一个请求就处理结束。

 2.springMVC：
 springMVC和struts2同样是优秀的MVC框架，专注于表示层上的工作，首先我们同样在web.xml中定义好对应的拦截策略，当我们的httprequest到达springMVC时，dispachterservlet（**须深入**）查询handlerMapping，我们可以给dispachterservlet提供多个handlerMapping，比如simpleURLhandlermapping和defaultannotionhandlermapping，dispachterservlet通过handlermapping的优先级来先后调用，直到返回相应的handler，这个handler通常是我们在spring中注册的bean对象，通过返回的handler我们定位到的是controller类，而要定位到具体的方法还需要handleradapter，handleradapter通过请求的url和method定义（post、get），requestMapping的定义来最终找到controller类中的具体方法。接着在执行完方法之后返回modelandview（**需要深入了解**），最后通过视图解析器解析modelandview返回对应的视图。
 2.1springMVC和struts2的区别
 1.struts2使用strutsprepareandexcuteFilter使用的是过滤器而springMVC使用的是dispachterservlet。
 2.springmvc按分
 
 
 
 3.spring：
 springIOC：springIOC是spring中核心技术之一，它是将创建对象实例的任务交给第三方容器而并不是传统的通过调用者来创建，这样控制权从调用者转移到spring容器，所以叫控制反转。spring控制反转的过程大致是扫描要注册的bean，通过beandefinitionreader载入bean，将bean注册到ioc容器，注入实例。
 springAOP：aop全称叫面向切面编程，他是一种编程思想，是对面向对象的一个有力补充，面向对象编程定义的是一种从上到下的关系，而面向切面则是更关注于不同类，不同业务之间的共性东西归纳到一起并使之模块化。spring中有两种方法支持aop，一种是通过jdk动态代理，另一种是cglib子类增强。两种的区别是创建代理对象的方式不同，jdk动态代理是通过传入要代理的对象实现的接口，而cglib是为代理对象创建一个子类直接重写子类的方法达到目的，所以使用cglib代理的对象不可以是final修饰的。
 
 4.hibernate
 1.hibernate工作原理：
 通过configuration解析hibernate.cfg.xml文件，通过文件配置的mapping信息找到对应的实体映射规则，创建sessionfactory对象，sessionfactory是一个session工厂，负责session的创建与关闭，通过sessionfactory打开session，通过session开启事务并且通过session来执行crud操作，事务提交后关闭事务。
 2.hibernate懒加载：
 hibernate懒加载是通过cglib动态代理实现的，所以要通过hibernate来操作的实体类不能被final修饰，当设置加载方式是懒加载时，hibernate调用load方法，先通过动态代理生成一个代理对象，除了主键，其他所有属性都是空的，在这时并没有查询数据库，只有当我们真正要用该对象数据时，代理对象才会查询数据库并封装数据进代理对象。
 3.hibernate的get和load区别
  1.get如果没有找到数据返回null而load则抛出objectcouldnotfound异常
  2.通过get查询数据先查缓存，如果缓存找不到再直接查数据库，而load是先生成代理对象，先不查询数据库，等真正要用数据时再查询数据库。
 4.hibernate缓存机制
 hibernate使用二级缓存机制，分为一级缓存，和二级缓存。一级缓存也叫session缓存，生命周期和session相同，每个session都有自己的一件缓存，hibernate的一级缓存是自带的不能卸除。而二级缓存也叫sessionfactory缓存，生命周期与sessionfactory相同，sessionfactory缓存被应用范围所有session所共享。hibernate默认二级缓存为false，需要通过设置支持二级缓存。
 当在查询数据时，首先查询一级缓存，如果一级缓存查不到，如果配置了二级缓存，那么继续查询二级缓存，如果二级缓存还没找到，那么就会去数据库查找。
 什么数据适合放入缓存中：
 1.数据经常访问，并且比较少的修改。
 2.不会被高并发访问的数据。