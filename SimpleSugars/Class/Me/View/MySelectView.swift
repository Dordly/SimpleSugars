//
//  MySelectView.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/9/1.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class MySelectView: UIView {
    
    class func returnSelectView() -> MySelectView
    {
        let selectView = MySelectView()
        selectView.backgroundColor = UIColor.white
        
        selectView.addSubview(selectView.leftButton)
        selectView.addSubview(selectView.rightButton)
        selectView.addSubview(selectView.indicatorView)
        selectView.addSubview(selectView.topLine)
        selectView.addSubview(selectView.bottomLine)
        selectView.addSubview(selectView.centerLine)
        
        selectView.leftButton.snp.makeConstraints { (make) in
            make.left.top.equalTo(selectView)
            make.width.equalTo(selectView.snp.width).multipliedBy(0.5)
            make.height.equalTo(selectView.snp.height)
        }
        
        selectView.rightButton.snp.makeConstraints { (make) in
            make.right.top.equalTo(selectView)
            make.width.equalTo(selectView.leftButton.snp.width)
            make.height.equalTo(selectView.snp.height)
        }
        
        selectView.indicatorView.snp.makeConstraints { (make) in
            make.height.equalTo(2)
            make.bottom.left.equalTo(selectView)
            make.right.equalTo(selectView.leftButton.snp.right)
        }
        
        selectView.topLine.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.top.left.right.equalTo(selectView)
        }

        selectView.bottomLine.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.bottom.left.right.equalTo(selectView)
        }
        
        selectView.centerLine.snp.makeConstraints { (make) in
            make.centerX.equalTo(selectView.snp.centerX)
            make.centerY.equalTo(selectView.snp.centerY)
            make.height.equalTo(selectView.snp.height)
            make.width.equalTo(0.5)
        }

        return selectView
    }
    
    //上边分割线
    fileprivate lazy var topLine: UIView = {
        let topLine = UIView()
        topLine.backgroundColor = BaseColor.BorderColor
        return topLine
    }()
    
    //下边分割线
    fileprivate lazy var bottomLine: UIView = {
        let bottomLine = UIView()
        bottomLine.backgroundColor = BaseColor.BorderColor
        return bottomLine
    }()

    //中间分割线
    fileprivate lazy var centerLine: UIView = {
        let centerLine = UIView()
        centerLine.backgroundColor = BaseColor.BorderColor
        return centerLine
    }()

    // 左边的按钮
    fileprivate lazy var leftButton: UIButton = {
        let leftButton = UIButton()
        leftButton.setTitle("喜欢的商品", for: UIControlState())
        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        leftButton.setTitleColor(BaseColor.DarkGrayColor, for: UIControlState())
        leftButton.backgroundColor = UIColor.clear
        leftButton.addTarget(self, action: #selector(leftButtonClick(_:)), for: .touchUpInside)
        leftButton.isSelected = true
        return leftButton
    }()
    
    // 右边的按钮
    fileprivate lazy var rightButton: UIButton = {
        let rightButton = UIButton()
        rightButton.setTitle("喜欢的专题", for: UIControlState())
        rightButton.setTitleColor(BaseColor.DarkGrayColor, for: UIControlState())
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        rightButton.backgroundColor = UIColor.clear
        rightButton.addTarget(self, action: #selector(rightButtonClick(_:)), for: .touchUpInside)
        return rightButton
    }()
    
    // 底部红色条
    fileprivate lazy var indicatorView: UIView = {
        let indicatorView = UIView()
        indicatorView.backgroundColor = BaseColor.RedColor
        return indicatorView
    }()

    func leftButtonClick(_ button: UIButton) {
        button.isSelected = !button.isSelected
        UIView.animate(withDuration: 0.2, animations: {
            self.indicatorView.x = 0
        }) 
    }
    
    func rightButtonClick(_ button: UIButton) {
        button.isSelected = !button.isSelected
        UIView.animate(withDuration: 0.2, animations: {
            self.indicatorView.x = kScreenW * 0.5
        }) 
    }
}
