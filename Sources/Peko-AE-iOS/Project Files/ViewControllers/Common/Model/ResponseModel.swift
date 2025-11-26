//
//  ResponseModel.swift
//  Peko-AE-iOS-Utility
//
//  Created by Hardik Makwana on 24/11/25.
//

import UIKit

//public struct ResponseModel<T>: Codable where T: Codable {
@MainActor
public struct ResponseModel<T>: Codable, Sendable where T: Codable & Sendable {
     
    public var status: CustomBool?
    public var success:Bool?
    
//    var message:String?
//    let error:String?
   
    public let responseCode:String?
    
    public let message:CustomString?
    public let error:CustomString?
    public let errors:CustomString?
    
    public var data: T?
   
}

public struct CommonResponseModel:Codable, Sendable {
    
    public let responseCode:String?
    public let responseMessage:String?
    public let success: Bool?
    public let status: CustomBool?
    public let message:String?
    public let error:String?
    
}
