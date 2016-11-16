//
//  SettingViewController.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/9/2.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

let settingCell = "settingCell"

class SettingViewController: BaseViewController {

    var listArray = [AnyObject]()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "SettingTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: settingCell)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "更多"
        view.addSubview(tableView)
        loadSettingPlistFile()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func loadSettingPlistFile()
    {
        let path = Bundle.main.path(forResource: "SettingCell", ofType: ".plist")
        let settingsPlist = NSArray.init(contentsOfFile: path!)
        for arrayDict in settingsPlist!
        {
            let array = arrayDict as! NSArray
            var sections = [AnyObject]()
            for dict in array {
                let setting = SettingDataModel(dict: dict as! [String: AnyObject])
                sections.append(setting)
            }
            listArray.append(sections as AnyObject)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SettingViewController: UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return listArray.count 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray[section].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: settingCell) as! SettingTableViewCell
        let array = listArray[(indexPath as NSIndexPath).section] as! [SettingDataModel]
        cell.model = array[(indexPath as NSIndexPath).row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}
