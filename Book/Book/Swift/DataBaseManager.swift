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
       
    @objc func insertContacts(_ contacts:Array<Array<Any>>) {
        
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
            
            db.makeFunctionNamed("magicName", arguments: 2) { context, argc, argv in
                
                let firstType  = db.valueType(argv[0])
                let secondType = db.valueType(argv[1])

                if firstType != .text || secondType != .text {
                    
                    db.resultString("N", context: context)
                   
                    return;
                }
                
                let firstParams  = db.valueString(argv[0])!
                let secondParams = db.valueString(argv[1])!

                if firstParams.contains(secondParams) {
                    
                    return db.resultString("Y", context: context)
               
                } else {
                    
                    return db.resultString("N", context: context)

                }
            }
            
            let rs:FMResultSet = db.executeQuery("select magicName(t.nameCN, '刘'), * from Contacts t", withArgumentsIn: [])!
            while rs.next() {
                    let name = rs.string(forColumnIndex: 0)
                    print("===== \(name)")
             }

        }
        
        
        
//        FMResultSet *rs = [self.db executeQuery:@"select rowid,* from test where a = ?", @"hi"];


    }
    
}
