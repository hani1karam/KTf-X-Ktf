//
//  EditPostVC.swift
//  KTf X Ktf
//
//  Created by Hany Karam on 8/15/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit
import Alamofire
import Photos
class EditPostVC: BaseViewController {
    static func instance () -> EditPostVC {
        let storyboard = UIStoryboard.init(name: "Home", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "EditPostVC") as! EditPostVC
    }
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var LocationTextField: UITextField!
    @IBOutlet weak var PhoneTextField: UITextField!
    @IBOutlet weak var DetailsProblemTextField: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ButtonImage: UIButton!
    
    var header = ["Content-Type" : "application/json","Authorization": "Bearer \(NetworkHelper.getAccessToken() ?? "" )"]
    var items = [UserPost]()
    var userid :String = ""
    var section :String = ""
    var localPath: String?
    let debuggingTag = "EditPostVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func loadUserData() {
        self.showLoading()
        let header = ["Authorization": "Bearer \(NetworkHelper.getAccessToken() ?? "" )"]
        
        Reguest.sendRequest(method: .get, url: showmypost, header: header,completion:
            
            {(err,response: UserPost?) in
                self.HideLoading()
                
                if err == nil{
                    guard let data = response.self else{return}
                    self.section = data.section
                    self.userid = data.userID
                    
                    
                }
        })
        
    }
    
    @IBAction func EditButtonAction(_ sender: Any) {
        if validData(){
            
            
            let urlReq = edit_post
            guard  let data = imageView.image?.jpegData(compressionQuality: 0.2) else {return}
            let imageData: NSData = imageView.image!.pngData() as! NSData
            let imageobj = imageView.image!
            let ImageData = imageobj.pngData()
            var params = [
                "phone": PhoneTextField.text ?? "", "email": EmailTextField.text ?? "","name":NameTextField.text  ?? "","address":LocationTextField.text ?? "","details":DetailsProblemTextField.text ?? "",            "postId": "5ee1fe397b089b00043d71bc"    , "section":"Food"  ]
            self.showLoading()
            Alamofire.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(data, withName: "image",fileName: "file.jpg", mimeType: "image/jpg")
                for (key, value) in params {// this will loop the 'parameters' value, you can comment this if not needed
                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
                    
                }
            },
                             to:urlReq, method: .put,headers: header)
            { (result) in
                switch result {
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    upload.responseJSON { response in
                        switch response.result {
                        case .success :
                            do {
                                let responseModel = try JSONDecoder().decode(EditPos.self, from: response.data!)
                                // completion(responseModel, nil)
                                self.showToas(message: "تم التعديل بنجاح")
                                self.HideLoading()
                            } catch (let error) {
                                print(error.localizedDescription)
                                //   completion(nil , error)
                            }
                        case .failure(let error) :
                            print(error.localizedDescription)
                            //completion(nil , error)
                            self.showToas(message: "هناك مشكله ما راجع البيانات كامله")
                            self.HideLoading()

                        }
                        // completion("success")
                        print(response)
                    }
                case .failure(let encodingError):
                    self.showToas(message: "هناك مشكله ما راجع البيانات كامله")
                    self.HideLoading()

                    print(encodingError)
                    //  completion("failed")
                }
            }
        }
        
    }
    
    
    
    func validData() -> Bool{
        if (localPath?.isEmpty) ?? true{
            self.showToas(message: "يجب عليك أدخال صوره ")
            return false
        }
        
        if PhoneTextField.text!.isEmpty{
            self.showToas(message: "ادخل رقم الهاتف")
            return false
            
        }
        if EmailTextField.text!.isEmpty{
            self.showToas(message: "ادخل رقم الايميل")
            return false
        }
        
        if LocationTextField.text!.isEmpty{
            self.showToas(message: "ادخل العنوان")
            return false
            
        }
        if PhoneTextField.text!.isEmpty{
            self.showToas(message: "ادخل الهاتف")
            return false
            
        }
        if DetailsProblemTextField.text!.isEmpty{
            self.showToas(message: "ادخل التفاصيل")
            return false
            
        }
        return true
        
    }
    /*
     
     
     */
    @IBAction func addbutton(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            PHPhotoLibrary.requestAuthorization { (status) in
                DispatchQueue.main.async {
                    
                    switch status {
                    case .authorized:
                        let myPickercontroller = UIImagePickerController()
                        myPickercontroller.delegate = self
                        myPickercontroller.sourceType = .photoLibrary
                        self.present(myPickercontroller, animated: true)
                        
                    case .notDetermined:
                        if status == PHAuthorizationStatus.authorized {
                            let myPickercontroller = UIImagePickerController()
                            myPickercontroller.delegate = self
                            myPickercontroller.sourceType = .photoLibrary
                            
                            self.present(myPickercontroller, animated: true)
                        }
                        
                    case .restricted:
                        let alert = UIAlertController(title: "photo Libarary Restricted ", message: "photo libarary access restricted ", preferredStyle: .alert)
                        let okaction = UIAlertAction(title: "ok", style: .default)
                        alert.addAction(okaction)
                        self.present(alert, animated: true)
                        
                    case .denied:
                        let alert = UIAlertController(title: "photo Libarary denied ", message: "photo libarary access denied ", preferredStyle: .alert)
                        let okaction = UIAlertAction(title: "go to setting", style: .default) {
                            (action) in
                            
                            DispatchQueue.main.async {
                                let url = URL(string: UIApplication.openSettingsURLString)!
                                UIApplication.shared.open(url, options: [:])
                                
                            }
                        }
                        
                        let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
                        alert.addAction(okaction)
                        alert.addAction(cancelAction)
                        
                        self.present(alert, animated: true)
                        
                    }
                }
            }
            
        }
        
        
    }
    
    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)}
    
    
    
}
extension EditPostVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])
    {
        
        let documentDirectory: NSString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
        
        let imageName = "temp"
        let imagePath = documentDirectory.appendingPathComponent(imageName)
        print(debuggingTag, "image path : \(imagePath)")
        
        
        
        
        localPath = imagePath
        print(debuggingTag, "local path: \(String(describing: localPath))")
        
        if let image = info[.editedImage] as? UIImage {
            self.imageView.image = image
            self.imageView.image = image
            ButtonImage.isHidden = true
            
            
            if let data = image.jpegData(compressionQuality: 80)
            {
                do {
                    try data.write(to: URL(fileURLWithPath: imagePath), options: .atomic)
                } catch let error {
                    print(error)
                }
            }
            
            
        } else if let image = info[.originalImage] as? UIImage {
            self.imageView.image = image
            
            if let data = image.jpegData(compressionQuality: 80)
            {
                do {
                    try data.write(to: URL(fileURLWithPath: imagePath), options: .atomic)
                } catch let error {
                    print(error)
                }
            }
            
            
        }
        
        ButtonImage.isHidden = true
 
        
        
        dismiss(animated: true)
    }
    
    func imGWPickerControllerDidCancek(_ picker: UIImagePickerController)
    {
        dismiss(animated: true)
        ButtonImage.isHidden = true
     }
   
}



