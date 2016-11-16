//
//  ClassifyDataModel.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/8/31.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class ProjectCollectionDataModel: NSObject {
    
    var status: String?
    var banner_image_url: String?
    var subtitle: String?
    var id: String?
    var created_at: String?
    var title: String?
    var cover_image_url: String?
    var updated_at: String?
    var posts_count: String?
    init(jsonDic: JSON?) {
        if let jsonDic = jsonDic {
            status = jsonDic["status"].stringValue
            banner_image_url = jsonDic["banner_image_url"].stringValue
            subtitle = jsonDic["subtitle"].stringValue
            id = jsonDic["id"].stringValue
            created_at = jsonDic["created_at"].stringValue
            title = jsonDic["title"].stringValue
            cover_image_url = jsonDic["cover_image_url"].stringValue
            updated_at = jsonDic["updated_at"].stringValue
            posts_count = jsonDic["posts_count"].stringValue
        }
    }
}

class ChannelGroupsDataModel: NSObject{
    
    var status: String?
    var id: String?
    var order: String?
    var name: String?
    var channels = [ChannelsDataModel]()
    
    init(jsonDic: JSON?) {
        if let jsonDic = jsonDic {
            status = jsonDic["status"].stringValue
            id = jsonDic["id"].stringValue
            order = jsonDic["order"].stringValue
            name = jsonDic["name"].stringValue
            channels = jsonDic["channels"].arrayValue.map{ json in ChannelsDataModel(jsonDic:json) }
        }
    }
}

class ChannelsDataModel: NSObject {
    
    var status: String?
    var group_id: String?
    var id: String?
    var items_count: String?
    var order: String?
    var icon_url: String?
    var name: String?

    init(jsonDic: JSON?) {
        if let jsonDic = jsonDic {
            status = jsonDic["status"].stringValue
            group_id = jsonDic["group_id"].stringValue
            id = jsonDic["id"].stringValue
            items_count = jsonDic["items_count"].stringValue
            order = jsonDic["order"].stringValue
            icon_url = jsonDic["icon_url"].stringValue
            name = jsonDic["name"].stringValue
        }
    }
}
