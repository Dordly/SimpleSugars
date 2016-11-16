//
//  SearchViewController.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/8/31.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

let reuseIdentifier = "hotSearch"
let reuseHeaderIdentifier = "hotHeader"

class SearchViewController: BaseViewController {
    
    fileprivate var listArray = [JSON]()
    
    fileprivate lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "搜索商品、专题"
        searchBar.delegate = self
        return searchBar
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: kScreenW, height: 35)
        
        let collectionView = UICollectionView(frame: (frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH)), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = BaseColor.BackGroundColor
        collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
        collectionView.register(HotSearchCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseHeaderIdentifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchBar
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "  取消", style: .plain, target: self, action: #selector(backButtonClick))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 15)], for: UIControlState())
        view.addSubview(collectionView)
        requestData()
    }
    
    func backButtonClick() {
        searchBar.resignFirstResponder()
        _ = navigationController?.popViewController(animated: true)
    }
    
    fileprivate func requestData(){
        let url = APPURLAPI.loadHotWords()
        GETRequestWithUrlString(url, success: { (response) in
            print(response.data)
            let array = response.data["hot_words"].arrayValue
            self.listArray.append(contentsOf: array)
            self.collectionView.reloadData()
        }) { (_) in
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SearchViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HotSearchCollectionViewCell
        cell.deleteButton.isHidden = true
        let hot = listArray[indexPath.item].stringValue
        cell.hotButton.setTitle(hot, for: .normal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseHeaderIdentifier, for: indexPath)
        let headerLabel = UILabel(frame: CGRect(x: 0, y: 10, width: 100, height: 20))
        headerLabel.font = UIFont.systemFont(ofSize: 12)
        headerLabel.textColor = BaseColor.GrayColor
        headerLabel.text = "大家都在搜"
        reusableView.addSubview(headerLabel)
        return reusableView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let hot = listArray[indexPath.item].stringValue as NSString
        let rect = hot.boundingRect(with: CGSize(width:kScreenW,height: 30), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
        let width = rect.size.width + 20
        let height = rect.size.height + 13
        return CGSize(width: width, height: height)
    }
}

extension SearchViewController: UISearchBarDelegate
{

}

