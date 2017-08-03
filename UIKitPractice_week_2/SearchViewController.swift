//
//  ViewController.swift
//  UIKitPractice_week_2
//
//  Created by Ｍason Chang on 2017/8/3.
//  Copyright © 2017年 Ｍason Chang iOS#4. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    
    var tableView: UITableView!
    var searchController: UISearchController!
    
    let cities = [
        "臺北市","新北市","桃園市","臺中市","臺南市",
        "高雄市","基隆市","新竹市","嘉義市","新竹縣",
        "苗栗縣","彰化縣","南投縣","雲林縣","嘉義縣",
        "屏東縣","宜蘭縣","花蓮縣","臺東縣","澎湖縣",]
    
    var searchArr: [String] = [String](){
        didSet {
            // 重設 searchArr 後重整 tableView
            self.tableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        
        let fullScreenSize = UIScreen.main.bounds.size
        
        //建立tableview
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 20, width: fullScreenSize.width, height: fullScreenSize.height-20))

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        
        self.searchController = UISearchController(searchResultsController: nil)
        
        self.searchController.searchResultsUpdater = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        
        self.searchController.searchBar.searchBarStyle = .prominent
        
        self.searchController.searchBar.sizeToFit()
        
        self.searchController.dimsBackgroundDuringPresentation = true
        
        self.searchController.searchBar.placeholder = " Hello world"
        
        self.searchController.searchBar.showsSearchResultsButton = true
        
        self.searchController.searchBar.barStyle = .blackOpaque
        
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        
        
        
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.searchController.isActive) {
            
            return self.searchArr.count
        } else {
            
            return self.cities.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if (self.searchController.isActive) {
            cell.textLabel?.text = self.searchArr[indexPath.row]
            return cell
        } else {
            
            cell.textLabel?.text = self.cities[indexPath.row]
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if (self.searchController.isActive) {
            
            print("u choose \(self.searchArr[indexPath.row])")
        } else {
            print("u choose \(self.cities[indexPath.row])")
        }
        
        
    }
    
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        // 取得搜尋文字
        guard let searchText =
            searchController.searchBar.text else {
                return
        }
        
        // 使用陣列的 filter() 方法篩選資料
        self.searchArr = self.cities.filter(
            { (city) -> Bool in
                // 將文字轉成 NSString 型別
                let cityText:NSString = city as NSString
                
                // 比對這筆資訊有沒有包含要搜尋的文字
                return (cityText.range(
                    of: searchText, options:
                    NSString.CompareOptions.caseInsensitive).location)
                    != NSNotFound
        })

    }
    
    
       
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

