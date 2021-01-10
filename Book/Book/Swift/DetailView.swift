//
//  DetailView.swift
//  Book
//
//  Created by Apple on 2021/1/9.
//  Copyright © 2021 马大哈. All rights reserved.
//

import UIKit
import Masonry

@objc public class DetailView: UIView {

    var displayTextView:UITextView? = nil

    
    public override init(frame: CGRect) {
        super.init(frame:frame)
        
        displayTextView = UITextView()
        displayTextView!.textColor = UIColor(white: 0.143, alpha: 1.0)
        displayTextView!.backgroundColor = UIColor.yellow
        displayTextView!.font = UIFont.systemFont(ofSize: 15)
        displayTextView!.text = "fsdkbfwbfsdanbkjvbdaksjbvsdabv"
        self.addSubview(displayTextView!)
        displayTextView!.mas_makeConstraints({ make in
            make?.top.left()?.right().equalTo()(self)
            make?.height.equalTo()(80)
        })
        
    }
    
//    convenience init(frame: CGRect) {
//        self.init(frame: frame)
//
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
