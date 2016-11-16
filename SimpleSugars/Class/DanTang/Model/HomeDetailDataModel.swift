//
//  HomeDetailDataModel.swift
//  SimpleSugars
//
//  Created by 苑伟 on 2016/10/27.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class HomeDetailDataModel: NSObject {

    var published_at: String?
    var cover_image_url: String?
    var updated_at: String?
    var likes_count: String?
    var share_msg: String?
    var comments_count: String?
    var content_url: String?
    var status: String?
    var short_title: String?
    var liked: String?
    var id: String?
    var title: String?
    var shares_count: String?
    var content_html: String?

    init(jsonDic: JSON?) {
        if let jsonDic = jsonDic {
            published_at = jsonDic["published_at"].stringValue
            cover_image_url = jsonDic["cover_image_url"].stringValue
            updated_at = jsonDic["updated_at"].stringValue
            likes_count = jsonDic["likes_count"].stringValue
            share_msg = jsonDic["share_msg"].stringValue
            comments_count = jsonDic["comments_count"].stringValue
            content_url = jsonDic["content_url"].stringValue
            status = jsonDic["status"].stringValue
            short_title = jsonDic["short_title"].stringValue
            liked = jsonDic["liked"].stringValue
            id = jsonDic["id"].stringValue
            title = jsonDic["title"].stringValue
            shares_count = jsonDic["shares_count"].stringValue
            content_html = jsonDic["content_html"].stringValue
        }
    }
}
