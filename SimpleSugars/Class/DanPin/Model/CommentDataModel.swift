//
//  CommentDataModel.swift
//  SimpleSugars
//
//  Created by 苑伟 on 2016/10/24.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class CommentDataModel: NSObject {
    
    var status: String?
    var content: String?
    var reply_to_id: String?
    var id: String?
    var created_at: String?
    var show: String?
    var item_id: String?
    var userDic: UserDataModel?
    init(jsonDic: JSON?) {
        if let jsonDic = jsonDic {
            status = jsonDic["status"].stringValue
            created_at = jsonDic["created_at"].stringValue
            content = jsonDic["content"].stringValue
            reply_to_id = jsonDic["reply_to_id"].stringValue
            id = jsonDic["id"].stringValue
            show = jsonDic["show"].stringValue
            item_id = jsonDic["item_id"].stringValue
            userDic = UserDataModel(jsonDic: jsonDic["user"])
        }
    }
}

class UserDataModel: NSObject {
    var guest_uuid: String?
    var avatar_url: String?
    var nickname: String?
    var id: String?
    var role: String?
    var can_mobile_login: String?
    init(jsonDic: JSON?) {
        if let jsonDic = jsonDic {
            guest_uuid = jsonDic["guest_uuid"].stringValue
            avatar_url = jsonDic["avatar_url"].stringValue
            nickname = jsonDic["nickname"].stringValue
            role = jsonDic["role"].stringValue
            id = jsonDic["id"].stringValue
            can_mobile_login = jsonDic["can_mobile_login"].stringValue
        }
    }
}
