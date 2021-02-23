//
//  SearchViewController.swift
//  Book
//
//  Created by Apple on 2021/1/19.
//  Copyright © 2021 马大哈. All rights reserved.
//

import UIKit
import Masonry


class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchControllerDelegate {

    var sourceArray:[String] = []
    var resultArray:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        
        self.title = "魔法姓名"

        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "返回", style: .plain, target: self, action: #selector(back))
                
        self.sourceArray.append("1")
        self.sourceArray.append("2")
        self.sourceArray.append("3")
        self.sourceArray.append("4")
        self.sourceArray.append("5")
        self.sourceArray.append("6")
        self.sourceArray.append("7")
        self.sourceArray.append("8")
        self.sourceArray.append("9")

        
        self.view.addSubview(self.peopleTableView)
        self.peopleTableView.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.view)
        }

    }
    
    
    
    @objc func back()  {
        self.dismiss(animated: true, completion: nil)
    }
    
        
    
    lazy var peopleTableView:UITableView = {
        
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 40
        tableView.tableHeaderView = self.searchController.searchBar
        return tableView
    }()
    
    lazy var searchController: UISearchController = {
        let controller = UISearchController.init(searchResultsController:nil)
        controller.searchBar.isTranslucent = false
        controller.searchBar.barStyle = UIBarStyle.default
        controller.searchResultsUpdater = self
        controller.delegate = self
        controller.obscuresBackgroundDuringPresentation = true
//        controller.hidesNavigationBarDuringPresentation = false
//        controller.searchBar.scopeButtonTitles = ["三国","水浒","西游记","红楼梦"]
//        controller.searchBar.showsScopeBar = true
        return controller;
    }()
    
    
    func updateSearchResults(for searchController: UISearchController) {
                
        let temp:String = searchController.searchBar.text!
        if temp.count == 0 {
            
            return
        }
       
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        self.perform(#selector(searchDB(str:)), with: temp, afterDelay: 0.2)
    }
    
    
    @objc func searchDB(str:String) {
        
        print("搜索框输入字符" + searchController.searchBar.text!)
 
        self.resultArray.append(str)

        self.peopleTableView.reloadData()
    }
    
    
    func willPresentSearchController(_ searchController: UISearchController) {
                
        
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        

    }
      
//    #pragma mark - UISearchResultsUpdating
//    - (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
//
//        NSString *inputStr = searchController.searchBar.text ;
//        if (self.results.count > 0) {
//            [self.results removeAllObjects];
//        }
//        for (NSString *str in self.datas) {
//
//            if ([str.lowercaseString rangeOfString:inputStr.lowercaseString].location != NSNotFound) {
//
//                [self.results addObject:str];
//            }
//        }
//
//        [self.tableView reloadData];
//    }
    
    
    //MARK: UITableViewDataSource
    // cell的个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (self.searchController.isActive) {
            
            return self.resultArray.count ;
        }
        
        return self.sourceArray.count
    }
    // UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellid = "testCellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellid)
        if cell==nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellid)
        }
        
        if (self.searchController.isActive) {
            
            cell?.textLabel?.text = "这个是result标题~ + \(self.resultArray[indexPath.row])"

        } else {
            
            cell?.textLabel?.text = "这个是default标题~ + \(self.sourceArray[indexPath.row])"
        }

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
