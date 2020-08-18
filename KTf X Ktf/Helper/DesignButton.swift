//
//  DesignButton.swift
//  KTf X Ktf
//
//  Created by Hany Karam on 8/14/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit

@IBDesignable class DesignButton: UIButton {
    
    @IBInspectable var roundCorner : CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = roundCorner
        }
    }
    @IBInspectable var BorderColor : UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = BorderColor.cgColor
        }
    }
    @IBInspectable var BorderWidth : CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = BorderWidth
        }
    }
}
class RoundedLabel:UILabel {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius  = 10
        layer.masksToBounds = true
    }
}



class RoundedTextView:UITextView{
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius  = 10
        layer.masksToBounds = true
    }
}


class RoundedTableView:UITableView{
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius  = 10
        layer.masksToBounds = true
    }
}





