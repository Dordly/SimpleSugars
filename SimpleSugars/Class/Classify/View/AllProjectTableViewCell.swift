//
//  AllProjectTableViewCell.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/9/2.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class AllProjectTableViewCell: UITableViewCell {

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var placeholderButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgImageView.layer.cornerRadius = 5
        bgImageView.layer.masksToBounds = true
    }
    
    var model: ProjectCollectionDataModel? {
        didSet {
            let url = model!.cover_image_url
            bgImageView.sd_setImage(with: URL(string: url!), placeholderImage: nil, options: .lowPriority) { (_, _, _, _) in
                self.placeholderButton.isHidden = true
            }
            titleLabel.text = model!.title
            subtitleLabel.text = model!.subtitle
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
