//
//  RaidersDetailViewController.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/8/26.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

let yOfSet = CGFloat(180)
let kWebViewHeight = kScreenH - 44 - 64

class RaidersDetailViewController: BaseViewController {
    
    var model: HomeDataModel!
    var backGroundImageView: UIImageView!
    var webView: UIWebView!
    var titleLabel: UILabel!
    var bottomView = HomeDetailBottomView.returnBottomView()
    var footerView = HomeDetailWebFooterView.returnFooterView()
    var detailModel: HomeDetailDataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "攻略详情"
        setupWebview()
        setupHeaderImageView()
        setupTitleLabel()
        setupBottomView()
        requestData()
    }
    //MARK: 设置webView header
    func setupHeaderImageView() {
        backGroundImageView = UIImageView()
        backGroundImageView.frame = CGRect(x: 0, y: -GPGuideDetailHeaderH, width: kScreenW, height: GPGuideDetailHeaderH)
        webView.scrollView.addSubview(backGroundImageView)
    }
    //MARK:设置webView
    func setupWebview() {
        webView = UIWebView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH-64-44))
        webView.backgroundColor = BaseColor.BackGroundColor
        webView.scrollView.backgroundColor = UIColor.clear
        webView.isOpaque = false
        webView.delegate = self
//        webView.scrollView.delegate = self
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scalesPageToFit = true
        webView.scrollView.contentInset = UIEdgeInsetsMake(GPGuideDetailHeaderH, 0, 0, 0)
        self.view.addSubview(webView)
    }
    //MARK:设置标题
    func setupTitleLabel()
    {
        titleLabel = UILabel(frame: CGRect(x: GPGuideDetailTitleLeftMargin, y: -(20 + GPGuideDetailTitleBottomMargin), width: kScreenW - GPGuideDetailTitleBottomMargin,height: 20))
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        webView.scrollView.addSubview(titleLabel)
    }
    //MARK:设置底部视图
    func setupBottomView()
    {
        bottomView.frame = CGRect(x: 0, y: kWebViewHeight, width: kScreenW, height: 44)
        view.addSubview(bottomView)
        bottomView.likeButtonClick = {
            self.enterLogin()
        }
        bottomView.shareButtonClick = {
            ShareView.show()
        }
        bottomView.commentButtonClick = {
            self.enterCommentList()
        }
    }
    //MARK:设置webView footer
    func setupFooterView()
    {
        footerView.frame = CGRect(x: 0, y: self.webView.scrollView.contentSize.height, width: kScreenW, height: 100)
        webView.scrollView.addSubview(footerView)
        footerView.likeButtonClick = {
            self.enterLogin()
        }
        footerView.shareButtonClick = {
            ShareView.show()
        }
        footerView.commentButtonClick = {
            self.enterCommentList()
        }
        var edgeInset = webView.scrollView.contentInset
        edgeInset.bottom = footerView.height + 64
        webView.scrollView.contentInset = edgeInset
    }
    //MARK:请求数据
    func requestData() {
        let url = APPURLAPI.loadHomeDetailData(id: model.id!)
        GETRequestWithUrlString(url, success: { (response) in
            print(response.data)
                self.detailModel = HomeDetailDataModel(jsonDic: response.data!)
                self.loadData()
            }) { (_) in
        }
    }
    //MARK:加载数据
    func loadData() {
        backGroundImageView.sd_setImage(with: URL(string: detailModel.cover_image_url!))
        webView.loadHTMLString(detailModel.content_html!, baseURL: nil)
        titleLabel.text = self.detailModel.title
        bottomView.likeButton.setTitle(detailModel.likes_count, for: .normal)
        bottomView.shareButton.setTitle(detailModel.shares_count, for: .normal)
        bottomView.commentButton.setTitle(detailModel.comments_count, for: .normal)
//        footerView.likeLabel.text = detailModel.likes_count! + " 人喜欢"
//        footerView.shareLabel.text = detailModel.shares_count! + " 次分享"
//        footerView.commentLabel.text = detailModel.comments_count! + " 条评论"
    }
    //MARK:评论页面
    func enterCommentList() {
        let comment = CommentViewController()
        let nav = BaseNavigationController(rootViewController: comment)
        present(nav, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension RaidersDetailViewController: UIWebViewDelegate
{
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if navigationType == .linkClicked {
            let urlString = request.url?.absoluteString.components(separatedBy: "/")
            let vc = DanPinDetailViewController()
            vc.goodID = (urlString?.last)!
            navigationController?.pushViewController(vc, animated: true)
            return false
        }
        return true
    }
}
/*
extension RaidersDetailViewController: UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
//        let offsetY = scrollView.contentOffset.y
//        let totalH = scrollView.contentSize.height
//        let abs = totalH - offsetY
//        if abs >= kScreenH {
//            bottomView.y = kWebViewHeight
//        }else {
//            bottomView.y = kWebViewHeight + 44
//        }
        
        if abs(scrollView.contentOffset.y) + kScreenH > scrollView.contentSize.height {
            
            if bottomView.height != 0 && footerView.height != 0 {
                let scale = footerView.height / bottomView.height
                bottomView.y = kWebViewHeight + (abs(scrollView.contentOffset.y) + kScreenH - scrollView.contentSize.height) * scale
            } else {
                bottomView.y = kWebViewHeight
            }
        }
        else {
            bottomView.y = kWebViewHeight
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        setupFooterView()
    }
}
*/
