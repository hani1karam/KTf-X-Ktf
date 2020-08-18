//
//  HomeTableViewCell.swift
//  KTf X Ktf
//
//  Created by Hany Karam on 8/14/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Foundation
import Kingfisher

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var imge: UIImageView!
    @IBOutlet weak var NameProblem: UILabel!
    @IBOutlet weak var DetailsProblem: UILabel!
    @IBOutlet weak var CallNow: UIButton!
    @IBOutlet weak var More: UIButton!
    @IBOutlet weak var HomeView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UICell()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func UICell() {
        HomeView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        contentView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        HomeView.layer.cornerRadius = 3.0
        HomeView.layer.masksToBounds = false
        HomeView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        HomeView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        HomeView.layer.shadowOpacity = 0.8
        
        
        
        
        HomeView.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor.white
        HomeView.layer.cornerRadius = 15.0
        //View.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMaxYCorner]
        HomeView.layer.masksToBounds = false
        HomeView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        HomeView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        HomeView.layer.shadowOpacity = 0.8
        
        imge.layer.cornerRadius = 15.0
        imge.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        
        HomeView.static_shadow(withOffset: CGSize(width: 0, height: 2), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5))

        
    }
   
    func configure(compines: TopProblemPost)
       {
           
        if let img = URL(string: compines.imgPath ?? ""){
            DispatchQueue.main.async {

             self.imge.kf.setImage(with: img)
                
            }
        }
       }

}
 
extension UIView{
    func static_shadow(withOffset value:CGSize,color: CGColor){
        self.layer.shadowColor = color
        self.layer.shadowOpacity = 3.5
        self.layer.shadowOffset = value
        self.layer.shadowRadius = 6
        
        self.clipsToBounds = false
        self.layer.masksToBounds = false
    }
}
