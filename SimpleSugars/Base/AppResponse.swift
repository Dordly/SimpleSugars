//
//  ProgressHUD.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/8/23.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

// 公用key
let kResponse_status_code = "code"
let kResponse_status_msg  = "message"
let kResponse_data        = "data"

class AppResponse: NSObject {
    
    var statusCode:String?
    var statusMsg:String?
    var dictResponse: NSDictionary?
    var data:JSON!
    
    override init() {
        super.init()
    }
    
    class func responseWithResponseDictionary(_ dictResponse : NSDictionary) -> AppResponse {
        let response = AppResponse()
        response.dictResponse = dictResponse
        if let data = dictResponse.object(forKey: kResponse_data) as? NSDictionary{
            response.data = JSON(data)
        }
        return response
    }
}
