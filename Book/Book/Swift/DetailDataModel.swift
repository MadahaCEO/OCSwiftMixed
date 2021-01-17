//
//  DetailDataModel.swift
//  Book
//
//  Created by Apple on 2021/1/9.
//  Copyright © 2021 马大哈. All rights reserved.
//

import UIKit

@objcMembers public class DetailDataModel: NSObject {
    
    public let name: String
    public let pageCount: Int
    public let type: String

    public let all: NSAttributedString
    
    public init(book dictionary: Dictionary<String, AnyObject>) {
       
        self.name = dictionary["name"] as! String
        self.pageCount = dictionary["pageCount"] as! Int
        self.type = dictionary["type"] as! String

        let temp = self.name.appending(self.type)
        let att = [NSAttributedString.Key.backgroundColor : UIColor.red,
                   NSAttributedString.Key.font:UIFont.systemFont(ofSize: 13.5)]
        self.all = NSAttributedString.init(string: temp,attributes:att)
       
        super.init()
        

    }
}
