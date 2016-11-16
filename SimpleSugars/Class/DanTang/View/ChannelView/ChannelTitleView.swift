//
//  ChannelTitleView.swift
//  SimpleSugars
//
//  Created by 苑伟 on 2016/10/26.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

typealias editChannelButtonClick = (UIButton) -> Void

class ChannelTitleView: UIView {

    var editChannelButton: editChannelButtonClick?
    
    lazy var tipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.text = "切换频道"
        tipLabel.font = UIFont.systemFont(ofSize: 12)
        tipLabel.textColor = BaseColor.GrayColor
        return tipLabel
    }()
    
    lazy var clickButton: UIButton = {
        let clickButton = UIButton(type: .custom)
        clickButton.setTitle("排序或删除", for: .normal)
        clickButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        clickButton.setTitleColor(BaseColor.RedColor, for: .normal)
        return clickButton
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = BaseColor.BorderColor
        return lineView
    }()
    
    class func returnTitleView() -> ChannelTitleView
    {
        let titleView = ChannelTitleView()
        
        titleView.addSubview(titleView.tipLabel)
        titleView.tipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleView.snp.left).offset(15)
            make.centerY.equalTo(titleView.snp.centerY)
        }
        titleView.clickButton.addTarget(titleView, action: #selector(editChannel(button:)), for: .touchUpInside)
        titleView.addSubview(titleView.clickButton)
        titleView.clickButton.snp.makeConstraints { (make) in
            make.right.equalTo(titleView.snp.right).offset(-15)
            make.centerY.equalTo(titleView.snp.centerY)
        }
        titleView.addSubview(titleView.lineView)
        titleView.lineView.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.height.equalTo(15)
            make.width.equalTo(0.5)
            make.centerY.equalTo(titleView.snp.centerY)
        }
        return titleView
    }
    
    func editChannel(button: UIButton){
        if editChannelButton != nil {
            editChannelButton!(button)
        }
    }
    
    func normalTitle() {
        tipLabel.text = "切换频道"
        clickButton.setTitle("排序或删除", for: .normal)
        clickButton.isSelected = false
    }
    
    func selectTitle() {
        tipLabel.text = "拖动排序"
        clickButton.setTitle("完成", for: .normal)
        clickButton.isSelected = true
    }

}
