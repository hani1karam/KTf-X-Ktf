//
//  PostVC.swift
//  KTf X Ktf
//
//  Created by Hany Karam on 8/15/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit
import SideMenu

class PostVC: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var Hometv: UITableView!
    @IBOutlet var AlertView: UIView!
    
    var items = [UserPost]()
    var userid :String = ""
    var section :String = ""
    var menu:SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserPosts()
        Hometv.delegate = self
        Hometv.dataSource = self
        loadUserData()
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
    }
    
    @IBAction func Remove(_ sender: Any) {
        AlertView.removeFromSuperview()
        
    }
    @IBAction func didTapMenu(){
        present(menu!,animated:true)
    }
    
    func loadUserPosts() {
        self.showLoading()
        let header = ["Authorization": "Bearer \(NetworkHelper.getAccessToken() ?? "" )"]
        
        Reguest.sendRequest(method: .get, url: "https:/ktfxktf.herokuapp.com/myPosts", header: header,completion:
            
            {(err,response: ShowPosts?) in
                self.HideLoading()
                
                if err == nil{
                    guard let data = response?.posts else{return}
                    self.items = data
                    self.Hometv.reloadData()
                    
                }
        })
        
    }
    @IBAction func EditHome(_ sender: Any) {
        let RegVC = EditPostVC.instance()
        RegVC.modalPresentationStyle = .fullScreen
        self.present(RegVC, animated: true, completion: nil)

    }
    func loadUserData() {
        self.showLoading()
        let header = ["Authorization": "Bearer \(NetworkHelper.getAccessToken() ?? "" )"]
        
        Reguest.sendRequest(method: .get, url: showmypost, header:header,completion:
            
            {(err,response: UserPost?) in
                self.HideLoading()
                
                if err == nil{
                    guard let data = response.self else{return}
                    self.section = data.section
                    self.userid = data.userID
                    
                    
                }
        })
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as!  ProfileTableViewCell
        cell.name.text = items[indexPath.row].name
        cell.details.text = items[indexPath.row].details
        DispatchQueue.main.async {
            
            cell.configure(compines: self.items[indexPath.row])
        }
        cell.Delet.tag = indexPath.row
        cell.Delet.addTarget(self, action: #selector(subscribe(_:)), for: .touchUpInside)
        
        cell.Solved.tag = indexPath.row
        cell.Solved.addTarget(self, action: #selector(Solved(_:)), for: .touchUpInside)
        
        cell.Edit.tag = indexPath.row
        cell.Edit.addTarget(self, action: #selector(Edit(_:)), for: .touchUpInside)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 355
    }
    @objc func subscribe(_ sender: UIButton){
        let param = [
            "postId": items[sender.tag].id
        ]
        self.showLoading()
        Reguest.Delet(userInfoDict: param) { (user, error) in
            
            
            if error  == nil{
                DispatchQueue.main.async {
                    guard let status = user?
                        .status else{return}
                    if status == true{
                        self.showToas(message: "تم حذف البوست بنجاح ")
                        self.HideLoading()
                        self.Hometv.reloadData()
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
    @objc func Solved(_ sender: UIButton){
        let param = [
            "postId": items[sender.tag].id
        ]
        self.showLoading()
        Reguest.solved(userInfoDict: param) { (user, error) in
            
            
            if error  == nil{
                DispatchQueue.main.async {
                    guard let status = user?
                        .status else{return}
                    if status == true{
                        self.showToas(message: "الحمدلله ع حل المشكله")
                        self.HideLoading()
                        self.Hometv.reloadData()
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
    @objc func Edit(_ sender: UIButton){
        
        ShowSuccess()
        
    }
    
    
}
