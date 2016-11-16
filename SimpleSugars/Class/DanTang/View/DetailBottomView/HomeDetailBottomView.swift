//
//  HomeDetailBottomView.swift
//  SimpleSugars
//
//  Created by 苑伟 on 2016/10/27.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

typealias bottomViewLikeButtonClick = () -> Void
typealias bottomViewShareButtonClick = () -> Void
typealias bottomViewCommentButtonClick = () -> Void

class HomeDetailBottomView: UIView {
    
    var likeButtonClick: bottomViewLikeButtonClick?
    var shareButtonClick: bottomViewShareButtonClick?
    var commentButtonClick: bottomViewCommentButtonClick?

    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = BaseColor.BorderColor
        return lineView
    }()
    
    lazy var vLeftLineView: UIView = {
        let vLeftLineView = UIView()
        vLeftLineView.backgroundColor = BaseColor.BorderColor
        return vLeftLineView
    }()

    lazy var vrightLineView: UIView = {
        let vrightLineView = UIView()
        vrightLineView.backgroundColor = BaseColor.BorderColor
        return vrightLineView
    }()


    lazy var likeButton: UIButton = {
        let likeButton = UIButton(type: .custom)
        likeButton.tag = 10
        likeButton.backgroundColor = UIColor.clear
        likeButton.setImage(UIImage(named: "PostItem_Like_18x16_"), for: .normal)
        likeButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        likeButton.setTitleColor(BaseColor.LightGrayColor, for: .normal)
        likeButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return likeButton
    }()
    
    lazy var shareButton: UIButton = {
        let shareButton = UIButton(type: .custom)
        shareButton.tag = 20
        shareButton.backgroundColor = UIColor.clear
        shareButton.setImage(UIImage(named: "Post_ShareIcon_15x16_"), for: .normal)
        shareButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        shareButton.setTitleColor(BaseColor.LightGrayColor, for: .normal)
        shareButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return shareButton
    }()
    
    lazy var commentButton: UIButton = {
        let commentButton = UIButton(type: .custom)
        commentButton.tag = 30
        commentButton.backgroundColor = UIColor.clear
        commentButton.setImage(UIImage(named: "Post_CommentIcon_15x16_"), for: .normal)
        commentButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        commentButton.setTitleColor(BaseColor.LightGrayColor, for: .normal)
        commentButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        commentButton.tintColor = BaseColor.RedColor
        return commentButton
    }()
    
    class func returnBottomView() -> HomeDetailBottomView
    {
        let bottomView = HomeDetailBottomView()
        bottomView.backgroundColor = UIColor.white
        
        bottomView.addSubview(bottomView.lineView)
        bottomView.lineView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(bottomView)
            make.height.equalTo(0.5)
        }
        bottomView.likeButton.addTarget(bottomView, action: #selector(bottomView.selectButtonClick(button:)), for: .touchUpInside)
        bottomView.addSubview(bottomView.likeButton)
        bottomView.likeButton.snp.makeConstraints { (make) in
            make.left.equalTo(bottomView.snp.left)
            make.top.equalTo(bottomView.lineView.snp.bottom)
            make.height.equalTo(bottomView.snp.height)
            make.width.equalTo(bottomView.snp.width).multipliedBy(1.0/3)
        }
        bottomView.shareButton.addTarget(bottomView, action: #selector(bottomView.selectButtonClick(button:)), for: .touchUpInside)
        bottomView.addSubview(bottomView.shareButton)
        bottomView.shareButton.snp.makeConstraints { (make) in
            make.left.equalTo(bottomView.likeButton.snp.right)
            make.top.equalTo(bottomView.likeButton.snp.top)
            make.height.equalTo(bottomView.snp.height)
            make.width.equalTo(bottomView.snp.width).multipliedBy(1.0/3)
        }
        bottomView.commentButton.addTarget(bottomView, action: #selector(bottomView.selectButtonClick(button:)), for: .touchUpInside)
        bottomView.addSubview(bottomView.commentButton)
        bottomView.commentButton.snp.makeConstraints { (make) in
            make.left.equalTo(bottomView.shareButton.snp.right)
            make.top.equalTo(bottomView.likeButton.snp.top)
            make.height.equalTo(bottomView.snp.height)
            make.width.equalTo(bottomView.snp.width).multipliedBy(1.0/3)
        }
        bottomView.addSubview(bottomView.vLeftLineView)
        bottomView.vLeftLineView.snp.makeConstraints { (make) in
            make.left.equalTo(bottomView.likeButton.snp.right)
            make.height.equalTo(20)
            make.width.equalTo(0.5)
            make.centerY.equalTo(bottomView.snp.centerY)
        }
        bottomView.addSubview(bottomView.vrightLineView)
        bottomView.vrightLineView.snp.makeConstraints { (make) in
            make.left.equalTo(bottomView.shareButton.snp.right)
            make.height.equalTo(20)
            make.width.equalTo(0.5)
            make.centerY.equalTo(bottomView.snp.centerY)
        }

        return bottomView
    }
    
    func selectButtonClick(button: UIButton) {
        switch button.tag {
        case 10: if likeButtonClick != nil { likeButtonClick!() }
        case 20: if shareButtonClick != nil { shareButtonClick!() }
        case 30: if commentButtonClick != nil { commentButtonClick!() }
        default:
            break
        }
    }

}
