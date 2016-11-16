//
//  BaseViewController.swift
//  CustomSlideBackGesture
//
//  Created by 苑伟 on 16/8/23.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit


enum Direction : String {
    case left, right
}

class BaseViewController: UIViewController {
    
    /// 是否登录
    var isLogin: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BaseColor.BackGroundColor
        navigationController?.fd_prefersNavigationBarHidden = true
        self.edgesForExtendedLayout = UIRectEdge()

        // Do any additional setup after loading the view.
    }
    
    func enterLogin() {
        let login = LoginViewController.initFromNib()
        let nav = BaseNavigationController(rootViewController: login)
        present(nav, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension BaseViewController
{
    //设置左边item以及返回方式
    func baseSetNavLeftButtonIsBack()
    {
        baseSetNavButtonWith(nil, imageName: "app_b_back", button: nil, direction: .left, tag: 100)
    }
    func baseSetNavLeftButtonIsDismiss()
    {
        baseSetNavButtonWith(nil, imageName: "app_b_back", button: nil, direction: .left, tag: 200)
    }
    //左边按钮点击方法
    func baseNavLeftButtonPressed(_ button : UIButton)
    {
        switch button.tag
        {
            case 100:
                _ = navigationController?.popViewController(animated: true)
            case 200:
                _ = dismiss(animated: true, completion: nil)
            default: break
        }
    }
    // 设置左边
    func baseSetNavLeftButtonWithTitle(_ title : String) {
        baseSetNavButtonWith(title, imageName: nil, button: nil, direction: .left, tag : 0)
    }
    func baseSetNavLeftButtonWithImage(_ imageName :String) {
        baseSetNavButtonWith(nil, imageName: imageName, button: nil, direction: .left, tag : 0)
    }
    func baseSetNavLeftButtonWithButton(_ button : UIButton) {
        baseSetNavButtonWith(nil, imageName: nil, button: button, direction: .left, tag : 0)
    }
    
    // 设置右边
    func baseSetNavRightButtonWithTitle(_ title : String) {
        self.baseSetNavButtonWith(title, imageName: nil, button: nil, direction: .right, tag: 0)
    }
    func baseSetNavRightButtonWithImage(_ imageName : String) {
        self.baseSetNavButtonWith(nil, imageName: imageName, button: nil, direction: .right, tag : 0)
    }
    func baseSetNavRightButtonWithButton(_ button : UIButton) {
        self.baseSetNavButtonWith(nil, imageName: nil, button: button, direction: .right, tag : 0)
    }
    //右边按钮点击方法
    func baseNavRightButtonPressed(_ button : UIButton){
        
    }

    // 默认设置导航栏左右按钮
    fileprivate func baseSetNavButtonWith(_ title : String?, imageName : String?, button : UIButton?, direction : Direction, tag : Int){
        
        var btn : UIButton! = UIButton(type: .custom)
        var action : Selector? = nil
        switch direction{
        case .left :
            action = #selector(self.baseNavLeftButtonPressed(_:))
        case .right :
            action = #selector(self.baseNavRightButtonPressed(_:))
        }
        if title != nil {
            btn.setTitle(title, for: UIControlState())
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            btn.setTitleColor(UIColor.white, for: UIControlState())
            btn.addTarget(self, action: action!, for: .touchUpInside)
        }
        if imageName != nil {
            btn.setImage(UIImage(named: imageName!), for: UIControlState())
            btn.addTarget(self, action: action!, for: .touchUpInside)
        }
        if button != nil {
            btn = button
        }
        btn.tag = tag
        btn.sizeToFit()
        let barItem = UIBarButtonItem(customView: btn)
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target:nil, action: nil)
        
        switch direction {
        case .left :
            navigationItem.leftBarButtonItems = [spaceItem,barItem]
        case .right:
            navigationItem.rightBarButtonItems = [barItem,spaceItem]
        }
    }
}
