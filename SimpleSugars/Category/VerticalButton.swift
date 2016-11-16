//
//  VerticalButton.swift
//  SimpleSugars
//
//  Created by 苑伟 on 2016/10/27.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class VerticalButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var center = self.imageView?.center
        center?.x = self.frame.size.width/2
        center?.y = (self.imageView?.frame.size.height)!/2
        self.imageView?.center = center!
        
        //Center text
        var newFrame = self.titleLabel?.frame
        newFrame?.origin.x = 3
        newFrame?.origin.y = (self.imageView?.frame.size.height)! + 5
        newFrame?.size.width = self.frame.size.width
        self.titleLabel?.frame = newFrame!
        self.titleLabel?.textAlignment = .center
        self.imageView?.contentMode = .center
    }
}
