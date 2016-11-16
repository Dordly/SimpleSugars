//
//  HomeDataModel.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/8/24.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class HomeDataModel: NSObject {

    var content_url: String?
    var cover_image_url: String?
    var created_at: String?
    var id: String?
    var liked: String?
    var likes_count: String?
    var share_msg: String?
    var published_at: String?
    var short_title: String?
    var status: String?
    var type: String?
    var title: String?
    var template: String?
    var updated_at: String?
    var url: String?
    init(jsonDic: JSON?) {
        if let jsonDic = jsonDic {
            content_url = jsonDic["content_url"].stringValue
            cover_image_url = jsonDic["cover_image_url"].stringValue
            created_at = jsonDic["created_at"].stringValue
            id = jsonDic["id"].stringValue
            liked = jsonDic["liked"].stringValue
            likes_count = jsonDic["likes_count"].stringValue
            share_msg = jsonDic["share_msg"].stringValue
            published_at = jsonDic["published_at"].stringValue
            short_title = jsonDic["short_title"].stringValue
            status = jsonDic["status"].stringValue
            type = jsonDic["type"].stringValue
            title = jsonDic["title"].stringValue
            template = jsonDic["template"].stringValue
            updated_at = jsonDic["updated_at"].stringValue
            url = jsonDic["url"].stringValue
        }
    }
}

class HomeTopDataModel: NSObject
{
    var editable: Bool?
    var id: String?
    var name: String?
    
    init(jsonDic: JSON?) {
        if let jsonDic = jsonDic {
            editable = jsonDic["editable"].boolValue
            id = jsonDic["id"].stringValue
            name = jsonDic["name"].stringValue
        }
    }
}

class BannerDataModel: NSObject
{
    var channel: String?
    var id: String?
    var image_url: String?
    var order: String?
    var status: String?
    var type: String?
    var target_id: String?
    var target_url: String?
    var target: TargetDataModel!
    
    init(jsonDic: JSON?) {
        if let jsonDic = jsonDic {
            channel = jsonDic["channel"].stringValue
            id = jsonDic["id"].stringValue
            image_url = jsonDic["image_url"].stringValue
            order = jsonDic["order"].stringValue
            status = jsonDic["status"].stringValue
            type = jsonDic["type"].stringValue
            target_id = jsonDic["target_id"].stringValue
            target_url = jsonDic["target_url"].stringValue
            target = TargetDataModel(jsonDic: jsonDic["target"])
        }
    }
}

class TargetDataModel: NSObject
{
    var id: String?
    var banner_image_url: String?
    var cover_image_url: String?
    var status: String?
    var created_at: String?
    var posts_count: String?
    var subtitle: String?
    var title: String?
    var updated_at: String?

    init(jsonDic: JSON?) {
        if let jsonDic = jsonDic {
            id = jsonDic["id"].stringValue
            status = jsonDic["status"].stringValue
            banner_image_url = jsonDic["banner_image_url"].stringValue
            cover_image_url = jsonDic["cover_image_url"].stringValue
            created_at = jsonDic["created_at"].stringValue
            posts_count = jsonDic["posts_count"].stringValue
            subtitle = jsonDic["subtitle"].stringValue
            title = jsonDic["title"].stringValue
            updated_at = jsonDic["updated_at"].stringValue
        }
    }
}

