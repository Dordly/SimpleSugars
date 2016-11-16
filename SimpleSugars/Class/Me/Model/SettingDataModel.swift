//
//  SettingDataModel.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/9/2.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class SettingDataModel: NSObject {

//    var iconImage: String?
//    var leftTitle: String?
//    var rightTitle: String?
//    var isHiddenSwitch: Bool?
//    var isHiddenRightTip: Bool?
//    
//    init(jsonDic: JSON?) {
//        if let jsonDic = jsonDic {
//            iconImage = jsonDic["iconImage"].stringValue
//            leftTitle = jsonDic["leftTitle"].stringValue
//            rightTitle = jsonDic["rightTitle"].stringValue
//            isHiddenSwitch = jsonDic["isHiddenSwitch"].boolValue
//            isHiddenRightTip = jsonDic["isHiddenRightTip"].boolValue
//        }
//    }
    
    var iconImage: String?
    var leftTitle: String?
    var rightTitle: String?
    var isHiddenSwitch: Bool?
    var isHiddenRightTip: Bool?
    
    init(dict: [String: AnyObject]) {
        super.init()
        iconImage = dict["iconImage"] as? String
        leftTitle = dict["leftTitle"] as? String
        rightTitle = dict["rightTitle"] as? String
        isHiddenSwitch = dict["isHiddenSwitch"] as? Bool
        isHiddenRightTip = dict["isHiddenRightTip"] as? Bool
    }
}
