//
//  GoodDetailDataModel.swift
//  SimpleSugars
//
//  Created by 苑伟 on 2016/10/28.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class GoodDetailDataModel: NSObject {
    
    var favorites_count: String?
    var comments_count: String?
    var brand_order: String?
    var favorited: Bool?
    var id: String?
    var image_urls: [String]?
    var purchase_url: String?
    var url: String?
    var name: String?
    var updated_at: String?
    var purchase_type: String?
    var likes_count: String?
    var cover_image_url: String?
    var desc: String?
    var editor_id: String?
    var purchase_status: String?
    var price: String?
    var liked: Bool?
    var shares_count: String?
    var created_at: String?
    var purchase_id: String?
    var detail_html: String?
    
    init(jsonDic: JSON?) {
        if let jsonDic = jsonDic {
            favorites_count = jsonDic["favorites_count"].stringValue
            comments_count = jsonDic["comments_count"].stringValue
            brand_order = jsonDic["brand_order"].stringValue
            favorited = jsonDic["favorited"].boolValue
            id = jsonDic["id"].stringValue
            image_urls = jsonDic["image_urls"].arrayObject as? [String]
            purchase_url = jsonDic["purchase_url"].stringValue
            url = jsonDic["url"].stringValue
            name = jsonDic["name"].stringValue
            updated_at = jsonDic["updated_at"].stringValue
            purchase_type = jsonDic["purchase_type"].stringValue
            likes_count = jsonDic["likes_count"].stringValue
            cover_image_url = jsonDic["cover_image_url"].stringValue
            desc = jsonDic["description"].stringValue
            editor_id = jsonDic["editor_id"].stringValue
            purchase_status = jsonDic["purchase_status"].stringValue
            price = jsonDic["price"].stringValue
            liked = jsonDic["liked"].boolValue
            shares_count = jsonDic["shares_count"].stringValue
            created_at = jsonDic["created_at"].stringValue
            detail_html = jsonDic["detail_html"].stringValue
            purchase_id = jsonDic["purchase_id"].stringValue
        }
    }
}
