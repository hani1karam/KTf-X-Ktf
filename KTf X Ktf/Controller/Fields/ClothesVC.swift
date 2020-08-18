//
//  ClothesVC.swift
//  KTf X Ktf
//
//  Created by Hany Karam on 8/15/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit
import SideMenu

class ClothesVC: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    static func instance () -> ClothesVC {
        let storyboard = UIStoryboard.init(name: "Fields", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ClothesVC") as! ClothesVC
    }
    @IBOutlet weak var ClothesTV: UITableView!
    @IBOutlet var AlertView: UIView!
    @IBOutlet weak var AlertMssg: UITextView!
    var items = [ShowProblemPost]()
    var menu:SideMenuNavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadproblem()
        ClothesTV.delegate = self
        ClothesTV.dataSource = self
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)

    }
    @IBAction func didTapMenu(){
           present(menu!,animated:true)
       }
       
    
    @IBAction func PostProblem(_ sender: Any) {
        let post = ClothesPostProblemVC.instance()
        post.modalPresentationStyle = .fullScreen
        self.present(post, animated: true, completion: nil)

    }
    func loadproblem(){
        self.showLoading()
        
        Reguest.sendRequest(method: .get, url: showproblem_clothes, completion:
            
            {(err,response: ShowProblem?) in
                self.HideLoading()
                
                if err == nil{
                    guard let data = response?.posts else{return}
                    self.items = data
                    self.ClothesTV.reloadData()
                    
                }
        })
        
    }
    @IBAction func RemoveSuccess(_ sender: Any) {
        AlertView.removeFromSuperview()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClothesTableViewCell", for: indexPath)
            as!  ClothesTableViewCell
        cell.name.text =  "\(items[indexPath.row].name ?? "")"
        
        cell.problemdetails.text = items[indexPath.row].details
        cell.CallNow.tag = indexPath.row
        cell.CallNow.addTarget(self, action: #selector(subscribeTapped(_:)), for: .touchUpInside)
        cell.like.tag = indexPath.row
        cell.like.addTarget(self, action: #selector(subscribe(_:)), for: .touchUpInside)
        cell.configure(compines: items[indexPath.row])
        
        if cell.problemdetails.text?.count ?? 0 > 50
        {
            cell.More.isEnabled = true
            cell.More.tag = indexPath.row
            cell.More.tag = indexPath.row
            cell.More.addTarget(self, action: #selector(subscri(_:)), for: .touchUpInside)
            self.AlertMssg.text = items[indexPath.row].details
            
        }
        else {
            cell.More.isHidden = true
            
        }
        
        
        return cell
        
    }
    @objc func subscribeTapped(_ sender: UIButton){
        // use the tag of button as index
        let youtuber = items[sender.tag]
        
        
        let url: NSURL = NSURL(string: "tel://\(youtuber.phone ?? "")")!
        if UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.openURL(url as URL)
        } else {
            print("Call failed")
        }
    }
    @objc func subscribe(_ sender: UIButton){
        let param = [
            "postId": items[sender.tag].id
        ]
        self.showLoading()
        Reguest.Like(userInfoDict: param) { (user, error) in
            
            
            if error  == nil{
                DispatchQueue.main.async {
                    guard let status = user?
                        .status else{return}
                    if status == true{
                        self.showToas(message:  "تم اضافه اللايك بنجاح")
                        self.HideLoading()
                        
                    }
                    else{
                        self.showToas(message:"قمت بذلك مسبقا")
                        self.HideLoading()
                        
                    }
                }
            }else{
                self.showToas(message:"قمت بذلك مسبقا")
                self.HideLoading()
                
                
                
            }
            
        }
    }
    func ShowSuccess(){
        view.addSubview(self.AlertView)
        self.AlertView.center = view.center
    }
    @objc func subscri(_ sender: UIButton){
        ShowSuccess()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 379
    }
}
