//
//  AppDelegate.swift
//  CustomSlideBackGesture
//
//  Created by 苑伟 on 16/8/23.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {

    @IBOutlet weak var mobileField: UITextField!
    @IBOutlet weak var vertifyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "注册"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
