//
//  HotSearchCollectionViewCell.swift
//  SimpleSugars
//
//  Created by 苑伟 on 2016/10/19.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class HotSearchCollectionViewCell: UICollectionViewCell {
    
    lazy var hotButton: UIButton = {
        let hotButton = UIButton(type: .custom)
        hotButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        hotButton.backgroundColor = UIColor.white
        hotButton.layer.borderColor = BaseColor.BorderColor.cgColor
        hotButton.layer.borderWidth = 0.5
        hotButton.layer.cornerRadius = 3
        hotButton.layer.masksToBounds = true
        hotButton.isUserInteractionEnabled = true
        hotButton.setTitleColor(BaseColor.GrayColor, for: .normal)
        return hotButton
    }()
    
    lazy var deleteButton: UIButton = {
        let deleteButton = UIButton(type: .custom)
        deleteButton.setImage(UIImage(named:"delete"), for: .normal)
        deleteButton.isUserInteractionEnabled = true
        return deleteButton
    }()
    
    lazy var containerView:UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.clear
        containerView.isUserInteractionEnabled = true
        return containerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(containerView)
        containerView.frame = contentView.bounds
        containerView.addSubview(hotButton)
        containerView.addSubview(deleteButton)
        hotButton.frame = contentView.bounds
        deleteButton.isHidden = true
        deleteButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(15)
            make.top.equalTo(hotButton.snp.top).offset(-5)
            make.right.equalTo(hotButton.snp.right).offset(5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
