//
//  NSObject+Addtionss.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/8/24.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit
import Alamofire

// 全局设置获取关联对象
private var asskey:UInt8 = 0

/// 服务器地址
let BASE_URL = "http://api.dantangapp.com/"

extension NSObject {

    func Base_setUserInfo(obj_:NSObject,value:AnyObject) {
        obj_.setAssociatedObject(obj: value, key: &asskey)
    }
    func Base_getUserInfo(obj_:NSObject) -> AnyObject {
        return obj_.associatedObjectForKey(key: &asskey) ?? NSNull()
    }

    /// 设置关联对象
    func setAssociatedObject(obj:AnyObject,key:UnsafeRawPointer) {
        objc_setAssociatedObject(self, key, obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    /// 获取关联对象
    func associatedObjectForKey(key:UnsafeRawPointer) -> AnyObject? {
        return objc_getAssociatedObject(self, key) as AnyObject?
    }

    // GET请求
    func GETRequestWithUrlString(_ urlString : APPURLParams, success : ((AppResponse) ->Void)?, failure: ((NSError) ->Void)!)
    {
        RequestWithUrlString(urlString, method:.get,success: success, failure: failure)
    }
    
    // POST请求
    func POSTRequestWithUrlString(_ urlString : APPURLParams, success : ((AppResponse) ->Void)?, failure: ((NSError) ->Void)!)
    {
        RequestWithUrlString(urlString, method:.post, success: success, failure: failure)
    }

    fileprivate func RequestWithUrlString(_ urlString : APPURLParams, method: Alamofire.HTTPMethod, success : ((AppResponse) ->Void)?, failure: ((NSError) ->Void)?) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        ProgressHUD.show()
        
        let paramString = urlString.params
        let queryArray = paramString?.components(separatedBy: "&")
        var dic = [String: AnyObject]()
        for queryStr in queryArray! {
            let queryArriArray = queryStr.components(separatedBy: "=")
            if queryArriArray.count == 2
            {
                let key = queryArriArray[0]
                let value = queryArriArray[1].removingPercentEncoding
                dic[key] = value as AnyObject?
            }
        }

        Alamofire.request(BASE_URL + urlString.action!, method: method, parameters: dic)
        .responseJSON { (response) in
                ProgressHUD.dismiss()
                switch response.result
                {
                    case .success(let value):
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let success = success{
                            success(self.convertDataToObject(value as AnyObject?))
                        }
                    case .failure(_):
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if let failure = failure{
                            if let error = response.result.error {
                                failure(error as NSError)
                            }
                        }
                }
            }
    }
    fileprivate func convertDataToObject(_ responseData :AnyObject?) -> AppResponse {
        // 打印请求结果
        guard let dict = responseData as? NSDictionary else { return AppResponse() }
        return AppResponse.responseWithResponseDictionary(dict)
    }
}
