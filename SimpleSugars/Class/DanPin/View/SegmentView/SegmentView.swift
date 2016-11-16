//
//  SegmentView.swift
//  SimpleSugars
//
//  Created by 苑伟 on 2016/10/24.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit

typealias descClickFounation = () -> Void
typealias commentClickFounation = () -> Void

class SegmentView: UIView {
    
    var descClickFoun: descClickFounation?
    var commentClickFoun: commentClickFounation?
    
    var commentCount: String? {
        didSet {
            let count = "评论" + "(\(commentCount!))"
            comment.setTitle( count, for: .normal)
        }
    }

    @IBOutlet weak var desc: UIButton!
    @IBOutlet weak var comment: UIButton!
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var redViewLeftConstraint: NSLayoutConstraint!
    
    class func segmentView() -> SegmentView
    {
        return Bundle.main.loadNibNamed("SegmentView", owner: nil, options: nil)!.last as! SegmentView
    }
 
    override func awakeFromNib() {
        desc.layer.borderColor = BaseColor.BorderColor.cgColor
        comment.layer.borderColor = BaseColor.BorderColor.cgColor
        desc.layer.borderWidth = 0.5
        comment.layer.borderWidth = 0.5
    }

    @IBAction func descClick(_ sender: UIButton) {
        redViewLeftConstraint.constant = 0
        UIView.animate(withDuration: 0.5) { 
            self.redView.layoutIfNeeded()
        }
        if descClickFoun != nil {
            descClickFoun!()
        }
    }
    @IBAction func commentClick(_ sender: UIButton) {
        redViewLeftConstraint.constant = sender.width
        UIView.animate(withDuration: 0.5) {
            self.redView.layoutIfNeeded()
        }
        if commentClickFoun != nil {
            commentClickFoun!()
        }
    }
}
