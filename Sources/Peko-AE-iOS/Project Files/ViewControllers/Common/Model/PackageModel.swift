//
//  PackageModel.swift
//  Peko
//
//  Created by Hardik Makwana on 15/03/23.
//

import UIKit

public struct PackageModel: Codable {
    public let id:Int?
    public let status:Int?
    
    public let packageName:String?
    public let packageLogo:String?
    public let packagePrice:String?
    public let description:String?
    public let serviceList:String?
   
    public let packageType:String?
   
    public let createdAt:String?
    public let updatedAt:String?
 
    public let packagePrices:PackagePricesModel?
    public let discount:PackagePricesModel?
    
}
public struct PackagePricesModel: Codable {
    public let monthly:CustomDouble?
    public let annually:CustomDouble?
}
