//
//  HomeDetailWebFooterView.swift
//  SimpleSugars
//
//  Created by 苑伟 on 2016/10/27.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

typealias footerViewLikeButtonClick = () -> Void
typealias footerViewShareButtonClick = () -> Void
typealias footerViewCommentButtonClick = () -> Void

class HomeDetailWebFooterView: UIView {

    var likeButtonClick: footerViewLikeButtonClick?
    var shareButtonClick: footerViewShareButtonClick?
    var commentButtonClick: footerViewCommentButtonClick?
    
    lazy var likeButton: VerticalButton = {
        let likeButton = VerticalButton(type: .custom)
        likeButton.tag = 10
        likeButton.frame = CGRect(x: 0, y: 0, width: kScreenW/3, height: 50)
        likeButton.backgroundColor = UIColor.clear
        likeButton.setTitle("喜欢", for: .normal)
        likeButton.setImage(UIImage(named: "Post_FavoriteButton_50x50_"), for: .normal)
        likeButton.setImage(UIImage(named: "Post_FavoriteButton_Highlighted_50x50_"), for: .highlighted)
        likeButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        likeButton.setTitleColor(BaseColor.RedColor, for: .normal)
        return likeButton
    }()
    
    lazy var shareButton: VerticalButton = {
        let shareButton = VerticalButton(type: .custom)
        shareButton.tag = 20
        shareButton.frame = CGRect(x: kScreenW/3, y: 0, width: kScreenW/3, height: 50)
        shareButton.backgroundColor = UIColor.clear
        shareButton.setTitle("分享", for: .normal)
        shareButton.setImage(UIImage(named: "Post_ShareButton_50x50_"), for: .normal)
        shareButton.setImage(UIImage(named: "Post_ShareButton_Highlighted_50x50_"), for: .highlighted)
        shareButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        shareButton.setTitleColor(BaseColor.RedColor, for: .normal)
        return shareButton
    }()
    
    lazy var commentButton: VerticalButton = {
        let commentButton = VerticalButton(type: .custom)
        commentButton.tag = 30
        commentButton.frame = CGRect(x: (kScreenW/3)*2, y: 0, width: kScreenW/3, height: 50)
        commentButton.backgroundColor = UIColor.clear
        commentButton.setTitle("评论", for: .normal)
        commentButton.setImage(UIImage(named: "Post_ReplyButton_50x50_"), for: .normal)
        commentButton.setImage(UIImage(named: "Post_ReplyButton_Highlighted_50x50_"), for: .highlighted)
        commentButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        commentButton.setTitleColor(BaseColor.RedColor, for: .normal)
        return commentButton
    }()
    
    lazy var likeLabel: UILabel = {
        let likeLabel = UILabel(frame: CGRect(x: 0, y: 70, width: kScreenW/3, height: 20))
        likeLabel.textColor = BaseColor.LightGrayColor
        likeLabel.textAlignment = .center
        likeLabel.font = UIFont.systemFont(ofSize: 12)
        return likeLabel
    }()
    lazy var shareLabel: UILabel = {
        let shareLabel = UILabel(frame: CGRect(x: kScreenW/3, y: 70, width: kScreenW/3, height: 20))
        shareLabel.textColor = BaseColor.LightGrayColor
        shareLabel.textAlignment = .center
        shareLabel.font = UIFont.systemFont(ofSize: 12)
        return shareLabel
    }()
    lazy var commentLabel: UILabel = {
        let commentLabel = UILabel(frame: CGRect(x: (kScreenW/3)*2, y: 70, width: kScreenW/3, height: 20))
        commentLabel.textColor = BaseColor.LightGrayColor
        commentLabel.textAlignment = .center
        commentLabel.font = UIFont.systemFont(ofSize: 12)
        return commentLabel
    }()
    
    class func returnFooterView() -> HomeDetailWebFooterView {
        
        let footerView = HomeDetailWebFooterView()
        footerView.backgroundColor = UIColor.HexColor(0xF9F9F9)
        footerView.addSubview(footerView.likeButton)
        footerView.addSubview(footerView.shareButton)
        footerView.addSubview(footerView.commentButton)
        footerView.likeButton.addTarget(footerView, action: #selector(footerView.selectButtonClick(button:)), for: .touchUpInside)
        footerView.shareButton.addTarget(footerView, action: #selector(footerView.selectButtonClick(button:)), for: .touchUpInside)
        footerView.commentButton.addTarget(footerView, action: #selector(footerView.selectButtonClick(button:)), for: .touchUpInside)
        footerView.addSubview(footerView.likeLabel)
        footerView.addSubview(footerView.shareLabel)
        footerView.addSubview(footerView.commentLabel)
        return footerView
    }
    
    func selectButtonClick(button: VerticalButton) {
        switch button.tag {
        case 10: if likeButtonClick != nil { likeButtonClick!() }
        case 20: if shareButtonClick != nil { shareButtonClick!() }
        case 30: if commentButtonClick != nil { commentButtonClick!() }
        default:
            break
        }
    }
}
