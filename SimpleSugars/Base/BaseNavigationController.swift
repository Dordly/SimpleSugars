//
//  BaseNavigationController.swift
//  CustomSlideBackGesture
//
//  Created by 苑伟 on 16/8/23.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController
{
    internal override class func initialize() {
        super.initialize()
        /// 设置导航栏标题
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = BaseColor.RedColor
        navBar.tintColor = UIColor.white
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 18)]
    }

    /**
     # 统一所有控制器导航栏左上角的返回按钮
     # 让所有push进来的控制器，它的导航栏左上角的内容都一样
     # 能拦截所有的push操作
     - parameter viewController: 需要压栈的控制器
     - parameter animated:       是否动画
     */
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        /// 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        if viewControllers.count > 0 {
            // push 后隐藏 tabbar
            viewController.hidesBottomBarWhenPushed = true
//            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "app_b_back"), style: .Plain, target: self, action: #selector(navigationBackClick))
        }
        super.pushViewController(viewController, animated: true)
    }
    /// 返回按钮
    func navigationBackClick() {
        _ = popViewController(animated: true)
    }
}
