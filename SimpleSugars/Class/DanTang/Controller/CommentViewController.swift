//
//  CommentViewController.swift
//  SimpleSugars
//
//  Created by 苑伟 on 2016/11/10.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class CommentViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "评论"
        baseSetNavRightButtonWithTitle("完成")
        // Do any additional setup after loading the view.
    }
    
    override func baseNavRightButtonPressed(_ button: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
