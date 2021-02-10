//
//  DataBaseManager.swift
//  Book
//
//  Created by Apple on 2021/1/21.
//  Copyright © 2021 马大哈. All rights reserved.
//

import UIKit
import FMDB

class DataBaseManager: NSObject {

    static let sharedInstance = DataBaseManager();
       
    var queue:FMDatabaseQueue
       
    private override init() {
        
        /*
         以.sqlite 或 .db结尾没有区别，
         SQLite并不关心文件使用的扩展名。它通过检查幻数和标题来检查它所给出的内容是否确实是SQLite3数据库。
         */
        let dbPath = NSHomeDirectory() + "/Documents/" + "contact.db"
        print("database path: \(dbPath)")
        queue = FMDatabaseQueue(path: dbPath)!
        
        super.init()
        
        self.createTable()
    }
    
    
    func createTable() {
        
        self.queue.inTransaction { (db, rollback) in
            
            let createSQL = "create table if not exists Contacts" +
            "(id        INTEGER PRIMARY KEY AUTOINCREMENT ," +
            "nameCN     TEXT collate nocase," +
            "fullPinyin TEXT collate nocase," +
            "regularPinyin TEXT collate nocase);" +
                
            "create table if not exists Test" +
             "(id        INTEGER PRIMARY KEY AUTOINCREMENT ," +
             "nameCN     TEXT collate nocase)"
            
            
            let result = db.executeStatements(createSQL)
            if result {
                print("Contacts Table create successed!")
            }
        }
    }
    
    @objc func deleteTable() {
        
        self.queue.inTransaction { (db, rollback) in
            
            let dtSQL = "drop Contacts"
            db.executeUpdate(dtSQL, withArgumentsIn: [])
        }
    }
       
    @objc func deleteAllData() {
        
        self.queue.inTransaction { (db, rollback) in
            
            let ddSQL = "delete from Contacts"
            db.executeUpdate(ddSQL, withArgumentsIn: [])

        }
    }
    
    @objc func insertContacts(_ contacts:Array<Array<String>>) {
        
        self.queue.inTransaction { (db, rollback) in
        
            let insetSQL = "insert into Contacts (nameCN, fullPinyin, regularPinyin) values (?,?,?)"
            
            for i in contacts {

                let result = db.executeUpdate(insetSQL, withArgumentsIn: i)
                if result {
                    print("insert successed \(i)")
                }
            }
        }
    }
    
    @objc func queryHero(_ words:String) {

        self.queue.inTransaction { (db, rollback) in
            
            db.makeFunctionNamed("magicName", arguments: 3) { context, argc, argv in
                
                let firstType  = db.valueType(argv[0])
                let secondType = db.valueType(argv[1])
                let thirdType  = db.valueType(argv[1])

                if firstType != .text || secondType != .text || thirdType != .text {
                    let rs = NSStringFromRange(NSMakeRange(0, 0))
                    db.resultString(rs, context: context)
                    return;
                }
                
                /*
                 lb
                 0z,0zhu,1g,1ge,2l,2li,2lia,2lian,2liang
                 */
                let firstParams  = db.valueString(argv[0])!
                let secondParams = db.valueString(argv[1])!
                let thirdParams  = db.valueString(argv[2])!

                print("[1]: \(firstParams)  \(secondParams)  \(thirdParams)")
                
                let thirdArr:[String] = thirdParams.components(separatedBy: ",")
                
                print("[2]: \(thirdArr)")

                if firstParams.count < thirdArr.count {
                    let rs = NSStringFromRange(NSMakeRange(0, 0))
                    db.resultString(rs, context: context)
                    print("[3]: 当前对比数据与搜索数据不匹配")
                    return;
                }
                   
                if firstParams.count == thirdArr.count {
                    
                    var valid:Bool = true
                    for (j,str) in thirdArr.enumerated() {
                        
                        let newStr = "\(j)\(str)"
                        if !secondParams.contains(newStr) {
                            valid = false
                            break;
                        }
                    }
                    
                    var rs:String
                    if valid {
                        rs = NSStringFromRange(NSMakeRange(0, thirdArr.count))
                    } else {
                        rs = NSStringFromRange(NSMakeRange(0, 0))
                    }
                    
                    db.resultString(rs, context: context)
                    print("[4]: make rangeStr = \(rs)")

                    return;
                }

                var findIdx = -1
                
                for i in 0..<firstParams.count-thirdArr.count {

                    var valid:Bool = true
                    for (j,str) in thirdArr.enumerated() {
                        
                        let newStr = "\(i+j)\(str)"
                        print("[5]: find [\(newStr)] from \(secondParams)")

                        if !secondParams.contains(newStr) {
                            valid = false
                            break;
                        }
                    }
                    
                    if valid {
                        findIdx = i
                        print("[6]: find index = \(findIdx)")
                        break;
                    }
                    
                }
                
                if findIdx > -1 {
                    let rs = NSStringFromRange(NSMakeRange(findIdx, thirdArr.count))
                    db.resultString(rs, context: context)
                    print("[7]: make rangeStr = \(rs)")
                    return
                }
                
                let rs = NSStringFromRange(NSMakeRange(0, 0))
                db.resultString(rs, context: context)
                print("[8]: not find \(rs)")
            }
            
            let rs:FMResultSet = db.executeQuery("select magicName(t.nameCN, t.regularPinyin, 'l,b') as magic, * from Contacts t", withArgumentsIn: [])!
            while rs.next() {
                //                    let name = rs.string(forColumnIndex: 0)!
                let name = rs.string(forColumn: "magic")!
                print("===== \(name)")
            }

        }
        
        
        
//        FMResultSet *rs = [self.db executeQuery:@"select rowid,* from test where a = ?", @"hi"];


    }
    
}
