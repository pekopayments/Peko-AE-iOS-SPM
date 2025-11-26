//
//  NotificationModel.swift
//  Peko
//
//  Created by Hardik Makwana on 16/03/24.
//

import UIKit
import Peko_AE_iOS_Utility

struct AllNotificationResponseDataModel: Codable, @unchecked Sendable{
    let status: CustomString?
    let success:Bool?
    let message:String?
    let error:String?
    let responseCode:String?

    var data: NotificationResponseDataModel?

}




struct NotificationResponseDataModel: Codable, @unchecked Sendable {
   
    let recordsTotal:Int?
    let count:Int?
    let data:[NotificationModel]?
    let pendingRequests:Int?
}
struct NotificationModel: Codable {
    
    let id:Int?
    
    let notificationTitle:String?
    let notificationBrief:String?
    let notificationCategory:String?
    
    let notificationTo:String?
    let notificationBy:String?
    
    let flag:Bool?
    
    let createdAt:String?
    let updatedAt:String?
    
    let scheduleDate:String?
    
}
