//
//  SettingTableViewCell.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/9/2.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    var model: SettingDataModel? {
        didSet {
            iconImageView.image = UIImage(named: model!.iconImage!)
            leftLabel.text = model!.leftTitle
            rightLabel.text = model!.rightTitle
            disclosureIndicator.isHidden = model!.isHiddenRightTip!
            switchView.isHidden = model!.isHiddenSwitch!
        }
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var disclosureIndicator: UIImageView!
    @IBOutlet weak var switchView: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
