//
//  DanPinDetailViewController.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/9/9.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class DanPinDetailViewController: BaseViewController,UIScrollViewDelegate {

    fileprivate var isTopIsCanNotMoveTabView: Bool = false
    fileprivate var isTopIsCanNotMoveTabViewPre: Bool = false
    fileprivate var canScroll: Bool = false
    var model: DanPinDataModel!
    var goodID = ""
    var goodDetailDataModel: GoodDetailDataModel!
    
    var tableHeaderView: DetailHeaderView!
    var tableViewHeaderHeight: CGFloat = 0.0
    var containerHeight: CGFloat = 0 //顶部高度
    var commentListArray = [CommentDataModel]()
    
    var contentOfset: CGFloat = 0.0
    
    //评论页面
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    //详情页面
    lazy var webView: UIWebView = {
        let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH - 44 - 64))
        webView.backgroundColor = BaseColor.BackGroundColor
        webView.isOpaque = false
        webView.scrollView.delegate = self
        return webView
    }()
    //滚动视图
    lazy var containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()

    //选择标签
    lazy var segmentView: SegmentView = {
        let segmentView = SegmentView.segmentView()
        segmentView.backgroundColor = BaseColor.BackGroundColor
        return segmentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "商品详情"
        baseSetNavRightButtonWithImage("PostItem_Share_18x22_")
        getDetailData()
        getCommentData()
    }

    func setupUI() {
        //详情页面
        webView.loadHTMLString(goodDetailDataModel.detail_html!, baseURL: nil)
        view.addSubview(webView)
        webView.scrollView.addSubview(containerView)
        
        //头部视图
        tableHeaderView = DetailHeaderView.returnHeaderView(goodDetailDataModel)
        tableViewHeaderHeight = tableHeaderView.returnHeaderHeight()
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: tableHeaderView.returnHeaderHeight())
        tableHeaderView.backgroundColor = UIColor.white
        containerView.addSubview(tableHeaderView)

        weak var weakSelf = self
        //选择标签
        segmentView.commentCount = goodDetailDataModel.comments_count
        containerView.addSubview(segmentView)
        segmentView.frame = CGRect(x: 0, y: tableHeaderView.frame.maxY, width: kScreenW, height: 54)
        let containerH = self.segmentView.frame.maxY
        webView.scrollView.contentInset = UIEdgeInsetsMake(containerH, 0, 0, 0)
        containerView.frame = CGRect(x: 0, y: -containerH, width: kScreenW, height: containerH)
        containerHeight = containerH
        
        segmentView.descClickFoun = {
            weakSelf?.webView.isHidden = false
            weakSelf?.tableView.isHidden = true
            weakSelf?.webView.scrollView.addSubview((weakSelf?.containerView)!)
            if self.segmentView.frame.maxY != 54 {
                weakSelf?.webView.scrollView.contentOffset = (weakSelf?.tableView.contentOffset)!
            }
        }
        segmentView.commentClickFoun = {
            weakSelf?.webView.isHidden = true
            weakSelf?.tableView.isHidden = false
            weakSelf?.tableView.addSubview((weakSelf?.containerView)!)
            if self.segmentView.frame.maxY == 54 {
                self.tableView.contentOffset = CGPoint(x: 0, y: -54)
            } else {
                weakSelf?.tableView.contentOffset = (weakSelf?.webView.scrollView.contentOffset)!
            }
        }
        //评论视图
        view.addSubview(tableView)
        tableView.frame = CGRect(x: 0,y: 0 ,width: kScreenW,height: kScreenH - 44 - 64)
        tableView.contentInset = UIEdgeInsetsMake(containerHeight, 0, 0, 0);
        tableView.isHidden = true
        
        addBottomView()
    }
    
    override func baseNavRightButtonPressed(_ button: UIButton) {
        ShareView.show()
    }
    //底部视图
    func addBottomView(){
        let bottomView = DetailBottomView.returnBottomView()
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(view)
            make.height.equalTo(44)
        }
        bottomView.likeButtonClick = {
            self.enterLogin()
        }
        bottomView.goBuyButtonClick = {
        
        }
    }
    //请求详情数据
    func getDetailData(){
        let url = APPURLAPI.loadProductDetailData(returnGoodID())
        GETRequestWithUrlString(url, success: { (response) in
            print(response.data)
            self.goodDetailDataModel = GoodDetailDataModel(jsonDic: response.data!)
            self.setupUI()
            }) { (_) in
        }
    }
    //请求评论数据
    func getCommentData() {
        let url = APPURLAPI.loadProductDetailComments(returnGoodID())
        GETRequestWithUrlString(url, success: { (response) in
            let array = response.data["comments"].arrayValue.map{
                json in CommentDataModel(jsonDic: json)
            }
            self.commentListArray.append(contentsOf: array)
            self.tableView.reloadData()
        }) { (_) in
            
        }
    }

    func returnGoodID() -> String {
        var ID = ""
        if goodID == "" {
            ID = model.id!
        } else {
            ID = goodID
        }
        return ID
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        contentOfset = offsetY
        if offsetY > -54 {
            view.addSubview(segmentView)
            segmentView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 54)
        } else {
            containerView.addSubview(segmentView)
            segmentView.frame = CGRect(x: 0, y: tableViewHeaderHeight, width: kScreenW, height: 54)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DanPinDetailViewController: UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if commentListArray.count > 0 && indexPath.row < (commentListArray.count - 1) {
            let model = commentListArray[indexPath.row]
            return CommentTableViewCell.returnCellForRow(model: model)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
