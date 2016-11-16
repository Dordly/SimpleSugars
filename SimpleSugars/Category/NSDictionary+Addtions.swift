//
//  NSDictionary+Addtions.swift
//  CQQ
//
//  Created by 苑伟 on 16/8/24.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

extension NSDictionary {
    
    func stringForKey(_ Key : NSString!) -> NSString {
        if let value : AnyObject  = self.object(forKey: Key) as AnyObject? {
            if !value.isKind(of: NSNull.self) {
                return value.description as NSString
            }
        }
        return ""
    }
    
    func intForKey(_ Key: NSString!) -> Int {
        if let value: AnyObject = self.object(forKey: Key) as AnyObject?
        {
            if value.isKind(of: NSNumber.self) {
                return value as! Int
            }
        }
        return 0
    }
    
    func boolForKey(_ Key: NSString!) -> Bool {
        if let value : AnyObject = self.object(forKey: Key) as? Bool as AnyObject? {
            return value as! Bool
        }
        return false
    }
    
    func arrayForKey(_ key: AnyObject) -> NSArray {
        if let value: AnyObject = self.object(forKey: key) as AnyObject?
        {
            if value.isKind(of: NSArray.self)
            {
                return value as! NSArray
            }
            else if value.isKind(of: NSString.self) || value.isKind(of: NSDictionary.self)
            {
                return [value]
            }
        }
        return []
    }
}
