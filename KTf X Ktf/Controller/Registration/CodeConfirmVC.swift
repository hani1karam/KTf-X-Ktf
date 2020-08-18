//
//  CodeConfirmVC.swift
//  KTf X Ktf
//
//  Created by Hany Karam on 8/14/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit

class CodeConfirmVC: BaseViewController {
    
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var CodeConfirmationTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func CodeButton(_ sender: Any) {
        let parm = [
            "email": EmailTextField.text ?? "",
            "code":CodeConfirmationTextField.text ?? ""
            
        ]
        showLoading()
        Reguest.CodeConfirm(userInfoDict: parm) { [unowned self] (user, error) in
            self.HideLoading()
            if error  == nil{
                DispatchQueue.main.async {
                    guard let status = user?.msg else{return}
                    if status == "user account is verified succesfully" {
                        self.showToas(message: "تم التسجيل بنجاح")
                    let Home = MainTabBar.instance()
                    Home.modalPresentationStyle = .fullScreen
                    self.present(Home, animated: true, completion: nil)
                    }else{
                        self.showToas(message: "خطأ في التسجيل اعد كتابة الكود بشكل صحيح ")
                    }
                }
                
            }else{
                self.showToas(message: "خطأ في التسجيل اعد كتابة الكود بشكل صحيح ")
            }
        }
    }
    
}
    
 
