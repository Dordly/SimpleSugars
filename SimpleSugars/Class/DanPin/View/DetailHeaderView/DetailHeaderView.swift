//
//  DetailHeaderView.swift
//  SimpleSugars
//
//  Created by 苑伟 on 2016/11/15.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class DetailHeaderView: UIView {

    fileprivate var circleView = SDCycleScrollView() //轮播
    var headerHeight: CGFloat!
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textColor = BaseColor.GrayColor
        return titleLabel
    }()
    lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = UIFont.systemFont(ofSize: 16)
        priceLabel.textColor = BaseColor.RedColor
        return priceLabel
    }()
    lazy var desLabel: UILabel = {
        let desLabel = UILabel()
        desLabel.font = UIFont.systemFont(ofSize: 14)
        desLabel.textColor = BaseColor.LightGrayColor
        desLabel.numberOfLines = 0
        return desLabel
    }()
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = BaseColor.BorderColor
        return lineView
    }()

    class func returnHeaderView(_ model: GoodDetailDataModel) -> DetailHeaderView {
        let headerView = DetailHeaderView()
        
        headerView.circleView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 370)
        headerView.circleView.backgroundColor = UIColor.clear
        headerView.circleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter
        headerView.circleView.currentPageDotColor = UIColor.white // 自定义分页控件小圆标颜色
        headerView.circleView.pageDotColor = UIColor.white.withAlphaComponent(0.6)
        headerView.circleView.autoScrollTimeInterval = 3.0
        headerView.circleView.imageURLStringsGroup = model.image_urls
        headerView.addSubview(headerView.circleView)
        
        headerView.titleLabel.text = model.name
        headerView.addSubview(headerView.titleLabel)
        headerView.titleLabel.frame = CGRect(x: 10, y: headerView.circleView.frame.maxY + 10, width: kScreenW - 20, height: 20)
        
        headerView.priceLabel.text = "￥" + model.price!
        headerView.addSubview(headerView.priceLabel)
        headerView.priceLabel.frame = CGRect(x: 10, y: headerView.titleLabel.frame.maxY + 5, width: kScreenW - 20, height: 20)
        
        headerView.desLabel.text = model.desc
        headerView.addSubview(headerView.desLabel)
        let string = String(describing: headerView.desLabel.text)
        let size = (string as NSString).boundingRect(with: CGSize(width: kScreenW,height: 200), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
        headerView.desLabel.frame = CGRect(x: 10, y: headerView.priceLabel.frame.maxY + 5, width: kScreenW - 20, height: size.height)
        
        headerView.addSubview(headerView.lineView)
        headerView.lineView.frame = CGRect(x: 0, y: headerView.desLabel.frame.maxY + 10, width: kScreenW, height: 0.5)
        
        headerView.headerHeight = headerView.lineView.frame.maxY
        
        return headerView
    }
    
    func returnHeaderHeight() -> CGFloat {
        return headerHeight
    }

}
