//
//  ShareView.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/9/9.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class ShareView: UIView {
    
    class func show() {
        let shareView = ShareView()
        shareView.frame = UIScreen.main.bounds
        shareView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        let window = UIApplication.shared.keyWindow
        window?.addSubview(shareView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        addSubview(bgView)
        
        // 上部 分享界面
        bgView.addSubview(topView)
        // 下部取消按钮
        bgView.addSubview(cancelButton)
        // 分享到 标签
        topView.addSubview(shareLabel)
        // 6 个分享按钮的 view
        topView.addSubview(shareButtonView)
        
        topView.snp.makeConstraints { (make) in
            make.bottom.equalTo(cancelButton.snp.top).offset(-10)
            make.left.equalTo(cancelButton.snp.left)
            make.right.equalTo(cancelButton.snp.right)
            make.height.equalTo(260)
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.left.equalTo(bgView).offset(10)
            make.right.bottom.equalTo(bgView).offset(-10)
            make.height.equalTo(44)
        }
        
        shareLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.top).offset(16)
            make.left.right.equalTo(topView)
            make.height.equalTo(20)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        UIView.animate(withDuration: 0.25, animations: {
            self.bgView.y = kScreenH - self.bgView.height
        }) 
    }
    
    // 底部 view
    fileprivate lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.frame = CGRect(x: 0, y: kScreenH, width: kScreenW, height: 300)
        return bgView
    }()
    // 上部 view
    fileprivate lazy var topView: UIView = {
        let topView = UIView()
        topView.backgroundColor = UIColor.white
        topView.layer.cornerRadius = 5
        topView.layer.masksToBounds = true
        return topView
    }()
    
    // 分享到标签
    fileprivate lazy var shareLabel: UILabel = {
        let shareLabel = UILabel()
        shareLabel.text = "分享到"
        shareLabel.textColor = BaseColor.DarkGrayColor
        shareLabel.textAlignment = .center
        return shareLabel
    }()
    // 6个按钮
    fileprivate lazy var shareButtonView: ShareButtonView = {
        let shareButtonView = ShareButtonView()
        shareButtonView.frame = CGRect(x: 0, y: 50, width: kScreenW - 20, height: 240)
        return shareButtonView
    }()
    
    fileprivate lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.setTitle("取消", for: UIControlState())
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        cancelButton.setTitleColor(UIColor.blue, for: UIControlState())
        cancelButton.backgroundColor = UIColor.white
        cancelButton.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
        cancelButton.layer.cornerRadius = 5
        cancelButton.layer.masksToBounds = true
        return cancelButton
    }()
    
    func cancelButtonClick() {
        UIView.animate(withDuration: 0.25, animations: {
            self.bgView.y = kScreenH
        }, completion: { (_) in
            self.removeFromSuperview()
        }) 
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.25, animations: {
            self.bgView.y = kScreenH
        }, completion: { (_) in
            self.removeFromSuperview()
        }) 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
