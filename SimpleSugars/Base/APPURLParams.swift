//
//  APPURLParams.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/8/24.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class APPURLParams: NSObject {
    
    override init() {
        super.init()
    }
    var action : String?
    var params : String?

    class func urlWithAction(_ action : String,params : String) -> APPURLParams
    {
        let url = APPURLParams()
        url.action = action
        url.params = params
        return url
    }
}
