//
//  EditChannelView.swift
//  SimpleSugars
//
//  Created by 苑伟 on 2016/10/25.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

let ShakeAnimationKey = "ShakeAnimationKey"

class EditChannelView: UIView {

    var channelTitles: [HomeTopDataModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var isHasEdit = false  //是否是编辑状态
    var editChannelTitles = [HomeTopDataModel]()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (kScreenW - 50)/4, height: 30)
        
        let collectionView = UICollectionView(frame: (frame: CGRect(x: 0, y: 0, width: kScreenW, height: self.frame.height)), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = BaseColor.BackGroundColor
//        collectionView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        collectionView.register(HotSearchCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseHeaderIdentifier)
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //恢复正常状态
    func normalChannel() {
        isHasEdit = false
        collectionView.reloadData()
    }
    //编辑状态
    func editChannel() {
        isHasEdit = true
        collectionView.reloadData()
    }

}

extension EditChannelView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if isHasEdit == false {
            return editChannelTitles.count > 0 ? 2: 1
        }
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return channelTitles.count
        }
        return editChannelTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HotSearchCollectionViewCell
        if indexPath.section == 0 {
            let channel = channelTitles[indexPath.item]
            cell.hotButton.setTitle(channel.name, for: .normal)
            cell.hotButton.removeTarget(self, action: #selector(cellItemButtonClick(button:)), for: .touchUpInside)
            if isHasEdit {
                if indexPath.item == 0 {
                    cellItemBackGroundColor(cell: cell, backGroundColor: UIColor.clear, titleColor: BaseColor.LightGrayColor, borderColor: UIColor.clear.cgColor, cornerRadius: 0, hiddenDeleteButton: true)
                } else {
                    cellItemBackGroundColor(cell: cell, backGroundColor: UIColor.white, titleColor: BaseColor.GrayColor, borderColor: BaseColor.BorderColor.cgColor, cornerRadius: 3, hiddenDeleteButton: false)
                    addAnimation(cell: cell)
                    cell.deleteButton.addTarget(self, action: #selector(deleteItem(button:)), for: .touchUpInside)
                    cell.deleteButton.tag = indexPath.item
                    cell.deleteButton.Base_setUserInfo(obj_: cell.deleteButton, value: channel)
                }
            } else {
                cellItemBackGroundColor(cell: cell, backGroundColor: UIColor.white, titleColor: BaseColor.GrayColor, borderColor: BaseColor.BorderColor.cgColor, cornerRadius: 3, hiddenDeleteButton: true)
                removeAnimation(cell: cell)
            }
        } else {
            cellItemBackGroundColor(cell: cell, backGroundColor: UIColor.white, titleColor: BaseColor.GrayColor, borderColor: BaseColor.BorderColor.cgColor, cornerRadius: 3, hiddenDeleteButton: true)
            removeAnimation(cell: cell)
            let channel = editChannelTitles[indexPath.item]
            cell.hotButton.setTitle(channel.name, for: .normal)
            cell.hotButton.addTarget(self, action: #selector(cellItemButtonClick(button:)), for: .touchUpInside)
            cell.hotButton.tag = indexPath.item
            cell.hotButton.Base_setUserInfo(obj_: cell.hotButton, value: channel)
            
        }
        return cell
    }
    //设置item状态
    func cellItemBackGroundColor(cell:HotSearchCollectionViewCell,backGroundColor: UIColor,titleColor: UIColor,borderColor: CGColor,cornerRadius:CGFloat,hiddenDeleteButton: Bool) {
        cell.hotButton.layer.borderColor = borderColor
        cell.hotButton.layer.cornerRadius = cornerRadius
        cell.hotButton.backgroundColor = backGroundColor
        cell.hotButton.setTitleColor(titleColor, for: .normal)
        cell.deleteButton.isHidden = hiddenDeleteButton
    }
    //添加动画
    func addAnimation(cell:HotSearchCollectionViewCell) {
        if cell.containerView.layer.animation(forKey: ShakeAnimationKey) == nil {
            let animation = CAKeyframeAnimation(keyPath: "transform.rotation")
            animation.values = [(-M_PI_4 * 0.03), (M_PI_4 * 0.03), (-M_PI_4 * 0.03)]
            animation.isRemovedOnCompletion = false
            animation.fillMode = kCAFillModeForwards
            animation.duration = 0.2
            animation.repeatCount = MAXFLOAT
            cell.containerView.layer.add(animation, forKey: ShakeAnimationKey)
        }
    }
    //移除动画
    func removeAnimation(cell:HotSearchCollectionViewCell) {
        cell.hotButton.layer.removeAnimation(forKey: ShakeAnimationKey)
    }
    
    func deleteItem(button: UIButton) {
        channelTitles.remove(at: button.tag)
        let channel = Base_getUserInfo(obj_: button) as! HomeTopDataModel
        editChannelTitles.append(channel)
    }
    
    func cellItemButtonClick(button: UIButton) {
        
        editChannelTitles.remove(at: button.tag)
        let channel = Base_getUserInfo(obj_: button) as! HomeTopDataModel
        channelTitles.append(channel)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(20, 10, 0, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1 {
            let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseHeaderIdentifier, for: indexPath)
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 55))
            headerView.backgroundColor = UIColor.clear
            let headerLabel = UILabel(frame: CGRect(x: 0, y: 20, width: kScreenW, height: 35))
            headerLabel.backgroundColor = UIColor.HexColor(0xEBEBEB)
            headerLabel.font = UIFont.systemFont(ofSize: 12)
            headerLabel.textColor = BaseColor.GrayColor
            headerLabel.text = "    点击添加更多频道"
            headerView.addSubview(headerLabel)
            reusableView.addSubview(headerView)
            return reusableView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return CGSize(width: kScreenW, height: 55)
        }
        return CGSize(width: kScreenW, height: 0)
    }

}

