//
//  ProjectCollectionCollectionViewCell.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/9/1.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

typealias buttonClickFoundation = (String,String) -> Void
typealias lookMoreButtonClickFoundation = () -> Void

let imageWidth = CGFloat(150)
let imageHeight = CGFloat(75)
let interval = CGFloat(10)

class ProjectCollectionCollectionViewCell: UICollectionViewCell {
 
    var scrollView = UIScrollView()
    var lookMoreButton = UIButton()
    var buttonClickMethod: buttonClickFoundation?
    var lookMoreButtonMethod: lookMoreButtonClickFoundation?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let titleLabel = UILabel()
        titleLabel.textColor = BaseColor.DarkGrayColor
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.text = "专题合集"
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(interval)
            make.top.equalTo(contentView.snp.top).offset(interval)
        }
        
        lookMoreButton.addTarget(self, action: #selector(lookMoreButtonClick), for: .touchUpInside)
        lookMoreButton.setTitle("查看全部>", for: UIControlState())
        lookMoreButton.setTitleColor(BaseColor.GrayColor, for: UIControlState())
        lookMoreButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(lookMoreButton)
        lookMoreButton.snp.makeConstraints { (make) in
            make.right.equalTo(contentView.snp.right).offset(-interval)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.width.equalTo(contentView.snp.width)
            make.height.equalTo(imageHeight)
            make.top.equalTo(titleLabel.snp.bottom).offset(interval)
            make.bottom.equalTo(contentView.snp.bottom).offset(-interval)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellForItem(_ array: [ProjectCollectionDataModel])
    {
        scrollView.contentSize = CGSize(width: CGFloat(array.count) * imageWidth + (CGFloat(array.count) + 1) * interval, height: imageHeight)
        for i in 0..<array.count
        {
            let model = array[i]
            
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: (CGFloat(i)+1)*interval + imageWidth*CGFloat(i), y: 0, width: imageWidth, height: imageHeight)
            button.sd_setBackgroundImage(with: URL(string:model.banner_image_url!)!, for: UIControlState())
            button.addTarget(self, action: #selector(ProjectCollectionCollectionViewCell.buttonClick(_:)), for: .touchUpInside)
            button.adjustsImageWhenHighlighted = false
            button.layer.cornerRadius = 5
            button.layer.masksToBounds = true
            button.tag = Int(model.id!)!
            button.titleLabel?.text = model.title
            scrollView.addSubview(button)
        }
    }
    
    func lookMoreButtonClick() {
        if lookMoreButtonMethod != nil {
            lookMoreButtonMethod!()
        }
    }
    
    @objc fileprivate func buttonClick(_ button: UIButton)
    { if buttonClickMethod != nil
        {
            buttonClickMethod!(String(button.tag),(button.titleLabel?.text)!)
        }
    }
}
