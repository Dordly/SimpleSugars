//
//  MyFooterView.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/9/1.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class MyFooterView: UIView {

    fileprivate lazy var blankButton: UIButton = {
        let blankButton = UIButton()
        blankButton.setImage(UIImage(named: "Me_blank_50x50_"), for: UIControlState())
        blankButton.imageView?.sizeToFit()
        blankButton.adjustsImageWhenHighlighted = false
        return blankButton
    }()
    
    fileprivate lazy var messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.text = "登录以享受更多功能"
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 15)
        messageLabel.textColor = BaseColor.LightGrayColor
        return messageLabel
    }()

    class func returnFooterView() -> MyFooterView
    {
        let footerView = MyFooterView()
        footerView.backgroundColor = UIColor.white
        
        footerView.addSubview(footerView.blankButton)
        footerView.addSubview(footerView.messageLabel)
        
        footerView.blankButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 50, height: 50))
            make.centerX.equalTo(footerView.snp.centerX)
            make.centerY.equalTo(footerView.snp.centerY).offset(-30)
        }
        
        footerView.messageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(footerView.blankButton.snp.bottom).offset(10)
            make.centerX.equalTo(footerView.snp.centerX)
        }

        return footerView
    }

}
