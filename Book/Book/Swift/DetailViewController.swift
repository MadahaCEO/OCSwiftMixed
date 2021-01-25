//
//  DetailViewController.swift
//  Book
//
//  Created by Apple on 2021/1/9.
//  Copyright © 2021 马大哈. All rights reserved.
//

import UIKit
import Masonry
import MDH



/*
 参考资料
 https://zhuanlan.zhihu.com/p/94610842?from_voters_page=true
 
 */

@objc public class DetailViewController: UIViewController {

    override public func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Swift Controller"
        self.view.backgroundColor = UIColor.white
        
        

        self.view.addSubview(self.label1)
        self.label1.mas_makeConstraints { (make) in
            make?.top.left()?.right()?.equalTo()(self.view)
            make?.height.equalTo()(40)
        }
        self.label1.text = "用懒加载来避免可选型"
        self.label1.textColor = UIColor.red
        
        
        self.view.addSubview(self.label2)
        self.label2.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.label1.mas_bottom)?.offset()(10)
            make?.left.right()?.equalTo()(self.view)
            make?.height.equalTo()(40)
        }
        
        self.view.addSubview(self.label3)
        self.label3.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.label2.mas_bottom)?.offset()(10)
            make?.left.right()?.equalTo()(self.view)
            make?.height.equalTo()(40)
        }
       
        
        let btn = UIButton.init(type: .custom)
        btn.backgroundColor = .red
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("present swift Controller", for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.addTarget(self, action: #selector(presentSwiftVC), for: .touchUpInside)
        self.view.addSubview(btn)
        btn.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.label3.mas_bottom)?.offset()(10)
            make?.left.right()?.equalTo()(self.view)
            make?.height.equalTo()(40)
        }
        
        let dbBtn = UIButton.init(type: .custom)
        dbBtn.backgroundColor = .red
        dbBtn.setTitleColor(.black, for: .normal)
        dbBtn.setTitle("生成通讯录数据库", for: .normal)
        dbBtn.titleLabel?.textAlignment = .center
        dbBtn.addTarget(self, action: #selector(writeContactsToDB), for: .touchUpInside)
        self.view.addSubview(dbBtn)
        dbBtn.mas_makeConstraints { (make) in
            make?.top.equalTo()(btn.mas_bottom)?.offset()(10)
            make?.left.right()?.equalTo()(self.view)
            make?.height.equalTo()(40)
        }
        
    }
    
    
    @objc func writeContactsToDB() {
        
        let concurrentQueue = DispatchQueue.global()
        concurrentQueue.async {
            
            print("currentThread: \(Thread.current)")

            var pinyinDic:[String:Array<String>] = [:]

            
            let dataPath = NSHomeDirectory() + "/Documents/" + "pinyin"
            let url = NSURL.fileURL(withPath: dataPath)
                    
            let exists = FileManager.default.fileExists(atPath: dataPath)
            if exists {
                
                let data = try! Data.init(contentsOf: url, options: Data.ReadingOptions.uncached)
               
                pinyinDic = try! NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSDictionary.self, NSArray.self] , from: data) as! [String : Array<String>]

//                pinyinDic = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [String : Array<String>]
                
                print("read local pinyin file : \(pinyinDic)")

            } else {
                
                let path = Bundle(for: DetailViewController.self).path(forResource: "MDH_unicode_to_hanyu_pinyin", ofType: "txt")
                
                print("pinyin file path: \(path!)")
                
                var pinyin:String = String()
                
                do {
                    pinyin = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
                } catch {}
                
                
                var pinyinArr:[String] = []
                pinyin.enumerateLines { (line, _) in
                    
                    let tempArr = self.pickPinyin(line)
                    for item in tempArr {
                        if !pinyinArr.contains(item) {
                            pinyinArr.append(item)
                        }
                    }
                }
                
                //            print(pinyinArr)
                
                
                
                for item in pinyinArr {
                    
                    let firstLetter = String(item.prefix(1))
                    
                    if pinyinDic.keys.contains(firstLetter) {
                        var arr = pinyinDic[firstLetter]!
                        if !arr.contains(item) {
                            arr.append(item)
                            pinyinDic[firstLetter] = arr
                        }
                    } else {
                        let filterArr:[String] = []
                        pinyinDic[firstLetter] = filterArr
                    }
                }
                
                //            print(pinyinDic)
                
                do {
                    
                    let pinyinData = try! NSKeyedArchiver.archivedData(withRootObject: pinyinDic, requiringSecureCoding: true)
                    
                    
                    try! pinyinData.write(to: url, options: Data.WritingOptions.atomic)
                    
                } catch {}
                
                
            }

            let contacts = [["刘备","liubei","0l,0liu,1b,1be,1bei"],
                            ["关羽","guanyu","0g,0guan,1y,1yu"],
                            ["张飞","zhangfei","0z,0zhang,1f,1fe,1fei"]]
            
            DataBaseManager.sharedInstance.createTable()
            DataBaseManager.sharedInstance.insertContacts(contacts)
            
        }
    }
    
    
    @objc func pickPinyin(_ string:String) ->Array<String> {
                
        let firstStr = string.components(separatedBy: " ").last!

        let characterSet = CharacterSet(charactersIn: "()")
        let secondStr = firstStr.trimmingCharacters(in: characterSet)

        var thirdStr:String = String()

         do{
            let regex = try NSRegularExpression(pattern: "[0-9]", options: .caseInsensitive)
            thirdStr = regex.stringByReplacingMatches(in: secondStr,
                                 options: [],
                                 range: NSMakeRange(0, secondStr.count),
                                 withTemplate: "")

        }catch { }
                    
        var pinyinArr:[String] = []

        if thirdStr.contains(",") {
            
            let tempArr = thirdStr.components(separatedBy: ",")
            pinyinArr+=tempArr
            
        } else {

            pinyinArr.append(thirdStr)
        }
        
//        print(pinyinArr)
        
        return pinyinArr
    }
    
    @objc func presentSwiftVC() {
        
        let searchVC = SearchViewController.init()
        let nav = UINavigationController.init(rootViewController: searchVC)
        nav.modalPresentationStyle = .overFullScreen
        self.present(nav, animated: true, completion: nil)
        
    }
    
    /**
    用懒加载来避免可选型
    懒加载属性可以用于提升代码性能，你还可以用它来抹除对象中的可选型。当你在处理 UIView 的派生类时这会很有用。举个例子，如果你的视图层级需要用到一个UILabel，通常你会需要声明这个视图的可选型属性或者隐式解包可选型属性。这种情况下，我们就可以利用 lazy 关键字消灭邪恶的可选型需求。
    */
    lazy var label1: UILabel = UILabel(frame: .zero)

    
    /**
     使用懒加载闭包
     你可以使用懒加载闭包来包装一些代码。基于存储属性做懒加载的主要好处是你的语句块只有那个属性发生读取操作时才会执行
     当你想要整理 init 方法时，这是一种很不错的实践。你可以把所有的定制逻辑放进闭包，在相应的对象被读取时自动执行。
     */
    lazy var label2:UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .red
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.text = "使用懒加载闭包"
        return label
    }()
    
    /**
     使用工厂进行懒加载初始化，同样可以做有些定制化参数
     */
    lazy var label3: UILabel = self.createCustomLabel()
    private func createCustomLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .right
        label.text = "使用工厂进行懒加载"
        return label
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let controller = ThirdViewController.init()
        self.navigationController?.pushViewController(controller, animated: true)
        
       
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
