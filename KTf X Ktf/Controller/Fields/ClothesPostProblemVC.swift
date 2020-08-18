//
//  ClothesPostProblemVC.swift
//  KTf X Ktf
//
//  Created by Hany Karam on 8/15/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit
import Alamofire
import Photos
class ClothesPostProblemVC: BaseViewController {
    static func instance () -> ClothesPostProblemVC {
        let storyboard = UIStoryboard.init(name: "Fields", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ClothesPostProblemVC") as! ClothesPostProblemVC
    }
    
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var LocatioTextField: UITextField!
    
    @IBOutlet weak var DetailsTextField: RoundedTextView!
    
    @IBOutlet weak var PhoneTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ButtonImage: UIButton!
    @IBOutlet weak var LblImage: UILabel!
    
    var header = ["Accept":"application/json","Authorization": "Bearer \(NetworkHelper.getAccessToken() ?? "" )"]
    let debuggingTag = "ClothesPostProblemVC"
    var localPath: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //Clothes
    @IBAction func PostButton(_ sender: Any) {
        if validData() {
            
            let urlReq = creatpost
            guard  let data = imageView.image?.jpegData(compressionQuality: 0.2) else {return}
            let imageData: NSData = imageView.image!.pngData() as! NSData
            let imageobj = imageView.image!
            let ImageData = imageobj.pngData()
            var params = [
                "name": NameTextField.text ?? "",
                "address": LocatioTextField.text ?? "",
                "phone": PhoneTextField.text ?? "",
                "details": DetailsTextField.text ?? "",
                "section": "Clothes"]
            self.showLoading()
            Alamofire.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(data, withName: "image",fileName: "file.jpg", mimeType: "image/jpg")
                for (key, value) in params {// this will loop the 'parameters' value, you can comment this if not needed
                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
                    
                }
            },
                             to:urlReq, method: .post,headers: header)
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
                                let responseModel = try JSONDecoder().decode(PostProblem.self, from: response.data!)
                                // completion(responseModel, nil)
                                self.showToas(message: "تم اضافه المشكله بنجاح بانتظار مراجعه الادمن")
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
    func finish(){
        self.NameTextField.text = ""
        self.PhoneTextField.text = ""
        self.LocatioTextField.text = ""
        self.DetailsTextField.text = ""
        
    }
    func validData() -> Bool{
        
        if (localPath?.isEmpty) ?? true{
            self.showToas(message: "يجب عليك أدخال صوره ")
            return false
        }
        if NameTextField.text!.isEmpty{
            self.showToas(message: "يجب عليك أدخال اسم ")
            return false
        }
        
        if PhoneTextField.text!.isEmpty{
            self.showToas(message: " يجب عليك أدخال رقم الهاتف")
            return false
        }
        
        if DetailsTextField.text!.isEmpty{
            self.showToas(message: " يجب عليك ادخال التفاصيل")
            return false
        }
        
        if LocatioTextField.text!.isEmpty{
            self.showToas(message: " يجب عليك ادخال المكان")
            return false
        }
        
        return true
    }
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
    
    
}

extension ClothesPostProblemVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
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
            LblImage.isHidden = true
            
            
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
        LblImage.isHidden = true
        
        
        
        dismiss(animated: true)
    }
    
    func imGWPickerControllerDidCancek(_ picker: UIImagePickerController)
    {
        dismiss(animated: true)
        ButtonImage.isHidden = true
        LblImage.isHidden = true
    }
    
}



