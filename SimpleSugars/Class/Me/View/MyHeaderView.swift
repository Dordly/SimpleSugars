//
//  MyHeaderView.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/9/1.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

typealias messageButtonClickMethod = () -> Void
typealias settingButtonClickMethod = () -> Void
typealias iconButtonClickMethod = () -> Void

class MyHeaderView: UIView {

    var messageButtonClick: messageButtonClickMethod?
    var settingButtonClick: settingButtonClickMethod?
    var iconButtonClick: iconButtonClickMethod?

    /// 懒加载，创建背景图片
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.contentMode = .scaleAspectFill
        bgImageView.image = UIImage(named: "Me_ProfileBackground")
        return bgImageView
    }()
    
    /// 懒加载，创建左上角消息按钮
    lazy var messageButton: UIButton = {
        let messageButton = UIButton()
        messageButton.tag = 10
        messageButton.setImage(UIImage(named: "Me_message_20x20_"), for: UIControlState())
        return messageButton
    }()
    
    /// 懒加载，创建左上角消息按钮
    lazy var settingButton: UIButton = {
        let settingButton = UIButton()
        settingButton.tag = 20
        settingButton.setImage(UIImage(named: "Me_settings_20x20_"), for: UIControlState())
        return settingButton
    }()
    
    /// 懒加载，创建头像按钮
    lazy var iconButton: UIButton = {
        let iconButton = UIButton()
        iconButton.tag = 30
        iconButton.setBackgroundImage(UIImage(named: "Me_AvatarPlaceholder_75x75_"), for: UIControlState())
        iconButton.layer.cornerRadius = iconButton.width * 0.5
        iconButton.layer.masksToBounds = true
        return iconButton
    }()
    
    /// 懒加载，创建昵称标签
    fileprivate lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "登录"
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.systemFont(ofSize: 16.0)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
        return nameLabel
    }()
    
    class func returnHeaderView() -> MyHeaderView
    {
        let headerView = MyHeaderView()
        
        headerView.addSubview(headerView.bgImageView)
        headerView.addSubview(headerView.messageButton)
        headerView.addSubview(headerView.settingButton)
        headerView.addSubview(headerView.iconButton)
        headerView.addSubview(headerView.nameLabel)
        
        headerView.bgImageView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(headerView)
            make.height.equalTo(200)
        }
        
        headerView.messageButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 44, height: 44))
            make.left.equalTo(headerView.snp.left)
            make.top.equalTo(headerView.snp.top).offset(20)
        }
        
        headerView.settingButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 44, height: 44))
            make.right.equalTo(headerView.snp.right)
            make.top.equalTo(headerView.snp.top).offset(20)
        }
        
        headerView.iconButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(headerView.snp.centerX)
            make.size.equalTo(CGSize(width: 75, height: 75))
            make.top.equalTo(headerView.snp.top).offset(70)
        }
        
        headerView.nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headerView.snp.left).offset(10)
            make.right.equalTo(headerView.snp.right).offset(-10)
            make.top.equalTo(headerView.iconButton.snp.bottom).offset(10)
        }
        headerView.messageButton.addTarget(headerView, action: #selector(headerView.selectButtonClick(button:)), for: .touchUpInside)
        headerView.settingButton.addTarget(headerView, action: #selector(headerView.selectButtonClick(button:)), for: .touchUpInside)
        headerView.iconButton.addTarget(headerView, action: #selector(headerView.selectButtonClick(button:)), for: .touchUpInside)

        return headerView
    }
    
    func selectButtonClick(button: UIButton) {
        switch button.tag {
        case 10: if messageButtonClick != nil { messageButtonClick!() }
        case 20: if settingButtonClick != nil { settingButtonClick!() }
        case 30: if iconButtonClick != nil { iconButtonClick!() }
        default:
            break
        }
    }
}
