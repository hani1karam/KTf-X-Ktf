//
//  ForgetVC.swift
//  KTf X Ktf
//
//  Created by Hany Karam on 8/14/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit

class ForgetVC: BaseViewController {
    
    @IBOutlet weak var EmailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func DoneButton(_ sender: Any) {
        let param = [
            "email" :EmailTextField.text ?? ""
        ]
        
        showLoading()
        Reguest.Forget(userInfoDict: param) { (user, error) in
            
            
            self.HideLoading()
            if error  == nil{
                DispatchQueue.main.async {
                    guard let status = user?.msg else{return}
                    
                    if status == "An email with verification code was sent to your email" {
                        self.showToas(message: "تم ارسال الكود عالايميل بنجاح")
                        let vc = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "ChangePasswordVC")
                            as! ChangePasswordVC
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        
                    }else{
                        self.showToas(message: "خطأ في التسجيل اعد كتابة البيانات")
                    }
                }
            }else{
                self.showToas(message: "خطأ في التسجيل اعد كتابة البيانات")
            }
        }
        
    }
    
    
    @IBAction func Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
    
}
