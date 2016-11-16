//
//  BaseTabBarController.swift
//  CustomSlideBackGesture
//
//  Created by 苑伟 on 16/8/23.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = BaseColor.RedColor
        // Do any additional setup after loading the view.
        addChildViewControllers()
    }
    
    /**
     # 添加子控制器
     */
    fileprivate func addChildViewControllers() {
        addChildViewController("SelectTopViewController", title: "单糖", imageName: "TabBar_home_23x23_")
        addChildViewController("DanPinViewController", title: "单品", imageName: "TabBar_gift_23x23_")
        addChildViewController("ClassifyViewController", title: "分类", imageName: "TabBar_category_23x23_")
        addChildViewController("MeViewController", title: "我", imageName: "TabBar_me_boy_23x23_")
    }
    /**
     # 初始化子控制器
     - parameter childControllerName: 需要初始化的控制器
     - parameter title:               标题
     - parameter imageName:           图片名称
     */
    fileprivate func addChildViewController(_ childControllerName: String, title: String, imageName: String) {
        // 动态获取命名空间
        let ns = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        // 将字符串转化为类，默认情况下命名空间就是项目名称，但是命名空间可以修改
        let cls: AnyClass? = NSClassFromString(ns + "." + childControllerName)
        let vcClass = cls as! UIViewController.Type
        let vc = vcClass.init()
        vc.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "selected")?.withRenderingMode(.alwaysOriginal)
        vc.title = title
//        let attr = [NSForegroundColorAttributeName:BaseColor.LightGrayColor]
//        let selectedAttr = [NSForegroundColorAttributeName:BaseColor.RedColor]
//        vc.tabBarItem.setTitleTextAttributes(attr, forState: .Normal)
//        vc.tabBarItem.setTitleTextAttributes(selectedAttr, forState: .Selected)

        // 给每个控制器包装一个导航控制器
        let nav = BaseNavigationController()
        nav.addChildViewController(vc)
        addChildViewController(nav)
    }
}
