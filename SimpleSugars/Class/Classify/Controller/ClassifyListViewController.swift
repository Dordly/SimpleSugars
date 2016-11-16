//
//  ClassifyListViewController.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/9/2.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

enum  PageType: String{
    case Project = "专题合集",StyleCategory = "风格品类"
}

class ClassifyListViewController: UITableViewController {

    fileprivate var listArray = [HomeDataModel]()
    var id: String!
    var pageType: PageType!
    
    convenience init(type:PageType) {
        self.init()
        self.pageType = type
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        requestData()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func setupTableView()
    {
        tableView.rowHeight = 150
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: homeCell)
    }
    fileprivate func requestData()
    {
        if pageType == .Project
        {
            let url = APPURLAPI.loadCollectionPosts(id)
            GETRequestWithUrlString(url, success: { (response) in
                self.listArray = response.data["posts"].arrayValue.map{json in HomeDataModel(jsonDic:json)}
                self.tableView.reloadData()
            }) { (_) in
                
            }
        }
        else
        {
            let url = APPURLAPI.loadStylesOrCategoryInfo(id)
            GETRequestWithUrlString(url, success: { (response) in
                self.listArray = response.data["items"].arrayValue.map{json in HomeDataModel(jsonDic:json)}
                self.tableView.reloadData()
            }) { (_) in
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ClassifyListViewController
{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count 
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HomeTableViewCell.returnHomeTableViewCell(tableView,model: listArray[(indexPath as NSIndexPath).row])
        cell.sepLine.isHidden = true
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = RaidersDetailViewController()
        vc.model = listArray[(indexPath as NSIndexPath).row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
