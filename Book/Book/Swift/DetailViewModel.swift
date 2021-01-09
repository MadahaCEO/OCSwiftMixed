//
//  DetailViewModel.swift
//  Book
//
//  Created by Apple on 2021/1/9.
//  Copyright © 2021 马大哈. All rights reserved.
//

import UIKit

@objc public class DetailViewModel: NSObject {

    
    @objc public func instanceMethod() {
        print("OC 调用 Swift 实例方法")
    }
    
    @objc public class func classMethod() {
        print("OC 调用 Swift 类方法")

    }
    
}
