//
//  CommentTableViewCell.swift
//  SimpleSugars
//
//  Created by 苑伟 on 2016/10/24.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        iconImageView.layer.cornerRadius = 15
        iconImageView.layer.masksToBounds = true
    }
    
    class func returnCellForRow(model: CommentDataModel) -> CommentTableViewCell {
        let cell = Bundle.main.loadNibNamed("CommentTableViewCell", owner: nil, options: nil)?.last as? CommentTableViewCell
        cell?.contentLabel.text = model.content
        cell?.iconImageView.sd_setImage(with: URL(string:(model.userDic?.avatar_url)!), placeholderImage: UIImage(named: "Me_AvatarPlaceholder_75x75_"))
        cell?.nickNameLabel.text = model.userDic?.nickname
        return cell!
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
