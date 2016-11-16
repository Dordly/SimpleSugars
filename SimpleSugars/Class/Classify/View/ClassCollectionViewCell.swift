//
//  ClassCollectionViewCell.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/9/1.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class ClassCollectionViewCell: UICollectionViewCell {
    
    let button = UIButton()
    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.white
        
        button.backgroundColor = UIColor.clear
        button.isUserInteractionEnabled = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(BaseColor.GrayColor, for: UIControlState())
        button.contentHorizontalAlignment = .center
        button.adjustsImageWhenHighlighted = false
        contentView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.width.height.equalTo(65)
            make.top.equalTo(contentView.snp.top)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        titleLabel.textColor = BaseColor.GrayColor
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.width.equalTo(contentView.snp.width)
            make.top.equalTo(button.snp.bottom).offset(10)
            make.centerX.equalTo(contentView.snp.centerX)
        }
    }
    
    var model: ChannelsDataModel?
    {
        didSet
        {
            button.sd_setImage(with: URL(string: (model?.icon_url)!)!, for: UIControlState())
            titleLabel.text = model?.name
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
