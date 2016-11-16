//
//  ShareButtonView.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/9/9.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

enum ShareButtonType: Int {
    /// 微信朋友圈
    case weChatTimeline = 0
    /// 微信好友
    case weChatSession = 1
    /// 微博
    case weibo = 2
    /// QQ 空间
    case qZone = 3
    /// QQ 好友
    case qqFriends = 4
    /// 复制链接
    case copyLink = 5
}

class ShareButtonView: UIView {

    // 图片数组
    let images = ["Share_WeChatTimelineIcon_70x70_", "Share_WeChatSessionIcon_70x70_", "Share_WeiboIcon_70x70_", "Share_QzoneIcon_70x70_", "Share_QQIcon_70x70_", "Share_CopyLinkIcon_70x70_"]
    // 标题数组
    let titles = ["微信朋友圈", "微信好友", "微博", "QQ 空间", "QQ 好友", "复制链接"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        let maxCols = 3
        
        let buttonW: CGFloat = 85
        let buttonH: CGFloat = buttonW + 20
        let buttonStartX: CGFloat = 20
        let xMargin: CGFloat = (kScreenW - 20 - 2 * buttonStartX - CGFloat(maxCols) * buttonW) / CGFloat(maxCols - 1)
        
        // 创建按钮
        for index in 0..<images.count {
            let button = ShareButton()
            button.tag = index
            button.setImage(UIImage(named: images[index]), for: UIControlState())
            button.setTitle(titles[index], for: UIControlState())
            button.setTitleColor(UIColor.black, for: UIControlState())
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.width = buttonW
            button.height = buttonH
            button.addTarget(self, action: #selector(shareButtonClick(_:)), for: .touchUpInside)
            
            // 计算 X、Y
            let row = Int(index / maxCols)
            let col = index % maxCols
            let buttonX: CGFloat = CGFloat(col) * (xMargin + buttonW) + buttonStartX
            let buttonMaxY: CGFloat = CGFloat(row) * buttonH
            let buttonY = buttonMaxY
            button.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH)
            addSubview(button)
        }
    }
    
    func shareButtonClick(_ button: UIButton) {
        if let shareButtonType = ShareButtonType(rawValue: button.tag) {
            switch shareButtonType {
            case .weChatTimeline:
                break
            case .weChatSession:
                break
            case .weibo:
                break
            case .qZone:
                break
            case .qqFriends:
                break
            case .copyLink:
                break
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ShareButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 调整图片
        imageView?.x = 10
        imageView?.y = 0
        imageView?.width = self.width - 20
        imageView?.height = imageView!.width
        // 调整文字
        titleLabel?.x = 0
        titleLabel?.y = imageView!.height - 8
        titleLabel?.width = self.width
        titleLabel?.height = self.height - self.titleLabel!.y
    }
    
}

