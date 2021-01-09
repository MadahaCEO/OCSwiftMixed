//
//  DetailViewModel.swift
//  Book
//
//  Created by Apple on 2021/1/9.
//  Copyright © 2021 马大哈. All rights reserved.
//
/*
 Swift 的静态语言特性，每个函数的调用在编译期间就可以确定，运行时便不再需要经过一次查找，而可以直接使用,
       编译完成后可以检测出没有被调用到的 swift 函数，优化删除后可以减小最后二进制文件的大小。
 OC    中调用函数是在运行时通过发送消息调用的。所以在编译期并不确定这个函数是否被调用到。
 
 Objective-C中所有的类都继承自NSObjc，在Swift中的类需要供Objective-C调用的时候，也必须显式的继承NSObject。
 当然，随便继承一个OC中的类都可以，反正他们都继承自NSObject。
 */

import UIKit


 
@objc public protocol DetailViewModelDelegate {
    
    // 默认required 必须实现
    @objc func detailInfo()
    // 可选实现，回调带参数
    @objc optional func author(_ name: String) -> Void
    // 回调带参数还要返回值
    @objc func age(_ age: Int) -> Int

}


/*
 @objc 关键字
 1.相关的参量只能修饰类、类的成员(方法、属性等)、扩展以及只能被类实现的协议；
 2.主要是为了能够让OC调用；
 
 open：修饰的类可以在本某块(sdk),或者其他引入本模块的(sdk,module)继承，
       如果是修饰属性的话可以被此模块或引入了此某块(sdk)的模块（sdk）所重写

 public：修饰的类用public(或级别更加等级更低的约束(如private等))修饰后只能在本模块（sdk）中被继承，
        如果public是修饰属性的话也是只能够被这个module(sdk)中的子类重写

 internal：是在模块内部可以访问，在模块外部不可以访问，a belong A , B import A, A 可以访问 a, B 不可以访问a.
           比如你写了一个sdk。那么这个sdk中有些东西你是不希望外界去访问他，这时候你就需要internal这个关键字（默认也是internal）

 fileprivate： 这个修饰跟名字的含义很像，file private 就是文件之间是private的关系，也就是在同一个source文件中还是可以访问的，
               但是在其他文件中就不可以访问了 a belong to file A, a not belong to file B ,
               在 file A 中 可以访问 a，在 file B不可以访问a

 private： 这个修饰约束性比fileprivate的约束性更大，private 作用于某个类，
           也就是说，对于 class A ,如果属性a是private的，那么除了A外其他地方都不能访问了
            (fileprivate 和private都是一种对某个类的限制性约束。fileprivate的适用场景可以是某个文件下的extension，
            如果你的类中的变量定义成了private那么这个变量在你这个类在这个类的文件的拓展中就无法访问了，
            这时就需要定义为fileprivate)
 */
@objc public class DetailViewModel: NSObject {

    @objc public var name:String = ""
    
    @objc public var delegate : DetailViewModelDelegate?

        
    @objc public func instanceMethod() {
        print("OC 调用 Swift 实例方法")
    }
    
    @objc public class func classMethod() {
        print("OC 调用 Swift 类方法")
    }
    
    
    @objc public func instanceMethod1(name:String) {
        print("OC 调用 Swift 实例方法,带参数 \(name)")
    }
    
    
    @objc public func instanceMethod2(name:String, age:Int, isTeacher:Bool) {
        print("OC 调用 Swift 实例方法,带参数  name:\(name)   年龄\(age)   是否老师\(isTeacher)")
    }
    
    @objc public func sum (first:Int, second:Int) -> Int {
        print("OC 调用 Swift 实例方法,带参数  first:\(first)   second\(second) 求和, 并返回结果")
        return first + second;
    }
    


    
    /*
     以下划线  _  开头，OC 调用时 [vm instanceMethod3:@"参数1" closure:nil]
     
     如果没有下划线，OC 调用时 [vm instanceMethod3WithParam1:@"参数1" closure:nil]
     */
    @objc public func instanceMethod3(_ param1: String, closure: (() -> Void)? = nil) {
       
        if closure != nil {
            closure!()
        }
    }
    
    @objc public func instanceMethod4(_ closure: ((_ name: String, _ age: Int) -> Void)? = nil) {
        
        if closure != nil {
            closure!("name", 3)
        }
    }
    
    
    var callback: (()->Void)?

    @objc public func instanceMethod5(_ closure: (() -> Void)? = nil) {
        callback = closure;
    }
    
    @objc public func instanceMethod6() {

        if callback != nil {
            callback!()
        }
    }
    
    
    @objc public func instanceMethod7() {
        print("OC 调用 Swift 实例方法, 验证回调")

        if self.delegate != nil {
            
            self.delegate?.detailInfo()
            
            self.delegate?.author?("作者名称")
            
            let total = self.delegate?.age(5)
            print("回调参数，得到返回值  " , total!)
        }
    }
 
}
