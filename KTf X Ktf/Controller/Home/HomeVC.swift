//
//  HomeVC.swift
//  KTf X Ktf
//
//  Created by Hany Karam on 8/14/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit
import SideMenu
class HomeVC: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    static func instance () -> HomeVC {
         let storyboard = UIStoryboard.init(name: "Home", bundle: nil)
         return storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
     }
    @IBOutlet weak var HomeTV: UITableView!
    @IBOutlet var AlertView: UIView!
    @IBOutlet weak var AlertMssg: UITextView!

    var menu:SideMenuNavigationController?
    var items = [TopProblemPost]()

    override func viewDidLoad() {
        super.viewDidLoad()
        HomeTV.delegate = self
        HomeTV.dataSource = self
        loadproblem()
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
    }
    
      func loadproblem(){
          self.showLoading()
           Reguest.sendRequest(method: .get, url: baseURL, completion:
              {(err,response: TopProblem?) in
                  self.HideLoading()
                  
                  if err == nil{
                      guard let data = response?.posts else{return}
                      self.items = data
                      self.HomeTV.reloadData()
                    }
          })
          
      }
    @IBAction func RemoveSuccess(_ sender: Any) {
        AlertView.removeFromSuperview()
        
    }
    @IBAction func didTapMenu(){
        present(menu!,animated:true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as!
        HomeTableViewCell
        cell.NameProblem.text = " \(items[indexPath.row].name)"
        cell.DetailsProblem.text = items[indexPath.row].details
        DispatchQueue.main.async {

             cell.configure(compines: self.items[indexPath.row])
         }
        
        cell.CallNow.tag = indexPath.row
        cell.CallNow.addTarget(self, action: #selector(subscribeTapped(_:)), for: .touchUpInside)
        if cell.DetailsProblem.text?.count ?? 0 > 30
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
        
        
        let url: NSURL = NSURL(string: "tel://\(youtuber.phone )")!
        if UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.openURL(url as URL)
        } else {
            print("Call failed")
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
        return 331
    }


}
class MenuListController: UITableViewController{
    var items = ["الرئيسيه","قسم الديون","قسم الطعام","قسم الملابس","اقسام اخري"]
    let darkColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = darkColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = darkColor
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0 :
            let Forget = MainTabBar.instance()
            Forget.modalPresentationStyle = .fullScreen
            self.present(Forget, animated: true, completion: nil)
            
        case 1 :
            let Forget = LoanVC.instance()
            Forget.modalPresentationStyle = .fullScreen
            self.present(Forget, animated: true, completion: nil)
            
        case 2:
            let Forget = FoodVC.instance()
            Forget.modalPresentationStyle = .fullScreen
            self.present(Forget, animated: true, completion: nil)
            //ClothesVC
            case 3:
                    let Forget = ClothesVC.instance()
                    Forget.modalPresentationStyle = .fullScreen
                    self.present(Forget, animated: true, completion: nil)
            //OtherVC
            case 4:
                              let Forget = OtherVC.instance()
                              Forget.modalPresentationStyle = .fullScreen
                              self.present(Forget, animated: true, completion: nil)
        default:
            print("HI")
            
            
        }
    }
}
