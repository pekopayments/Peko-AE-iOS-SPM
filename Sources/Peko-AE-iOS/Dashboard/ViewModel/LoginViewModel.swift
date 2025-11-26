//
//  LoginViewModel.swift
//  Peko
//
//  Created by Hardik Makwana on 04/01/23.
//

import UIKit
import Peko_AE_iOS_Utility

public struct LoginViewModel {
    public init(){
        
    }
    public func userLogin(username:String, password:String, response: @escaping (ResponseModel<LoginDataModel>?, _ error: Error?) -> Void) {
        let parameter = [
            "username":username,
            "password":password
        ]
      //  parameter.toJSON()
        WSManager.postRequest(url: ApiEnd().LOGIN_URL, param: parameter, resultType: ResponseModel<LoginDataModel>.self) { result, error  in
            response(result, error)
        }
    }
    public func logout(response: @escaping (CommonResponseModel?, _ error: Error?) -> Void) {
        
        WSManager.postRequest(url: ApiEnd().LOGOUT_URL, param: [:], resultType: CommonResponseModel.self) { result, error  in
            response(result, error)
        }
    }
    
}


//struct LoginDataModel:Codable, @unchecked Sendable {
//    let id: Int?
//    let corporateId: Int?
//    let subCorporateId: Int?
//   
//    let username:String?
//    let token:String?
//    let refreshToken:String?
//    let role:String?
//    let roleName:String?
//    let sessionId:String?
//    
//    let packageName:String?
//    let acs_user_id:String?
//    let branding:String?
//   
//    let midPending:Bool?
//   
//}
