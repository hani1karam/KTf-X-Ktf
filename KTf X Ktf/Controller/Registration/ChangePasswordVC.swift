//
//  ChangePasswordVC.swift
//  KTf X Ktf
//
//  Created by Hany Karam on 8/14/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit

class ChangePasswordVC: BaseViewController {
 @IBOutlet weak var EmailTextField: UITextField!
 @IBOutlet weak var CodeConfirmationTextField: UITextField!
 @IBOutlet weak var PasswordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func Done(_ sender: Any) {
        let parm = [
            "email": EmailTextField.text ?? "",
            "code":CodeConfirmationTextField.text ?? "",
            "password":PasswordTextField.text ?? ""
        ]
        self.showLoading()
        Reguest.CodeConfirm(userInfoDict: parm) { [unowned self] (user, error) in
            self.HideLoading()
            if error  == nil{
                DispatchQueue.main.async {
                    guard let status = user?.msg else{return}
                    if status == "Password changed successfully" {
                        self.showToas(message: "تم تغير كلمه المرور بنجاح")
                        self.HideLoading()

                       let Home = MainTabBar.instance()
                       Home.modalPresentationStyle = .fullScreen
                       self.present(Home, animated: true, completion: nil)
                    }else{
                        self.showToas(message:"خطأ في التسجيل اعد كتابة البيانات")
                        self.HideLoading()

                    }
                }
                
            }else{
                self.showToas(message:"خطأ في التسجيل اعد كتابة البيانات")
                self.HideLoading()

            }
        }

    }
    

}
