//
//  UpgradeResponseModel.swift
//  Peko
//
//  Created by Hardik Makwana on 20/10/24.
//

import UIKit
import Peko_AE_iOS_Utility

struct UpgradeResponseModel: Codable, @unchecked Sendable {
    let redirectUrl:String?
}


struct UpgradeServiceAccessResponseModel: Codable, @unchecked Sendable {
    let packageName:String?
    let userAccessibleServices:[String]?
    let data:[UpgradeServiceAccessDataModel]?
}

struct UpgradeServiceAccessDataModel: Codable, @unchecked Sendable{
  
    let label:String?
    var hasAccess:Bool?
    
    let accessKey:String?
  //  let serviceProviderId:Int?
       
    var subServices:[UpgradeServiceAccessDataModel]?
    
}


struct UpgradePackageResponseModel: Codable, @unchecked Sendable {
    let packages:[UpgradePackageModel]?
    let currentPackageId:CustomInt?
    let currentPlanPriorityLevel:CustomInt?

}
struct UpgradePackageModel: Codable, @unchecked Sendable {
  
    let id:Int?
    let packageName:String?
    let description:String?
   
    let priorityLevel:Int?
   
    let serviceList:String?
    let packageLogo:String?
   
    let packagePrices:UpgradePackagePriceDiscountModel?
    let discount:UpgradePackagePriceDiscountModel?
    
    let individualPackages:UpgradePackageIndividualModel?
  
}

struct UpgradePackagePriceDiscountModel: Codable, @unchecked Sendable{
    let monthly:CustomDouble?
    let annually:CustomDouble?
}

struct UpgradePackageIndividualModel: Codable, @unchecked Sendable{
    let Payroll:CustomDouble?
    let Hub:CustomDouble?
    let eSign:CustomDouble?
    let Invoicing:CustomDouble?
    let Peko:CustomDouble?
}


struct SubscriptionIndividualDetailsModel: Codable, @unchecked Sendable{
    
    let packageDetails:[SubscriptionPackageDetailsModel]?
    let isPurchased:Bool?
    let previousSubscription:PreviousSubscriptionPackageDetailsModel?
    
}
struct SubscriptionPackageDetailsModel: Codable, @unchecked Sendable{
    
//    let packagePrices:UpgradePackagePriceDiscountModel?
//    let discount:UpgradePackagePriceDiscountModel?
    
    let id:Int?
    let packageName:String?
  
    let description:String?
    let priorityLevel:String?
   
    let packagePrices:UpgradePackagePriceDiscountModel?
    let discount:UpgradePackagePriceDiscountModel?
}

struct PreviousSubscriptionPackageDetailsModel: Codable, @unchecked Sendable{
    let billingType:String?
    let status:String?
  
    let packageId:Int?
    let packageName:String?
  
}
