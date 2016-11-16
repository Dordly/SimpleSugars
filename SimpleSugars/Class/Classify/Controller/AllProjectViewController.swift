//
//  AllProjectViewController.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/9/2.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

let allProjectCell = "allProjectCell"

class AllProjectViewController: UITableViewController {

    fileprivate var listArray = [ProjectCollectionDataModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "全部专题"
        setupTableView()
        requestData()
    }
    
    fileprivate func setupTableView()
    {
        tableView.rowHeight = 150
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        let nib = UINib(nibName: "AllProjectTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: allProjectCell)
    }
    fileprivate func requestData()
    {
        let url = APPURLAPI.loadCategoryCollection("20")
        GETRequestWithUrlString(url, success: { (response) in
            self.listArray = response.data["collections"].arrayValue.map{json in ProjectCollectionDataModel(jsonDic:json)}
            self.tableView.reloadData()
        }) { (_) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension AllProjectViewController
{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count 
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: allProjectCell, for: indexPath) as! AllProjectTableViewCell
        cell.model = listArray[(indexPath as NSIndexPath).row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = listArray[(indexPath as NSIndexPath).row]
        let vc = ClassifyListViewController(type: .Project)
        vc.id = model.id
        vc.title = model.title
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
