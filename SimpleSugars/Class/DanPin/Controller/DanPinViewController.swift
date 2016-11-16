//
//  DanPinViewController.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/8/24.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

let collectionCellID = "cell"

class DanPinViewController: BaseViewController {
    
    fileprivate var collectionView: UICollectionView!
    fileprivate var listArray = [DanPinDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        requestData()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func setupCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.backgroundColor = view.backgroundColor
        collectionView.dataSource = self
        let nib = UINib(nibName: "DanPinCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: collectionCellID)
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 49 + 64, 0)
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }
    
    fileprivate func requestData()
    {
        let url = APPURLAPI.loadProductData()
        GETRequestWithUrlString(url, success: { (response) in
            //print(response.data!)
            let array = response.data["items"].arrayValue
            var dataArray = [DanPinDataModel]()
            for item in array
            {
                let data = item["data"]
                dataArray.append(DanPinDataModel(jsonDic: data))
            }
            self.listArray.append(contentsOf: dataArray)
            self.collectionView.reloadData()
            }) { (_) in
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DanPinViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listArray.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! DanPinCollectionViewCell
        cell.model = listArray[(indexPath as NSIndexPath).item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = listArray[(indexPath as NSIndexPath).item]
        let detail = DanPinDetailViewController()
        detail.model = model
        navigationController?.pushViewController(detail, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.main.bounds.width - 30) / 2
        let height: CGFloat = 235
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
}
