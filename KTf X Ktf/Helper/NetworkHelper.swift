//
//  NetworkHelper.swift
//  KTf X Ktf
//
//  Created by Hany Karam on 8/15/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Foundation
import UIKit

class helper: NSObject {
    
    class func restartApp() {
        guard let window = UIApplication.shared.keyWindow else { return }
         
          let sb = UIStoryboard(name: "Home", bundle: nil)
        if  sb != nil{
        var vc: UIViewController
        if getApiToken() == nil {
            // go to auth screen
           
            vc = sb.instantiateInitialViewController()!
            
         } else {
            // go to main screen
            vc = sb.instantiateViewController(withIdentifier: "HomeVC")
        }
        
        window.rootViewController = vc
        }
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
    }
    
    class func saveApiToken(token: String) {
        // save api token to UserDefaults
        let def = UserDefaults.standard
        def.setValue(token, forKey: "token")
        def.synchronize()
        
        restartApp()
    }

    class func getApiToken() -> String? {
        let def = UserDefaults.standard
        return def.string(forKey: "token")
    }
}

class NetworkHelper {
    
    static var accessToken: String?{
        didSet{
            UserDefaults.standard.set(accessToken, forKey: "token")
        }
    }
    static var userEmail: String?{
        didSet{
            UserDefaults.standard.set(userEmail, forKey: "email")
        }
    }
    static var isLogIn: Bool?{
        didSet{
            UserDefaults.standard.set(isLogIn, forKey: "isLogIn")
            UserDefaults.standard.synchronize()
        }
    }
    static func getAccessToken() -> String? {
        if let accessToken = UserDefaults.standard.value(forKey: "token") as? String{
            NetworkHelper.accessToken = accessToken
            print("token: \(accessToken)")
        }
        return NetworkHelper.accessToken
    }
    static func getUserEmail() -> String? {
        if let userEmail = UserDefaults.standard.value(forKey: "email") as? String{
            NetworkHelper.userEmail = userEmail
            print("email: \(userEmail)")
        }
        return NetworkHelper.userEmail
        
    }
    
}

