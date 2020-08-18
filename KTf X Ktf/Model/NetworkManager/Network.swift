//
//  Network.swift
//  KTf X Ktf
//
//  Created by Hany Karam on 8/14/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Alamofire
struct NetworkingManager {
    static let shared: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        return sessionManager
    }()
}
class Reguest {
    
    func Login(userInfoDict : [String:Any],completion: @escaping (LoginModel?, Error?) -> ()){
        
        let url = login
        
        Alamofire.request(url, method: .post,parameters: userInfoDict,encoding: JSONEncoding.default).responseJSON { (response) in
            
            switch response.result{
                
            case .success(_):
                
                do{
                    
                    guard let data = response.data else {return}
                    
                    let result = try JSONDecoder().decode(LoginModel.self, from: data)
                    
                    completion(result, nil)
                    
                }catch{
                    completion(nil, error)
                }
                
            case .failure(_):
                completion(nil, response.error)
            }
            
        }
        
        
    }
    class func registerNewUser (userInfoDict : [String:Any] , completion : @escaping( RegisterModel? , Error?) -> ()) {
        let headers = ["Content-Type" : "application/json"]
        Alamofire.request(register, method: .post, parameters: userInfoDict, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success :
                do {
                    let responseModel = try JSONDecoder().decode(RegisterModel.self, from: response.data!)
                    print(responseModel)
                    completion(responseModel , nil)
                } catch (let error) {
                    print(error.localizedDescription)
                    completion(nil , error)
                }
            case .failure(let error) :
                print(error.localizedDescription)
                completion(nil , error)
            }
        }
    } // Register Function
    
    class func CodeConfirm (userInfoDict : [String:Any] , completion:@escaping ( CodeConfirmModel? ,  Error?) -> Void) {
        let headers = ["content-type" : "application/json"]
        
        Alamofire.request(confirm_code, method: .post, parameters: userInfoDict, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            print(response.result.value!)
            switch response.result {
            case .success :
                do {
                    let responseModel = try JSONDecoder().decode(CodeConfirmModel.self, from: response.data!)
                    completion(responseModel, nil)
                } catch (let error) {
                    print(error.localizedDescription)
                    completion(nil , error)
                }
            case .failure(let error) :
                print(error.localizedDescription)
                completion(nil , error)
            }
        }
    } //CodeConfirm function
    
    class func Forget (userInfoDict : [String:Any] , completion:@escaping ( ForgetPassword? ,  Error?) -> Void) {
        let headers = ["content-type" : "application/json"]
        
        Alamofire.request(forget, method: .post, parameters: userInfoDict, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            print(response.result.value!)
            switch response.result {
            case .success :
                do {
                    let responseModel = try JSONDecoder().decode(ForgetPassword.self, from: response.data!)
                    completion(responseModel, nil)
                } catch (let error) {
                    print(error.localizedDescription)
                    completion(nil , error)
                }
            case .failure(let error) :
                print(error.localizedDescription)
                completion(nil , error)
            }
        }
    } //Forget function
    class func  sendRequest<T: Decodable>( userImage: Data? = nil, method: HTTPMethod, url: String, parameters:[String:Any]? = nil, header: [String:String]?  = nil, completion: @escaping (_ error: Error?, _ response: T?)->Void) {
        NetworkingManager.shared.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: header)
            .responseJSON { res -> Void in
                print(res.result.value)
                switch res.result
                {
                case .failure(let error):
                    completion(error,nil)
                case .success(_):
                    if let dict = res.result.value as? Dictionary<String, Any>{
                        do{
                            guard let data = res.data else { return }
                            let response = try JSONDecoder().decode(T.self, from: data)
                            completion(nil,response)
                        }catch let err{
                            print("Error In Decode Data \(err.localizedDescription)")
                            completion(err,nil)
                        }
                    }else{
                        completion(nil,nil)
                    }
                }
        }
        
    }
    class func Like(userInfoDict : [String:Any] , completion : @escaping( LikeModel? , Error?) -> ()) {
        let headers = ["Content-Type" : "application/json"  ,"Authorization": "Bearer \(NetworkHelper.getAccessToken() ?? "" )"
        ]
        Alamofire.request(like, method: .patch, parameters: userInfoDict, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success :
                do {
                    let responseModel = try JSONDecoder().decode(LikeModel.self, from: response.data!)
                    print(responseModel)
                    completion(responseModel , nil)
                } catch (let error) {
                    print(error.localizedDescription)
                    completion(nil , error)
                }
            case .failure(let error) :
                print(error.localizedDescription)
                completion(nil , error)
            }
        }
    } // Like Function
    class func ShowInfo(completion : @escaping( UserData? , Error?) -> ()) {
        let headers = ["Content-Type" : "application/json"  ,"Authorization": "Bearer \(NetworkHelper.getAccessToken() ?? "" )"
        ]
        Alamofire.request(showinfo, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success :
                do {
                    let responseModel = try JSONDecoder().decode(UserData.self, from: response.data!)
                    print(responseModel)
                    completion(responseModel , nil)
                } catch (let error) {
                    print(error.localizedDescription)
                    completion(nil , error)
                }
            case .failure(let error) :
                print(error.localizedDescription)
                completion(nil , error)
            }
        }
    } // Show Info Function
    class func UpdatePost (userInfoDict : [String:Any] , completion : @escaping(Update? , Error?) -> ()) {
         
     let jsonString = """
          {
              "msg": "User information is updated successfully!",
              "status": true
          }
          """
    let headers = ["Content-Type" : "application/json"  ,"Authorization": "Bearer \(NetworkHelper.getAccessToken() ?? "" )"
           ]
                     
    Alamofire.request(update, method: .put, parameters: userInfoDict, encoding: JSONEncoding.default, headers: headers).responseString { (response) in


             switch response.result {
             case .success :
                 
                 

                 do {
                     
                     let jsonData =  jsonString.data(using: .utf8)!
                     let responseModel = try JSONDecoder().decode(Update.self, from: jsonData)
                     print(responseModel)
                     

                     completion(responseModel , nil)
                 } catch (let error) {
                     print(error)
                     completion(nil , error)
                 }
             case .failure(let error) :
                 print(error)
                 completion(nil , error)
            }
         }
     } // // UpdatePost Function
    class func Delet(userInfoDict : [String:Any] , completion : @escaping( DeletMpdel? , Error?) -> ()) {
        let headers = ["Content-Type" : "application/json"  ,"Authorization": "Bearer \(NetworkHelper.getAccessToken() ?? "" )"
        ]
        Alamofire.request(delet, method: .delete, parameters: userInfoDict, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
                
            case .success :
                do {
                    let responseModel = try JSONDecoder().decode(DeletMpdel.self, from: response.data!)
                    print(responseModel)
                    completion(responseModel , nil)
                } catch (let error) {
                    print(error.localizedDescription)
                    completion(nil , error)
                }
            case .failure(let error) :
                print(error.localizedDescription)
                completion(nil , error)
            }
        }
    } // Delet Function
    
    class func solved(userInfoDict : [String:Any] , completion : @escaping( SolvedModel? , Error?) -> ()) {
        let headers = ["Content-Type" : "application/json"  ,"Authorization": "Bearer \(NetworkHelper.getAccessToken() ?? "" )"
        ]
        Alamofire.request(solved_problem, method: .patch , parameters: userInfoDict, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success :
                do {
                    let responseModel = try JSONDecoder().decode(SolvedModel.self, from: response.data!)
                    print(responseModel)
                    completion(responseModel , nil)
                } catch (let error) {
                    print(error.localizedDescription)
                    completion(nil , error)
                }
            case .failure(let error) :
                print(error.localizedDescription)
                completion(nil , error)
            }
        }
    } // Delet Function
    struct AcceptPost: Codable {
             let msg: String
             let status: Bool
         }
      class func Aprrove(userInfoDict : [String:Any] , completion : @escaping( AcceptPost? , Error?) -> ()) {
        let headers = ["Content-Type" : "application/json"  ,"Authorization": "Bearer \(NetworkHelper.getAccessToken() ?? "" )"
        ]
        Alamofire.request(accept, method: .patch, parameters: userInfoDict, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success :
                do {
                    let responseModel = try JSONDecoder().decode(AcceptPost.self, from: response.data!)
                    print(responseModel)
                    completion(responseModel , nil)
                } catch (let error) {
                    print(error.localizedDescription)
                    completion(nil , error)
                }
            case .failure(let error) :
                print(error.localizedDescription)
                completion(nil , error)
            }
        }
    } // Aprrove Function

}
