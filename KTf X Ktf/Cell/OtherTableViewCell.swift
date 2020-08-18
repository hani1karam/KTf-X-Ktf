//
//  OtherTableViewCell.swift
//  KTf X Ktf
//
//  Created by Hany Karam on 8/15/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit

class OtherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var Other: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var problemdetails: UILabel!
    @IBOutlet weak var CallNow: UIButton!
    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var More: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UICell()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func UICell() {
        Other.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        contentView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        Other.layer.cornerRadius = 3.0
        Other.layer.masksToBounds = false
        Other.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        Other.layer.shadowOffset = CGSize(width: 0, height: 0)
        Other.layer.shadowOpacity = 0.8
        Other.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor.white
        Other.layer.cornerRadius = 15.0
        //View.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMaxYCorner]
        Other.layer.masksToBounds = false
        Other.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        Other.layer.shadowOffset = CGSize(width: 0, height: 0)
        Other.layer.shadowOpacity = 0.8
        Other.static_shadow(withOffset: CGSize(width: 0, height: 2), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5))
        
    }
    
    func configure(compines: ShowProblemPost) {
        
        DispatchQueue.main.async {
            if let img = URL(string: compines.imgPath ?? ""){
                DispatchQueue.main.async {
                    
                    self.img.kf.setImage(with: img)
                    
                }
            }
        }
    }
    
}
