//
//  DetailBottomView.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/9/9.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

typealias detailLikeButtonClick = () -> Void
typealias detailGoBuyButtonClick = () -> Void

class DetailBottomView: UIView {

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var goBuyButton: UIButton!
    
    var likeButtonClick: detailLikeButtonClick?
    var goBuyButtonClick: detailGoBuyButtonClick?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        likeButton.layer.borderColor = BaseColor.RedColor.cgColor
        likeButton.layer.borderWidth = 1
        likeButton.setImage(UIImage(named: "content-details_like_16x16_"), for: UIControlState())
        likeButton.setImage(UIImage(named: "content-details_like_selected_16x16_"), for: .selected)
    }
    
    class func returnBottomView() -> DetailBottomView {
        let bottomView = Bundle.main.loadNibNamed("DetailBottomView", owner: nil
            , options: nil)!.last as! DetailBottomView
        return bottomView
    }
    
    @IBAction func selectButtonClick(_ sender: UIButton) {
        switch sender.tag {
        case 10: if likeButtonClick != nil { likeButtonClick!() }
        case 20: if goBuyButtonClick != nil { goBuyButtonClick!() }
        default:
            break
        }
    }
    
}
