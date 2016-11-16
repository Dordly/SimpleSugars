//
//  DanPinDataModel.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/8/29.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class DanPinDataModel: NSObject {

    var cover_image_url: String?
    var created_at: String?
    var describe: String?
    var editor_id: String?
    var favorites_count: String?
    var id: String?
    var image_urls: [String]?
    var is_favorite: Bool?
    var name: String?
    var price: String?
    var purchase_id: String?
    var purchase_status: String?
    var purchase_type: String?
    var purchase_url: String?
    var updated_at: String?
    var url: String?

    init(jsonDic: JSON?) {
        if let jsonDic = jsonDic {
            cover_image_url = jsonDic["cover_image_url"].stringValue
            created_at = jsonDic["created_at"].stringValue
            describe = jsonDic["description"].stringValue
            editor_id = jsonDic["editor_id"].stringValue
            favorites_count = jsonDic["favorites_count"].stringValue
            id = jsonDic["id"].stringValue
            image_urls = jsonDic["image_urls"].arrayObject as? [String]
            is_favorite = jsonDic["is_favorite"].boolValue
            name = jsonDic["name"].stringValue
            price = jsonDic["price"].stringValue
            purchase_id = jsonDic["purchase_id"].stringValue
            purchase_status = jsonDic["purchase_status"].stringValue
            purchase_type = jsonDic["purchase_type"].stringValue
            purchase_url = jsonDic["purchase_url"].stringValue
            updated_at = jsonDic["updated_at"].stringValue
            url = jsonDic["url"].stringValue
        }
    }
}
