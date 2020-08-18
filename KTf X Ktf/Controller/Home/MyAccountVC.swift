//
//  MyAccountVC.swift
//  KTf X Ktf
//
//  Created by Hany Karam on 8/15/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit
import SideMenu

class MyAccountVC: BaseViewController {
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PhoneTextField: UITextField!
    @IBOutlet weak var Admin: UIButton!
    var header = ["Content-Type" : "application/json","Authorization": "Bearer \(NetworkHelper.getAccessToken() ?? "" )"]
    var menu:SideMenuNavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserProfile()
        loadUserInfo()
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)

    }
    
    @IBAction func didTapMenu(){
           present(menu!,animated:true)
       }
       func loadUserInfo() {
           
           print("loadUserProfile")
           var header = ["Authorization": "Bearer \(NetworkHelper.getAccessToken() ?? "" )"]
           
           Reguest.ShowInfo{(response,err) in
               
               print("sendRequest")
               
               
               if let user = response.self{
                   DispatchQueue.main.async {
                       print("DispatchQueue")
    
                       if self.EmailTextField.text == "hanykaram63@gmail.com"{
                           self.Admin.isHidden = false
                       }
                       else {
                           self.Admin.isHidden = true
                       }
                       
                   }
               }
               
           }
       }

       func loadUserProfile() {
           
           print("loadUserProfile")
           var header = ["Authorization": "Bearer \(NetworkHelper.getAccessToken() ?? "" )"]
           
           Reguest.ShowInfo{(response,err) in
               
               print("sendRequest")
               
               
               if let user = response.self{
                   DispatchQueue.main.async {
                       print("DispatchQueue")
                       self.EmailTextField.text = response?.email
                       
                       self.PhoneTextField.text = response?.phone
                       
                       
                   }
               }
               
           }
       }

    @IBAction func Done(_ sender: Any) {
        if validData(){
            let param = ["email": EmailTextField.text ?? "","phone": PhoneTextField.text ?? "",] as [String : Any]
            
            self.showLoading()
            Reguest.UpdatePost(userInfoDict: param) { (response,err) in
                
                self.HideLoading()
                if err == nil{
                    
                    
                    
                    self.showToas(message: "تم تعديل البيانات بنجاح")
                    
                    
                }
                else{
                    
                    self.showToas(message: "هناك خطا ما")
                    
                }
            }
            
        }
        
    }
    
    
    func validData() -> Bool{
        
        if PhoneTextField.text!.isEmpty{
            self.showToas(message: "ادخل رقم الهاتف")
            return false
            
        }
        if EmailTextField.text!.isEmpty{
            self.showToas(message: "ادخل رقم الايميل")
            return false
        }
        return true
        
    }
    @IBAction func Admin(_ sender: Any) {
        let Forget = AdminVC.instance()
        Forget.modalPresentationStyle = .fullScreen
        self.present(Forget, animated: true, completion: nil)

    }
    

}
