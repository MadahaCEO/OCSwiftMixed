//
//  ConverToPinyin.swift
//  Book
//
//  Created by Apple on 2021/1/21.
//  Copyright © 2021 马大哈. All rights reserved.
//

import UIKit
import MDH

class ConverToPinyin: NSObject {

    static let sharedInstance = ConverToPinyin();
    
    var pyManager:MDHChinesePinyinManager
    
    
    private override init() {

        pyManager = MDHChinesePinyinManager.init()
        
        super.init()

    }
    
    func object(_ name:String) -> (fullPinyin:String, regularPinyin:String) {
        
        let arr = pyManager.toPinyin(name) as! [String]
        let str = arr.joined(separator: ",").replacingOccurrences(of: " ", with: "")

        
//        for i in array1 {
//            let string:String = i as! String
////            string.components(separatedBy: " ")
//            nameArr.append(string.replacingOccurrences(of: " ", with: ""))
//        }
        
//        let nameLongString = nameArr.joined(separator: ",")
        
//        let array2:Array = pyManager.firstLetters(name)

        return (str,"ppp")
    }
    
    //    MDHChinesePinyinManager *manager = [[MDHChinesePinyinManager alloc] init];
    //       NSArray *array =  [manager firstLetters:@"行"];
    //    MDHChinesePinyinManager *manager = [[MDHChinesePinyinManager alloc] init];
    //       NSArray *array =  [manager toPinyin:@"李长行"];
        
}
