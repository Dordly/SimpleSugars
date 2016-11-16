//
//  AppBaseVC.swift
//  SimpleSugars
//
//  Created by heew on 16/1/27.
//  Copyright © 2016年 . All rights reserved.
//

import UIKit
extension UIViewController {
    
    class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last! as String
    }
    
    // 从nib中加载
    class func initFromNib() -> Self {
        let hasNib: Bool = Bundle.main.path(forResource: self.nameOfClass, ofType: "nib") != nil
        guard hasNib else {
            assert(!hasNib, "Invalid parameter") // here
            return self.init() 
        }
        return self.init(nibName: self.nameOfClass, bundle: nil)
    }
}
