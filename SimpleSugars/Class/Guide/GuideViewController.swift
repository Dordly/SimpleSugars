//
//  GuideViewController.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/8/29.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit


class GuideViewController: UICollectionViewController {
    
    let pageCount = 4
    let reuseIdentifier = "Cell"

    /// 布局对象
    fileprivate var layout: UICollectionViewFlowLayout = GuideFlowLayout()
    init() {
        super.init(collectionViewLayout: layout)
        collectionView?.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(GuideCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GuideCollectionViewCell
        cell.imageIndex = (indexPath as NSIndexPath).item
        if (indexPath as NSIndexPath).item == 3
        {
            cell.startButton.isHidden = false
        }
        else
        {
            cell.startButton.isHidden = true
        }
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
}

private class GuideCollectionViewCell: UICollectionViewCell {
    
    fileprivate var imageIndex: Int? {
        didSet {
            iconView.image = UIImage(named: "walkthrough_\(imageIndex! + 1)")
        }
    }
    
//    func startBtnAnimation() {
//        startButton.hidden = false
//        // 执行动画
//        startButton.transform = CGAffineTransformMakeScale(0.0, 0.0)
//        startButton.userInteractionEnabled = false
//        
//        // UIViewAnimationOptions(rawValue: 0) == OC knilOptions
//        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
//            // 清空形变
//            self.startButton.transform = CGAffineTransformIdentity
//            }, completion: { (_) -> Void in
//                self.startButton.userInteractionEnabled = true
//        })
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(iconView)
        contentView.addSubview(startButton)
        
        iconView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        
        startButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(contentView.snp.bottom).offset(-50)
            make.size.equalTo(CGSize(width: 150, height: 40))
            make.centerX.equalTo(0)
        }
    }
    
    fileprivate lazy var iconView = UIImageView()
    fileprivate lazy var startButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "btn_begin"), for: UIControlState())
        btn.addTarget(self, action: #selector(GuideCollectionViewCell.startButtonClick), for: .touchUpInside)
        btn.layer.masksToBounds = true
        btn.isHidden = true
        return btn
    }()
    
    @objc func startButtonClick() {
        UserDefaults.standard.set(true, forKey: FirstLaunch)
        UIApplication.shared.keyWindow?.rootViewController = BaseTabBarController()
    }
}

private class GuideFlowLayout: UICollectionViewFlowLayout {
    /// 准备布局
    fileprivate override func prepare() {
        // 设置 layout 布局
        itemSize = UIScreen.main.bounds.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        // 设置 contentView 属性
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.bounces = false
        collectionView?.isPagingEnabled = true
    }
}
