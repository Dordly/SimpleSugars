//
//  MeViewController.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/8/24.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class MeViewController: BaseViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let headerView = MyHeaderView.returnHeaderView()
        view.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.top.left.equalTo(view)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(200)
        }
        headerView.messageButtonClick = {
            self.enterLogin()
        }
        headerView.settingButtonClick = {
            let vc = SettingViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        headerView.iconButtonClick = {
            self.enterLogin()
        }

        let selectView = MySelectView.returnSelectView()
        view.addSubview(selectView)
        selectView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom).offset(10)
            make.left.equalTo(view.snp.left)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(50)
        }
        
        let footerView = MyFooterView.returnFooterView()
        view.addSubview(footerView)
        footerView.snp.makeConstraints { (make) in
            make.top.equalTo(selectView.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.width.equalTo(view.snp.width)
            make.bottom.equalTo(view.snp.bottom)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
