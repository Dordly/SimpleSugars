//
//  DanTangViewController.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/8/24.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

let homeCell = "homeCell"

enum selectedType: String {
    case select = "精选" ; case other = "其他"
}

class DanTangViewController: UITableViewController {
    
    var selectType : selectedType = .select
    
    fileprivate var listArray = [HomeDataModel]()
    var type = "1"
    fileprivate var groupArray = NSMutableArray()//分组后的数据

    fileprivate var circleView = SDCycleScrollView() //轮播
    fileprivate var bannerArray = [BannerDataModel]()

    override func viewDidLoad() {
        setupTableView()
        if selectType == .select {
            requestBannerData()
        }
        requestData()
    }
    fileprivate func setupTableView()
    {
        tableView = UITableView(frame: self.view.bounds, style: .grouped)
        tableView.backgroundColor = BaseColor.BackGroundColor
        tableView.rowHeight = 150
        tableView.separatorStyle = .none
        tableView.scrollIndicatorInsets = tableView.contentInset
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: homeCell)
        if selectType == .select {
            tableView.contentInset = UIEdgeInsetsMake(35, 0, -10, 0)
        
            let tableHeaderView = UIView(frame: CGRect(x: 0,y: 0,width: kScreenW,height: 148))
            tableHeaderView.backgroundColor = BaseColor.BackGroundColor
            
            circleView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 140)
            circleView.backgroundColor = BaseColor.BackGroundColor
            circleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter
            circleView.currentPageDotColor = UIColor.white // 自定义分页控件小圆标颜色
            circleView.pageDotColor = UIColor.white.withAlphaComponent(0.6)
            circleView.autoScrollTimeInterval = 3.0
            circleView.delegate = self
            tableHeaderView.addSubview(circleView)
            tableView.tableHeaderView = tableHeaderView
        } else {
            tableView.contentInset = UIEdgeInsetsMake(45, 0, -10, 0)
        }
    }
    //请求列表数据
    fileprivate func requestData()
    {
        let url = APPURLAPI.loadHomeInfo(type)
        GETRequestWithUrlString(url, success: { (response) in
            print(response.data)
            self.listArray = response.data["items"].arrayValue.map{json in HomeDataModel(jsonDic:json)}
            self.loadData()
            self.tableView.reloadData()
        }) { (_) in
            
        }
    }
    
    func loadData()
    {
        let array = NSMutableArray()
        for i in 0...listArray.count-1
        {
            let model = listArray[i]
            var tempArray = [HomeDataModel]()
            for j in 0...listArray.count-1
            {
                let model1 = listArray[j]
                if model.published_at == model1.published_at
                {
                    tempArray.append(model1)
                }
            }
            if !array.contains(model.published_at!) {
                groupArray.add(tempArray)
                array.add(model.published_at!)
            }
        }
    }
    //请求轮播图
    fileprivate func requestBannerData()
    {
        let url = APPURLAPI.loadHomeShuffling()
        GETRequestWithUrlString(url, success: { (response) in
            self.bannerArray = response.data["banners"].arrayValue.map{json in BannerDataModel(jsonDic:json)}
            var imageURLStringsGroup = [String]()
            for item in self.bannerArray
            {
                imageURLStringsGroup.append(item.image_url!)
            }
            self.circleView.imageURLStringsGroup = imageURLStringsGroup
            self.tableView.reloadData()
        }) { (_) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: SDCycleScrollViewDelegate
extension DanTangViewController: SDCycleScrollViewDelegate
{
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        let vc = ClassifyListViewController(type: .Project)
        let target = self.bannerArray[index].target
        vc.id = target?.id!
        vc.title = target?.title
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension DanTangViewController
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        if selectType == .select {
            return groupArray.count
        }
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectType == .select {
            return (self.groupArray[section] as AnyObject).count ?? 0
        }
        return self.listArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var model: HomeDataModel
        if selectType == .select
        {
            let index = groupArray[(indexPath as NSIndexPath).section] as! [HomeDataModel]
            model = index[(indexPath as NSIndexPath).row]
        } else {
            model = listArray[(indexPath as NSIndexPath).row]
        }
        let cell = HomeTableViewCell.returnHomeTableViewCell(tableView,model: model)
        if selectType == .select {
            cell.backgroundColor = UIColor.white
            if (indexPath as NSIndexPath).row == (groupArray[(indexPath as NSIndexPath).section] as AnyObject).count - 1 {
                cell.sepLine.isHidden = false
            } else {
                cell.sepLine.isHidden = true
            }
        } else {
            cell.backgroundColor = UIColor.clear
            cell.sepLine.isHidden = true
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var model: HomeDataModel
        if selectType == .select {
            let index = groupArray[(indexPath as NSIndexPath).section] as! [HomeDataModel]
            model = index[(indexPath as NSIndexPath).row]
        } else {
            model = listArray[(indexPath as NSIndexPath).row]
        }
        let vc = RaidersDetailViewController()
        vc.model = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if selectType == .select {
            let headerView = HomeHeaderView.returnHomeHeaderView()
            let index = groupArray[section] as! [HomeDataModel]
            headerView.titleLabel.text = geDateForTimeStamp(index[0].published_at!)
            return headerView
        } else {
            return nil
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if selectType == .select {
            return 40
        }
        return 0.01
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 10
    }
    //根据时间戳转换为日期格式
    func geDateForTimeStamp(_ timeStamp: String) -> String
    {
        //获取日期
        let time = Double(timeStamp)!
        let newDate = Date(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年M月d日"
        let currentDate = dateFormatter.string(from: newDate)
        //print(currentDate)
        
        //获取当前日期对应的星期几
        var calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let components = (calendar as NSCalendar?)?.components(.weekday, from: getDateForString(currentDate))
        //print(components!.weekday)
        var weekDay = ""
        let day = components?.weekday
        if day == 1 {
            weekDay = "星期一"
        } else if day == 2 {
            weekDay = "星期二"
        } else if day == 3 {
            weekDay = "星期三"
        }else if day == 4 {
            weekDay = "星期四"
        } else if day == 5 {
            weekDay = "星期五"
        } else if day == 6 {
            weekDay = "星期六"
        } else if day == 7 {
            weekDay = "星期日"
        }
        let date  = (currentDate as NSString).substring(from: 5)
        return date + " " +  weekDay
    }
    //字符串转化成日期
    func getDateForString(_ timeString: String) -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年M月d日"
        let date = dateFormatter.date(from: timeString)
        return date!
    }
}
