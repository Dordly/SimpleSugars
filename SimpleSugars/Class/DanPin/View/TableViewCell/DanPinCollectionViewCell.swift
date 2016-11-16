//
//  DanPinCollectionViewCell.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/8/29.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class DanPinCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    // 占位图片
    @IBOutlet weak var placeholderBtn: UIButton!
    // 背景图片
    @IBOutlet weak var productImageView: UIImageView!
    // 标题
    @IBOutlet weak var titleLabel: UILabel!
    // 价格
    @IBOutlet weak var priceLabel: UILabel!
    // 喜欢按钮
    @IBOutlet weak var likeButton: UIButton!

    var model: DanPinDataModel? {
        didSet
        {
            let url = URL(string: model!.cover_image_url!)
            productImageView.sd_setImage(with: url, placeholderImage: nil, options: .lowPriority) { (_, _, _, _) in
                self.placeholderBtn.isHidden = true
            }
            likeButton.setTitle(String(model!.favorites_count!), for: UIControlState())
            titleLabel.text = model!.name
            priceLabel.text = "￥" + String(model!.price!)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.borderColor = BaseColor.BorderColor.cgColor
        bgView.layer.borderWidth = 0.5
        bgView.layer.cornerRadius = 5
        
        // Initialization code
    }

}
