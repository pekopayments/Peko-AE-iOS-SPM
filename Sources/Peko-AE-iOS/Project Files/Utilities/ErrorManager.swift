//
//  ErrorManager.swift
//  Peko
//
//  Created by Hardik Makwana on 03/07/24.
//

import UIKit

class ErrorModel:NSObject {
    let code:String?
//    let status: String?
    let message:String?
    let error:String?
    let errors:String?
    
    init(code: String?, message: String?, error: String?, errors: String?) {
        self.code = code
//        self.status = status
        self.message = message
        self.error = error
        self.errors = errors
    }
}


@MainActor let objErrorManager = ErrorManager.sharedInstance

@MainActor
class ErrorManager: NSObject {

    static let sharedInstance = ErrorManager()
   
    func manageFailResponse(error:ErrorModel, viewController:UIViewController, completion: @escaping ((Bool)->Void)) {
        
        if let code = error.code, code == "002"{
           self.manageSession(viewController: viewController) { result in
                if result {
                    completion(true)
                }
            }
        }
        else{
            var msg = ""
            if error.message != nil {
                msg = error.message ?? ""
            }else if error.error != nil {
                msg = error.error ?? ""
            }else if error.errors != nil {
                msg = error.errors ?? ""
            }
            viewController.showAlertWithCompletion(title: "", message: msg) { action in
                completion(false)
            }
        }
    }
    
    func manageSession(viewController:UIViewController, completion: @escaping ((Bool)->Void)) {
        HPProgressHUD.show()
        let url = ApiEnd().REFRESH_TOKEN_URL
        let parameter = [
            "refreshToken":objUserSession.refreshToken
        ]
        
        WSManager.postRequest(url: url, param: parameter, resultType: ResponseModel<RefreshTokenModel>.self) { response, error in
            HPProgressHUD.hide()
            if error != nil {
#if DEBUG
               // self.showAlert(title: "", message: error?.localizedDescription ?? "")
#else
                //self.showAlert(title: "", message: "Something went wrong please try again")
#endif
                completion(false)
            }else if let status = response?.status?.value, status == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let data:RefreshTokenModel = (response?.data)!
                    objUserSession.token = data.token ?? ""
                    objUserSession.refreshToken = data.refreshToken ?? ""
                    objUserSession.sessionId = data.sessionId ?? ""
                    completion(true)
                }
            }else{
                
                viewController.showAlertWithCompletion(title: "", message: "Your session has expired, please login again.") { action in
                    
                    DispatchQueue.main.async {
                        objUserSession.logout()
                        objShareManager.navigateToViewController = .LoginVC
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ChangeViewController"), object: nil)
                        completion(false)
                    }
                }
//                if let code = response?.responseCode, code == "002"{
//
//                }else{
////                    var msg = ""
////                    if response?.message != nil {
////                        msg = response?.message ?? ""
////                    }else if response?.error?.count != nil {
////                        msg = response?.error ?? ""
////                    }
////                    self.showAlert(title: "", message: msg)
//                }
            }
        }
    }
    
}
struct RefreshTokenModel: Codable {
   
    let token:String?
    let refreshToken:String?
    let sessionId:String?
    
}
