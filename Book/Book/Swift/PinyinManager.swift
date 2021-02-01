//
//  PinyinManager.swift
//  Book
//
//  Created by Apple on 2021/1/29.
//  Copyright © 2021 马大哈. All rights reserved.
//

import UIKit

class PinyinManager: NSObject {

    static let sharedInstance = PinyinManager();
    
    
    private override init() {
        
        super.init()
        
    }
    
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
