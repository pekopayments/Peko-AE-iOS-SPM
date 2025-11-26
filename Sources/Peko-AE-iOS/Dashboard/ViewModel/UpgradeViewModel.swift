//
//  UpgradeViewModel.swift
//  Peko
//
//  Created by Hardik Makwana on 20/10/24.
//

import UIKit
import Peko_AE_iOS_Utility

struct UpgradeViewModel {
    
    func getServiceAccess(response: @escaping (ResponseModel<UpgradeServiceAccessResponseModel>?, _ error: Error?) -> Void) {
    
        let url = ApiEnd().UPGRADE_SERVICE_ACCESS
        
        WSManager.getRequest(url: url, resultType: ResponseModel<UpgradeServiceAccessResponseModel>.self) { result, error in
            response(result, error)
        }
        
//        WSManager.getRequestJSON(urlString: url, withParameter: [:]) { success, result in
//            print(result?.toJSON())
//        }
    }
    
    func getPackageDetails(response: @escaping (ResponseModel<UpgradePackageResponseModel>?, _ error: Error?) -> Void) {
    
        let url = ApiEnd().UPGRADE_LIST_PACKAGE
        
        WSManager.getRequest(url: url, resultType: ResponseModel<UpgradePackageResponseModel>.self) { result, error in
            response(result, error)
        }
    }
    
    func getIndividualSubscriptionDetails(accessKey:String, serviceAccessKey:String, response: @escaping (ResponseModel<SubscriptionIndividualDetailsModel>?, _ error: Error?) -> Void) {
    
        let url = ApiEnd().SUBSCRIPTION_INDIVIDUAL_DETAILS + "?accessKey=\(accessKey)&serviceAccessKey=\(serviceAccessKey)"
        
        WSManager.getRequest(url: url, resultType: ResponseModel<SubscriptionIndividualDetailsModel>.self) { result, error in
            response(result, error)
        }
    }
    
    
    func notifyAdminForUpgrade(response: @escaping (CommonResponseModel?, _ error: Error?) -> Void) {
    
        let url = ApiEnd().NOTIFY_ADMIN_DETAILS
        
        WSManager.postRequest(url: url, param: [:], resultType: CommonResponseModel.self) { result, error in
            response(result, error)
        }
    }
}
