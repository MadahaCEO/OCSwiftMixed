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
        self.all = NSAttributedString.init(string: temp, attributes: [NSAttributedString.Key.backgroundColor : UIColor.red, NSAttributedString.Key.font:UIFont.systemFont(ofSize: 13.5)])
       
        super.init()
        

    }
    
//    override public init() {
//        super.init()
//    }
//
//    convenience init(dictionary: Dictionary<String, AnyObject>) {
//        self.init()
//
//        //           self.message = message
//        //
//        //           bubbleImageView = UIImageView()
//        //           self.addSubview(bubbleImageView!)
//        //
//        //           displayTextView = UITextView()
//        //           displayTextView!.textColor = UIColor(white: 0.143, alpha: 1.0)
//        //           displayTextView!.backgroundColor = UIColor.clearColor()
//        //           displayTextView!.selectable = false
//        //           displayTextView!.font = UIFont.systemFontOfSize(12)
//        //           self.addSubview(displayTextView!)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    //    override init(name: String, age: Int) {
    ////        self.score = 40
    //        super.init(name: name, age: age)
    //    }
    //    func init() {
    //        super.init()
    //    }
}
