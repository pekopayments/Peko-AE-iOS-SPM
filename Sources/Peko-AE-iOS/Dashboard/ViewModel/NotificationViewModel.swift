//
//  NotificationViewModel.swift
//  Peko
//
//  Created by Hardik Makwana on 16/03/24.
//

import UIKit
import Peko_AE_iOS_Utility

struct NotificationViewModel {
    
    
    func getAllNotifications(fromDate:Date, toDate:Date, page:Int, response: @escaping (AllNotificationResponseDataModel?, _ error: Error?) -> Void) {
      
//        let fromDate = Date().addYears(years: -1)
//        let toDate = Date()
        let limit = 10
        
        let url = ApiEnd().GET_ALL_NOTIFICATION + "?fromDate=\(fromDate.formate()) 00:00:00&toDate=\(toDate.formate()) 23:59:59&page=\(page)&pageSize=\(limit)"
       
        WSManager.getRequest(url: url, resultType: AllNotificationResponseDataModel.self) { result, error in
            response(result!, error)
        }
    }
    func getNotificationsCount(response: @escaping (ResponseModel<NotificationResponseDataModel>?, _ error: Error?) -> Void) {
      
        let url = ApiEnd().GET_NOTIFICATION_COUNT
       
        WSManager.getRequest(url: url, resultType: ResponseModel<NotificationResponseDataModel>.self) { result, error in
            response(result, error)
        }
    }
    func resetNotificationCount(response: @escaping (CommonResponseModel?, _ error: Error?) -> Void) {
      
        let url = ApiEnd().GET_NOTIFICATION_COUNT
       
        WSManager.putRequest(url: url, param: [:], resultType: CommonResponseModel.self) { result, error in
            response(result, error)
        }
    }
}


