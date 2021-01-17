# OCSwiftMixed
OC Swifht MixedDevelop

https://blog.csdn.net/u014600626/article/details/107596566

一、ABl是什么   
每个操作系统都会为运行在该系统下的应用程序提供应用程序二进制接口（Application Binary Interface，即ABI）, 描述了应用程序和操作系统之间的底层接口，一个应用和它的库之间的底层接口。与API不同的是：ABI允许编译好的目标代码在使用兼容ABI的系统中无需改动就能运行，而API则是定义 源代码 和 库 之间的接口，同样的代码可以在支持这个API的任何系统中编译。

ABI包含了应用程序在这个系统下运行时必须遵守的编程约定。ABI总是包含一系列的系统调用和使用这些系统调用的方法，以及关于程序可以使用的内存地址和使用机器寄存器的规定。从一个应用程序的角度看，ABI既是系统架构的一部分也是硬件体系结构的重点，因此只要违反二者之一的条件约束就会导致程序出现严重错误。

在 iOS 和 macOS 平台，Swift编写的二进制程序在运行时通过ABI与其他程序库或组件进行交互。程序的编译会产生一个或者多个二进制实体，这些二进制实体必须在一些很底层的细节上达成一致，才能被链接在一起执行。可以说ABI就是一个规范，一种协议。它会规定如何调用函数，如何在内存中表示数据，甚至是如何存储和访问metadata。ABI底层包装的是具体平台硬件相关的程序代码了。

ABI稳不稳定与Swift版本是无关的，取决于swift的编译器版本。Xcode10.2集成了swift5.0编译器，只要使用这个版本以上的编译器，编译出来的二进制就是ABI稳定的。Swift5.0编译器提供了Swift4的语法兼容，也就是说即使你的项目代码仍然是swift4，编译出来的二进制也是ABI稳定的。


二、ABI稳定的利弊  

ABI稳定之后，OS发行商就可以把Swift标准库和运行时作为操作系统的一部分嵌入。也就是说Apple 会把Swift runtime 放到 iOS 和 macOS 系统里，我们的swift App包里就不需要包含应用使用的标准库 和Swift runtime 拷贝了。同时在运行的时候，只要是用 Swift 5 (或以上) 的编译器编译出来的 binary，就可以跑在任意的 Swift 5 (或以上) 的 runtime 上。

Apple 通过 App Thinning 帮我们完成的，不需要开发者操心。在提交 app 时，Apple 将会按照 iOS 系统创建不同的下载包。对于 iOS 12.2 的系统，因为它们预装了 Swift 5 的 runtime，所以不再需要 Swift 的库，它们会被从 app bundle 中删掉。对于 iOS 12.2 以下的系统，外甥打灯笼，照旧。（Always Embed Swift Standard Libraries 选择YES）


动态库 Framework 内 Swift调用OC源码
参考：http://www.cocoachina.com/articles/19022
无需将 OC 类公开出去，而是通过module的形式引用

新建一个 module.modulemap ，简单粗暴一点 
1.直接copy 动态库编译后生成的modulemap文件，在里面动动手脚编程自己的；
2.新建一个swift文件然后把后缀改成modelemap,然后编辑此文件即可;
反正是条条大路通罗马

/* 可以与动态库编译后的modulemap文件对比*/
 
这个是动态库编译后自动生成的
~
framework module Book {
  umbrella header "Book.h"

  export *
  module * { export * }
}

module Book.Swift {
    header "Book-Swift.h"
    requires objc
}
~

这个是自己建的
~
module MDH {
  // !!!!!! 特别注意 !!!!!! 自己创建这个modulemap文件中 声明的头文件路径必须准确
  // 要么，modulemap文件与声明的头文件在同一个文件夹目录下
  // 要么，不在同一目录下，就需要指定头文件路径（开发过程中很多这种场景）
  header "ThirdViewController.h"

  export *
}
~

准备工作完成后，那么就可以直接在swift中引用了吗？这个时候需要记住，新建的这个modulemap属于外来的，要让编译器知道他，并找到他，故 需要设置 【Build Settings】 -> 【Swift Compiler-Search Paths】->【Import Path】

最后，编译一下，在swift类中引入 import MDH ，就可以直接调用 ThirdViewController 类了。
