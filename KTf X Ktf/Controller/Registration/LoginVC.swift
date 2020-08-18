//
//  ViewController.swift
//  KTf X Ktf
//
//  Created by Hany Karam on 8/14/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit

class LoginVC: BaseViewController {
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    var presenter: Presenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = Presenter(view: self)
    }
    
    @IBAction func LoginButton(_ sender: Any) {
        let param = ["email":EmailTextField.text ?? "",
                     "password":PasswordTextField.text ?? ""]
        presenter = Presenter(view: self)
        presenter.login(param: param)
        
    }
    
    
    @IBAction func SignUP(_ sender: Any) {
        
        let vc = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "RegiterVC")
            as! RegiterVC
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    @IBAction func Forget(_ sender: Any) {
        let vc = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "ForgetVC")
            as! ForgetVC
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    
}

extension LoginVC:getToDos{
    
    
    func showHud() {
        showLoading()
    }
    
    func HideHud() {
        
    }
    
    func getDataSuccessfully() {
        if (presenter.loginModel?.message == "You are logged in successfully !"){
         let Home = MainTabBar.instance()
         Home.modalPresentationStyle = .fullScreen
         self.present(Home, animated: true, completion: nil)

         }
        HideLoading()
        
    }
    
    func showError(error: String) {
        print(error)
        HideLoading()
        
    }
}
