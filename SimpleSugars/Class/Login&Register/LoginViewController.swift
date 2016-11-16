//
//  AppDelegate.swift
//  CustomSlideBackGesture
//
//  Created by 苑伟 on 16/8/23.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    /// 手机号
    @IBOutlet weak var mobileField: UITextField!
    /// 密码
    @IBOutlet weak var passwordField: UITextField!
    /// 登录按钮
    @IBOutlet weak var loginButton: UIButton!
    /// 忘记密码按钮
    @IBOutlet weak var forgetPwdBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "登录"
        baseSetNavLeftButtonWithTitle("取消")
        baseSetNavRightButtonWithTitle("注册")
    }
    
    override func baseNavLeftButtonPressed(_ button: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func baseNavRightButtonPressed(_ button: UIButton) {
        let registerVC = RegisterViewController.initFromNib()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
