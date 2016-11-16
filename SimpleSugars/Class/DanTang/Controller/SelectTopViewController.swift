//
//  SelectTopViewController.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/8/24.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

let indicatorHeight = CGFloat(1.5)
let titleViewHeight = CGFloat(35)

class SelectTopViewController: BaseViewController {
    //标签数据
    var homeTopArray = [HomeTopDataModel]()
    // 标签
    weak var titlesView = UIView()
    //底部红色指示器
    weak var indicatorView = UIView()
    //
    weak var contentView = UIScrollView()
    // 当前选中的按钮
    weak var selectedButton = UIButton()
    //箭头
    var arrowButton = UIButton()
    
    var channelTitleView: ChannelTitleView!

    lazy var editChannelView: EditChannelView = {
        let editChannelView = EditChannelView(frame: CGRect(x: 0, y: 35, width: kScreenW, height: kScreenH - 35))
        editChannelView.backgroundColor = UIColor.white
        editChannelView.transform = CGAffineTransform(translationX: 0, y: -editChannelView.height)
        return editChannelView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        baseSetNavRightButtonWithImage("Feed_SearchBtn_18x18_")
        
        weak var weakSelf = self
        channelTitleView = ChannelTitleView.returnTitleView()
        channelTitleView.frame = CGRect(x: 0, y: 0, width: kScreenW - 35, height: 34.5)
        channelTitleView.backgroundColor = UIColor.white
        channelTitleView.isHidden = true
        channelTitleView.editChannelButton = {
            (button) -> Void in
            let isSelected = button.isSelected
            if isSelected {
                weakSelf?.channelTitleView.normalTitle()
                weakSelf?.editChannelView.normalChannel()
            } else {
                weakSelf?.channelTitleView.selectTitle()
                weakSelf?.editChannelView.editChannel()
            }
        }
        requestData()
    }
    
    override func baseNavRightButtonPressed(_ button: UIButton) {
        let search = SearchViewController()
        navigationController?.pushViewController(search, animated: true)
    }
    fileprivate func requestData()
    {
        let url = APPURLAPI.loadHomeTopData()
        GETRequestWithUrlString(url, success: { (response) in
            let array = response.data["channels"].arrayValue.map{
                HomeTopDataModel(jsonDic: $0) }
            self.homeTopArray.append(contentsOf: array)
            for i in 0..<self.homeTopArray.count
            {
                let item = self.homeTopArray[i]
                let vc = DanTangViewController()
                vc.title = item.name
                vc.type = item.id!
                if vc.title == "精选" {
                    vc.selectType = .select
                }
                else{
                    vc.selectType = .other
                }
                self.addChildViewController(vc)
            }
            //设置顶部标签栏
            self.setupTitlesView()
            // 底部的scrollview
            self.setupContentView()
            }) { (_) in
                
        }
    }
    
    /// 顶部标签栏
    func setupTitlesView() {
        // 顶部背景
        let bgView = UIView()
        view.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.width.equalTo(view.snp.width)
            make.top.left.equalTo(view)
            make.height.equalTo(35)
        }

        // 标签
        let titlesView = UIView()
        titlesView.backgroundColor = UIColor.white
        titlesView.frame = CGRect(x: 0, y: 0, width: kScreenW - titleViewHeight, height: titleViewHeight)
        bgView.addSubview(titlesView)
        self.titlesView = titlesView
        
        // 选择按钮
        arrowButton.frame = CGRect(x: kScreenW - titleViewHeight, y: 0, width: titleViewHeight, height: titleViewHeight)
        arrowButton.setImage(UIImage(named: "arrow_index_down_8x4_"), for: UIControlState())
        arrowButton.addTarget(self, action: #selector(arrowButtonClick(_:)), for: .touchUpInside)
        arrowButton.backgroundColor = UIColor.white
        bgView.addSubview(arrowButton)

        //底部分割线
        let lineView = UIView()
        lineView.backgroundColor = BaseColor.BorderColor
        bgView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(bgView.snp.left)
            make.width.equalTo(bgView.snp.width)
            make.bottom.equalTo(bgView.snp.bottom)
            make.height.equalTo(0.5)
        }

        //底部红色指示器
        let indicatorView = UIView()
        indicatorView.backgroundColor = BaseColor.RedColor
        indicatorView.height = indicatorHeight
        indicatorView.y = titleViewHeight - indicatorHeight - 0.5
        self.indicatorView = indicatorView
        
        //内部子标签
        let count = childViewControllers.count
        let width = titlesView.width / CGFloat(count)
        let height = titlesView.height
        
        for index in 0..<count {
            let button = UIButton()
            button.height = height
            button.width = width
            button.x = CGFloat(index) * width
            button.tag = index
            let vc = childViewControllers[index]
            button.titleLabel!.font = UIFont.systemFont(ofSize: 14)
            button.setTitle(vc.title!, for: UIControlState())
            button.setTitleColor(BaseColor.GrayColor, for: UIControlState())
            button.setTitleColor(BaseColor.RedColor, for: .disabled)
            button.addTarget(self, action: #selector(titlesClick(_:)), for: .touchUpInside)
            titlesView.addSubview(button)
            //默认点击了第一个按钮
            if index == 0 {
                button.isEnabled = false
                selectedButton = button
                //让按钮内部的Label根据文字来计算内容
                button.titleLabel?.sizeToFit()
                indicatorView.width = button.titleLabel!.width
                indicatorView.centerX = button.centerX
            }
        }
        //底部红色指示器
        titlesView.addSubview(indicatorView)
    }
    
    /// 箭头按钮点击
    func arrowButtonClick(_ button: UIButton) {
        let isSelected = button.isSelected
        UIView.animate(withDuration: 0.25, animations: {
            button.imageView?.transform = button.imageView!.transform.rotated(by: CGFloat(M_PI))
            if isSelected {
                self.editChannelView.transform = CGAffineTransform(translationX: 0, y: -self.editChannelView.height)
                self.channelTitleView.isHidden = true
                self.tabBarController?.tabBar.isHidden = false
            } else {
                self.editChannelView.normalChannel()
                self.editChannelView.transform = .identity
                self.channelTitleView.isHidden = false
                self.tabBarController?.tabBar.isHidden = true
            }
            self.channelTitleView.normalTitle()
            }) { (_) in
        }
        button.isSelected = !button.isSelected
    }
    
    /// 标签上的按钮点击
    func titlesClick(_ button: UIButton) {
        // 修改按钮状态
        selectedButton!.isEnabled = true
        button.isEnabled = false
        selectedButton = button
        // 让标签执行动画
        UIView.animate(withDuration: 0.25, animations: {
            self.indicatorView!.width = self.selectedButton!.titleLabel!.width
            self.indicatorView!.centerX = self.selectedButton!.centerX
        }) 
        //滚动,切换子控制器
        var offset = contentView!.contentOffset
        offset.x = CGFloat(button.tag) * contentView!.width
        contentView!.setContentOffset(offset, animated: true)
    }
    
    /// 底部的scrollview
    func setupContentView() {
        //不要自动调整inset
        automaticallyAdjustsScrollViewInsets = false
        
        let contentView = UIScrollView()
        contentView.frame = view.bounds
        contentView.delegate = self
        contentView.contentSize = CGSize(width: contentView.width * CGFloat(childViewControllers.count), height: 0)
        contentView.isPagingEnabled = true
        contentView.showsHorizontalScrollIndicator = false
        view.insertSubview(contentView, at: 0)
        self.contentView = contentView
        //添加第一个控制器的view
        scrollViewDidEndScrollingAnimation(contentView)

        view.addSubview(channelTitleView)
        editChannelView.channelTitles = homeTopArray
        view.insertSubview(editChannelView, aboveSubview: contentView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SelectTopViewController: UIScrollViewDelegate {
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        // 添加子控制器的 view
        // 当前索引
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        // 取出子控制器
        let vc = childViewControllers[index]
        vc.view.x = scrollView.contentOffset.x
        vc.view.y = 0 // 设置控制器的y值为0(默认为20)
        //设置控制器的view的height值为整个屏幕的高度（默认是比屏幕少20）
        vc.view.height = scrollView.height
        scrollView.addSubview(vc.view)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
        // 当前索引
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        // 点击 Button
        let button = titlesView!.subviews[index] as! UIButton
        titlesClick(button)
    }
}

