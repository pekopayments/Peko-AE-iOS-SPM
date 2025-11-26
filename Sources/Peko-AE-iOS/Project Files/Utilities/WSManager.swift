//
//  WSManager.swift
//  Peko
//
//  Created by Hardik Makwana on 19/01/23.
//

import UIKit

import Alamofire
//import FirebaseDatabase

class ImageParamModel:NSObject{
    
    let data:Data?
    let name:String?
    let type:String?
    
    init(data: Data?, name: String?, type: String?) {
     //   super.init()
        self.data = data
        self.name = name
        self.type = type
    }
}

@MainActor
public class WSManager: NSObject {
    
    public class func getHeaders() -> HTTPHeaders? {
        var header : HTTPHeaders?
    
        header = [
            "Content-Type": "application/json",
            
            "sessionId":objUserSession.sessionId,
            "platform":"mobile",
            "fcm_token":objUserSession.FCM_Token,
        ]
        
        let token = objUserSession.token
        if objUserSession.token != "" {
            header?.add(name: "Authorization", value: "Bearer \(token)")
        }
        
        print("\n\n*****************************************************")
        print("HEARDER => \n", header!)
        print("\n\n*****************************************************")
        return header
    }
    
    // MARK: - POST METHOD
    public class func postRequest<T: Codable & Sendable>(url: String, param: [String:Any & Sendable], resultType: T.Type, completionHandler:@escaping(_ result: T?, _ error: Error?)-> Void)
    {
        guard let urlStr = URL(string: ApiEnd().BASE_URL + url) else {
            return
        }
        
        AF.request(urlStr, method: .post, parameters: param, encoding: JSONEncoding.default, headers: WSManager.getHeaders()).responseDecodable { (response: DataResponse<T, AFError>) in
            if let result = response.value {
                completionHandler(result, nil)
            } else {
                
             //   WSManager().addToFirebase(url: urlStr.absoluteString, method: "Post", error: response.error?.localizedDescription ?? "", errorCode: response.error?.responseCode ?? 0)
                completionHandler(nil, response.error)
            }
        }
    }
    
    // MARK: - GET METHOD
    public class func getRequest<T: Codable & Sendable>(url: String, resultType: T.Type, completionHandler:@escaping(_ result: T?, _ error: Error?)-> Void)
    {
        guard let urlStr = URL(string: (ApiEnd().BASE_URL + url).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
            return
        }
       print("\n===============================================\n\n", urlStr)
        print("\n\n===============================================\n")
        
        guard let urlStr = URL(string: ApiEnd().BASE_URL + url) else {
            return
        }
        
        AF.request(urlStr, method: .get, encoding: URLEncoding.default, headers: WSManager.getHeaders()).responseDecodable { (response: DataResponse<T, AFError>) in
            if let result = response.value {
                completionHandler(result, nil)
            } else {
              // WSManager().addToFirebase(url: urlStr.absoluteString, method: "Get", error: response.error?.localizedDescription ?? "", errorCode: response.error?.responseCode ?? 0)
                
                completionHandler(nil, response.error)
            }
        }
        
    }
    // MARK: - PUT METHOD
    public class func putRequest<T: Codable & Sendable>(url: String, param: [String:Any & Sendable], resultType: T.Type, completionHandler:@escaping(_ result: T?, _ error: Error?)-> Void)
    {
        guard let urlStr = URL(string: ApiEnd().BASE_URL + url) else {
            return
        }
     
        AF.request(urlStr, method: .put, parameters: param, encoding: JSONEncoding.default, headers: WSManager.getHeaders()).responseDecodable { (response: DataResponse<T, AFError>) in
            if let result = response.value {
                completionHandler(result, nil)
            } else {
             //  WSManager().addToFirebase(url: urlStr.absoluteString, method: "Put", error: response.error?.localizedDescription ?? "", errorCode: response.error?.responseCode ?? 0)
                
                completionHandler(nil, response.error)
            }
        }
    }
    // MARK: - POST METHOD
    public class func deleteRequest<T: Codable & Sendable>(url: String, param: [String:Any & Sendable], resultType: T.Type, completionHandler:@escaping(_ result: T?, _ error: Error?)-> Void)
    {
        guard let urlStr = URL(string: ApiEnd().BASE_URL + url) else {
            return
        }
      
        AF.request(urlStr, method: .delete, parameters: param, encoding: JSONEncoding.default, headers: WSManager.getHeaders()).responseDecodable { (response: DataResponse<T, AFError>) in
            if let result = response.value {
                completionHandler(result, nil)
            } else {
              // WSManager().addToFirebase(url: urlStr.absoluteString, method: "Delete", error: response.error?.localizedDescription ?? "", errorCode: response.error?.responseCode ?? 0)
                
                completionHandler(nil, response.error)
            }
        }
    }
    
    // MARK: - PATCH METHOD
    public class func patchRequest<T: Codable & Sendable>(url: String, param: [String:Any & Sendable], resultType: T.Type, completionHandler:@escaping(_ result: T?, _ error: Error?)-> Void)
    {
        guard let urlStr = URL(string: ApiEnd().BASE_URL + url) else {
            return
        }
   
        AF.request(urlStr, method: .patch, parameters: param, encoding: JSONEncoding.default, headers: WSManager.getHeaders()).responseDecodable { (response: DataResponse<T, AFError>) in
            if let result = response.value {
                completionHandler(result, nil)
            } else {
             //  WSManager().addToFirebase(url: urlStr.absoluteString, method: "Patch", error: response.error?.localizedDescription ?? "", errorCode: response.error?.responseCode ?? 0)
                
                completionHandler(nil, response.error)
            }
        }
    }
    
    // HPM
    
   /*
    // MARK: - Upload Data
    // MARK: - Upload image
    //public class func requestUploadData(url : String, method:HTTPMethod, params :[String:Any], imageParams :[ImageParamModel], completionHandler:@escaping([String:Any])-> Void) {
   
        public class func requestUploadData(
            url: String,
            method: HTTPMethod,
            params: [String: Any],
            imageParams: [ImageParamModel],
            completionHandler: @escaping ([String: Any]) -> Void
        ){
        
        guard let urlStr = URL(string: ApiEnd().BASE_URL + url) else {
            return
        }
        print("\n\n\n\n**************** URL \n", urlStr)
        
        AF.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in params {
                    if let temp = value as? String {
                        multipartFormData.append(temp.data(using: .utf8)!, withName: key)}
                    
                    if value is Int {
                        multipartFormData.append("(temp)".data(using: .utf8)!, withName: key)}
                    
                    if let temp = value as? NSArray {
                        temp.forEach({ element in
                            let keyObj = key + "[]"
                            if let string = element as? String {
                                multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                            } else
                                if element is Int {
                                    let value = "(num)"
                                    multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                            }
                        })
                    }
                }
//                print(multipartFormData)
                for imgDic in imageParams {
                    let imgData = imgDic.data ?? Data() // imgDic["image_data"] as? Data ?? Data()
                    let imgName = imgDic.name ?? "" //imgDic["image_name"] as? String ?? ""
                    
                    if imgDic.type == "pdf" {
                        multipartFormData.append(imgData, withName: imgName, fileName: "registerImage.pdf", mimeType: "application/pdf")
                    }else if imgDic.type == "doc" || imgDic.type == "docx" {
                        multipartFormData.append(imgData, withName: imgName, fileName: "registerImage.pdf", mimeType: "application/doc")
                    }else{
                        multipartFormData.append(imgData, withName: imgName, fileName: "registerImage.png", mimeType: "image/png")
                    }
                    
                    
                }
               
        },
            to:  urlStr,
            method: method,
            headers: WSManager.getHeaders())
        .responseJSON { (response) in
              
                switch (response.result) {
                case .success(_):
                    if let json = response.value
                    {
                        completionHandler((json as! [String:Any & Sendable]))
                    }
                    break
                case .failure(let error):
                    completionHandler(["status":false, "success":false, "message":error.localizedDescription])
                    break
                }
            }
    }

   */
    
  /*
    public class func requestUploadData(url : String, params :[String:Any], imageParams :[[String:Any]], completionHandler:@escaping([String:Any])-> Void) {
    
    //[String : AnyObject]!, imageName : String!,image:Data, success:@escaping ([String:Any]) -> Void, failure:@escaping (Error) -> Void) {
        
        guard let urlStr = URL(string: ApiEnd().BASE_URL + url) else {
            return
        }
          
        AF.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in params {
                    if let temp = value as? String {
                        multipartFormData.append(temp.data(using: .utf8)!, withName: key)}
                    
                    if value is Int {
                        multipartFormData.append("(temp)".data(using: .utf8)!, withName: key)}
                    
                    if let temp = value as? NSArray {
                        temp.forEach({ element in
                            let keyObj = key + "[]"
                            if let string = element as? String {
                                multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                            } else
                                if element is Int {
                                    let value = "(num)"
                                    multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                            }
                        })
                    }
                }
                for imgDic in imageParams {
                    let imgData = imgDic["image_data"] as? Data ?? Data()
                    let imgName = imgDic["image_name"] as? String ?? ""
                    
                    multipartFormData.append(imgData, withName: imgName, fileName: "registerImage.png", mimeType: "image/png")
                }
               
        },
            to:  urlStr,
            method: .put,
            headers: WSManager.getHeaders()).responseJSON { (response) in
              
                switch response.result {
                case .success(_):
                    if let json = response.value
                    {
                        completionHandler((json as! [String:AnyObject]))
                    }
                    break
                case .failure(let error):
                 //   WSManager().addToFirebase(url: urlStr.absoluteString, method: "Put", error: response.error!.localizedDescription)
                    
                    completionHandler(["success":false, "message":error.localizedDescription])
                    break
                }
                
            }
    }
*/
    
    
    // MARK: - JSON
    /*
    public class func postRequestJSON(urlString:String, withParameter params: [String: Any]!, completion: @escaping (_ success: Bool, _ result:[String:Any]?) -> Void)  {
    
        guard let urlStr = URL(string: ApiEnd().BASE_URL + urlString) else {
            return
        }
        AF.request(urlStr, method: .post, parameters: params, encoding: JSONEncoding.default, headers: WSManager.getHeaders()).responseJSON { (response) in
            
            switch response.result {
                
            case .success(_):
                if let json = response.value as? [String : Any]
                {
                    completion(true, json)
                }
                break
            case .failure(let error):
                completion(false, nil)
                break
            }
        }
    }
    
    public class func getRequestJSON(urlString:String, withParameter params: [String: Any]!, completion: @escaping (_ success: Bool, _ result:[String:Any]?) -> Void)  {
    
        guard let urlStr = URL(string: ApiEnd().BASE_URL + urlString) else {
            return
        }
     
        AF.request(urlStr, method: .get, parameters: params, encoding: JSONEncoding.default, headers: WSManager.getHeaders()).responseJSON { (response) in
            
            switch response.result {
                
            case .success(_):
                if let json = response.value as? [String : Any]
                {
                    completion(true, json)
                }
                break
            case .failure(let error):
                completion(false, nil)
                break
            }
        }
    }
    public class func putRequestJSON(urlString:String, withParameter params: [String: Any]!, completion: @escaping (_ success: Bool, _ result:[String:Any]?) -> Void)  {
    
        guard let urlStr = URL(string: ApiEnd().BASE_URL + urlString) else {
            return
        }
  //      let header : HTTPHeaders = WSManager.getHeaders()!
//        if objUserSession.token != "" {
//            header = [
//                "Content-Type": "application/json",
//                "Authorization": "Bearer \(objUserSession.token)",
//                "sessionId":objUserSession.sessionId
//            ]
//        } else {
//            header = nil
//        }
//        
        AF.request(urlStr, method: .put, parameters: params, encoding: JSONEncoding.default, headers: WSManager.getHeaders()).responseJSON { (response) in
            
            switch response.result {
                
            case .success(_):
                if let json = response.value as? [String : Any]
                {
                    completion(true, json)
                }
                break
            case .failure(let error):
                completion(false, nil)
                break
            }
        }
    }
    
    public class func patchRequestJSON(urlString:String, withParameter params: [String: Any]!, completion: @escaping (_ success: Bool, _ result:[String:Any]?) -> Void)  {
    
        guard let urlStr = URL(string: ApiEnd().BASE_URL + urlString) else {
            return
        }
      //  let header : HTTPHeaders = WSManager.getHeaders()!
//        if objUserSession.token != "" {
//            header = [
//                "Content-Type": "application/json",
//                "Authorization": "Bearer \(objUserSession.token)",
//                "sessionid":objUserSession.sessionId
//            ]
//        } else {
//            header = nil
//        }
        
        AF.request(urlStr, method: .patch, parameters: params, encoding: JSONEncoding.default, headers: WSManager.getHeaders()).responseJSON { (response) in
            
            switch response.result {
                
            case .success(_):
                if let json = response.value as? [String : Any]
                {
                    completion(true, json)
                }
                break
            case .failure(let error):
                completion(false, nil)
                break
            }
        }
    }
     */
    func addToFirebase(url:String, method:String, error:String, errorCode:Int) {
     /*
        var ref: DatabaseReference!
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        Database.database().isPersistenceEnabled = true
        ref = Database.database().reference()
        
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        let model = UIDevice.modelName
        
        let dic = [
            "url": url,
            "method":method,
            "error":error,
            "token":objUserSession.token,
            "sessionId":objUserSession.sessionId,
            "date":Date().formate(format: "dd-MM-yyyy hh:mm"),
            "build":appVersion ?? "",
            "model":model,
            "errorCode":errorCode,
            "internetStaus":appDelegate.internetStatus
        ] as [String : Any]
        
        ref.child("iOS_Error").childByAutoId().setValue(dic) { error, ref in
            print("")
        }
        */
    }
}
