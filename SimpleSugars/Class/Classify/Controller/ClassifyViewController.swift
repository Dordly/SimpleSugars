//
//  ClassifyViewController.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/8/24.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

class ClassifyViewController: BaseViewController {
    
    fileprivate var collectionView: UICollectionView!
    
    fileprivate let projectCollectionCellIdentifier = "projectCollectionCellIdentifier"
    fileprivate let classCollectionViewCellIdentifier = "ClassCollectionViewCell"
    fileprivate let kheaderIdentifier = "headerIdentifier"

    fileprivate var collectionArray = [ProjectCollectionDataModel]()
    fileprivate var classArray = [ChannelGroupsDataModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        baseSetNavRightButtonWithImage("Feed_SearchBtn_18x18_")
        setupCollectionView()
        requestCategoryCollection()
        loadCategoryGroup()
    }
    
    fileprivate func setupCollectionView() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = view.backgroundColor
        collectionView.register(ProjectCollectionCollectionViewCell.self, forCellWithReuseIdentifier: projectCollectionCellIdentifier)
        collectionView.register(ClassCollectionViewCell.self, forCellWithReuseIdentifier: classCollectionViewCellIdentifier)
        let nib = UINib(nibName: "ClassCollectionReusableView", bundle: nil)
        collectionView.register(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kheaderIdentifier)
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 49 + 64, 0)
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }

    //分类界面 顶部 专题合集
    fileprivate func requestCategoryCollection()
    {
        let url = APPURLAPI.loadCategoryCollection("6")
        GETRequestWithUrlString(url, success: { (response) in
            
            let array = response.data["collections"].arrayValue.map{
            ProjectCollectionDataModel(jsonDic: $0) }
            self.collectionArray.append(contentsOf: array)
            self.collectionView.reloadData()
        }) { (_) in
                
        }
    }
    //风格
    func loadCategoryGroup()
    {
        let url = APPURLAPI.loadCategoryGroup()
        GETRequestWithUrlString(url, success: { (response) in
            
            let data = response.data["channel_groups"].arrayValue
            for item in data {
                self.classArray.append(ChannelGroupsDataModel(jsonDic: item))
            }
            self.collectionView.reloadData()
        }) { (_) in
            
        }
    }
    
    override func baseNavRightButtonPressed(_ button: UIButton) {
        let search = SearchViewController()
        navigationController?.pushViewController(search, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ClassifyViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if section == 0 { return 1 }
        if classArray.count > 0
        {
            let index = classArray[section - 1]
            return index.channels.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: projectCollectionCellIdentifier, for: indexPath) as! ProjectCollectionCollectionViewCell
            cell.buttonClickMethod = { [unowned self]
                (btnTag,title) -> Void in
                let vc = ClassifyListViewController(type: .Project)
                vc.id = btnTag
                vc.title = title
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.lookMoreButtonMethod = {
                let vc = AllProjectViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.cellForItem(collectionArray)
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: classCollectionViewCellIdentifier, for: indexPath) as! ClassCollectionViewCell
            cell.model = classArray[(indexPath as NSIndexPath).section - 1].channels[(indexPath as NSIndexPath).item]
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: classCollectionViewCellIdentifier, for: indexPath) as! ClassCollectionViewCell
        cell.model = classArray[(indexPath as NSIndexPath).section - 1].channels[(indexPath as NSIndexPath).item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).section == 0 { return }
        let model = classArray[(indexPath as NSIndexPath).section - 1].channels[(indexPath as NSIndexPath).item]
        let vc = ClassifyListViewController(type: .StyleCategory)
        vc.id = model.id
        vc.title = model.name
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath as NSIndexPath).section == 0 {
            return CGSize(width: kScreenW, height: 130)
        } else {
            return CGSize(width: kScreenW/4, height: kScreenW/4 + 10)
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kheaderIdentifier, for: indexPath)
        if (indexPath as NSIndexPath).section == 1 || (indexPath as NSIndexPath).section == 2 {
            if classArray.count > 0
            {
                let model = classArray[(indexPath as NSIndexPath).section - 1]
                let titleLabel = view.viewWithTag(10) as! UILabel
                titleLabel.text = model.name
            }
        }
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 { return CGSize(width: 0, height: 0) }
        return CGSize(width: kScreenW, height: 50)
    }
}
