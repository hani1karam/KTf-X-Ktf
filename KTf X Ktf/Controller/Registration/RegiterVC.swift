//
//  RegiterVC.swift
//  KTf X Ktf
//
//  Created by Hany Karam on 8/14/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit

class RegiterVC: BaseViewController {
    
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PhoneTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var ConfirmPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func SignUPButton(_ sender: Any) {
        let param = [
            "email" :EmailTextField.text ?? "",
            "phone": PhoneTextField.text ?? "" ,
            "password":PasswordTextField.text ?? "",
            "confirmPassword":ConfirmPassword.text ?? ""
        ]
        
        self.showLoading()
        Reguest.registerNewUser(userInfoDict: param) { (user, error) in
            
            
            self.HideLoading()
            if error  == nil{
                DispatchQueue.main.async {
                    guard let status = user
                        else{return}
                    
                    if status.user?.status == "pending" {
                        
                        self.showToas(message:status.msg ?? "")
                        self.HideLoading()
                        
                        let vc = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "CodeConfirmVC")
                            as! CodeConfirmVC
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }else{
                        self.showToas(message:status.msg ?? "")
                        self.HideLoading()
                        
                    }
                }
            }else{
                self.showToas(message: "خطأ في التسجيل اعد كتابة الايميل او كلمة المرور")
                self.HideLoading()
                
            }
        }
        
        
    }
    
    
}
