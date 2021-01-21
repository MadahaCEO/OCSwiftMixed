//
//  SearchViewController.swift
//  Book
//
//  Created by Apple on 2021/1/19.
//  Copyright © 2021 马大哈. All rights reserved.
//

import UIKit
import Masonry


class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

//    var dataSource = [""]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "返回", style: .plain, target: self, action: #selector(back))
        
        
        self.view.addSubview(self.peopleTableView)
        self.peopleTableView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.view)
        }

        let result = ConverToPinyin.sharedInstance.object("刘奇")
        print(result.fullPinyin,result.regularPinyin)
//        ConverToPinyin.sharedInstance.object("刘贝贝")

    }
    
    
    
    @objc func back()  {
        self.dismiss(animated: true, completion: nil)
    }
    
    
//    lazy var dataSource:NSMutableArray = {
//        le
//    }
    
    lazy var peopleTableView:UITableView = {
        
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 40
        return tableView
    }()
    
    
    //MARK: UITableViewDataSource
    // cell的个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    // UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellid = "testCellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellid)
        if cell==nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellid)
        }
        
        cell?.textLabel?.text = "这个是标题~ + \(indexPath.row)"
        cell?.detailTextLabel?.text = "这里是内容了油~"
        return cell!
    }
    
    //MARK: UITableViewDelegate
 
    // 选中cell后执行此方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
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
