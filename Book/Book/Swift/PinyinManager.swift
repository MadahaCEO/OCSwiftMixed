//
//  PinyinManager.swift
//  Book
//
//  Created by Apple on 2021/1/29.
//  Copyright © 2021 马大哈. All rights reserved.
//

import UIKit
import MDH


class PinyinManager: NSObject {

    static let sharedInstance = PinyinManager();
    
    var pyManager:MDHChinesePinyinManager

    private override init() {
        
        pyManager = MDHChinesePinyinManager.init()

        super.init()
        
    }
    
    
    @objc func convertToPinyin(_ hanzi:String) -> String {
    
        var orderPinyin:[String] = []
        
        
        let arr = pyManager.toPinyin(hanzi) as! [String]
        print("\(hanzi) 对应的拼音组合 \(arr)")
        
        for (idx0, str0) in arr.enumerated() {
            
            let arr0 =  str0.split(separator: " ")
            print("\(idx0) \(str0) \(arr0)")
            
            for (idx1, str1) in arr0.enumerated() {
                                   
                if idx1 == arr0.count - 1 {
                    
                    for i in 0..<str1.count {
                        
                        let str2 = "\(idx1)"+str1.prefix(i+1)

                        if !orderPinyin.contains(str2) {
                            orderPinyin.append(str2)
                            print("\(str2)")

                        }
                    }
                    
                } else {
                    
                    let str2 = str1.prefix(1)
                    let str3 = str1
                    
                    let str4 = "\(idx1)" + str2
                    let str5 = "\(idx1)" + str3
                    
                    if !orderPinyin.contains(str4) {
                        orderPinyin.append(str4)
                        print("\(str4)")
                    }
                    
                    if !orderPinyin.contains(str5) {
                        orderPinyin.append(str5)
                        print("\(str5)")
                    }
                    
                }
            }
        }
        
//        let str = arr.joined(separator: ",").replacingOccurrences(of: " ", with: "")
                
        return orderPinyin.joined(separator: ",")
        
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

            //    MDHChinesePinyinManager *manager = [[MDHChinesePinyinManager alloc] init];
            //       NSArray *array =  [manager firstLetters:@"行"];
            //    MDHChinesePinyinManager *manager = [[MDHChinesePinyinManager alloc] init];
            //       NSArray *array =  [manager toPinyin:@"李长行"];

            
            return (str,"ppp")
        }
    
    // MARK: 读取本地拼音集合数据
    func readLocalFile() -> Dictionary<String, Any> {
        
        var pinyinDic:[String:Array<String>] = [:]

        let dataPath = NSHomeDirectory() + "/Documents/" + "pinyin"
        let url = NSURL.fileURL(withPath: dataPath)
        
        let exists = FileManager.default.fileExists(atPath: dataPath)
        if exists {
            
            let data = try! Data.init(contentsOf: url, options: Data.ReadingOptions.uncached)
            pinyinDic = try! NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSDictionary.self, NSArray.self] , from: data) as! [String : Array<String>]
            
        } else {
            
            pinyinDic = self.readPinyinResourceFile() as! [String : Array<String>]
            let pinyinData = try! NSKeyedArchiver.archivedData(withRootObject: pinyinDic, requiringSecureCoding: true)

            do {
                try! pinyinData.write(to: url, options: Data.WritingOptions.atomic)
                
            } catch {}
        }
        
        return pinyinDic
    }
    
    
    func readPinyinResourceFile() -> Dictionary<String, Any>  {
        
        var pinyinDic:[String:Array<String>] = [:]

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
        
        return pinyinDic
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
                        
            return pinyinArr
        }
}
