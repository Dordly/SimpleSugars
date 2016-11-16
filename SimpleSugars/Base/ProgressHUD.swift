//
//  ProgressHUD.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/8/23.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class ProgressHUD: NSObject {
    
    static func show()
    {
        SVProgressHUD.show(withStatus: "正在加载")
        SVProgressHUD.setBackgroundColor(UIColor.black.withAlphaComponent(0.8))
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.setCornerRadius(12.0)
    }
    static func dismiss()
    {
        SVProgressHUD.dismiss()
    }
}
