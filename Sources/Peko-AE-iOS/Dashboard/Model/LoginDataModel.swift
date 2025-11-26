//
//  LoginResponse.swift
//  Peko
//
//  Created by Hardik Makwana on 04/01/23.
//

import UIKit

//struct LoginResponse : Codable {
//
//    let status: Bool?
//    let message:String?
//    let data: LoginModel?
//    enum CodingKeys: String, CodingKey {
//        case status = "success"
//        case message
//        case data
//    }
//    
//    
//}

public struct LoginRequest : Encodable
{
    public var email, password: String?
    public init(email: String? = nil, password: String? = nil) {
        self.email = email
        self.password = password
    }
}

public struct LoginDataModel:Codable, @unchecked Sendable {
    public let id: Int?
    public let corporateId: Int?
    public let subCorporateId: Int?
   
    public let username:String?
    public let token:String?
    public let refreshToken:String?
    public let role:String?
    public let roleName:String?
    public let sessionId:String?
    
    public let packageName:String?
    public let acs_user_id:String?
    public let branding:String?
   
    public let midPending:Bool?
   
//    enum CodingKeys: String, CodingKey {
//        case id
//        case username
//        case token
//        case role
//        case refreshToken
//    }
}

