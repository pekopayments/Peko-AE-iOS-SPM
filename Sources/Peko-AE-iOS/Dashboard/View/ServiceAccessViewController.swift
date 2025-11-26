//
//  ServiceAccessViewController.swift
//  Peko
//
//  Created by Hardik Makwana on 01/03/25.
//

import UIKit
import CodableFirebase
import Peko_AE_iOS_Utility

public class ServiceAccessViewController: UIViewController {

    public static func storyboardInstance() -> ServiceAccessViewController? {
        return AppStoryboards.ServiceAccess.instantiateViewController(identifier: "ServiceAccessViewController") as? ServiceAccessViewController
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
      
        self.getServiceAccess()
      
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Get Service Access
    func getServiceAccess(){
        UpgradeViewModel().getServiceAccess { response, error in
            if error != nil {
                if PekoUtility().appTarget == .PEKO_LIVE {
                    self.showAlert(title: "", message: "Something went wrong please try again")
                }else {
                    self.showAlert(title: "", message: error?.localizedDescription ?? "")
                }

            }else if let status = response?.status?.value, status == true {
                DispatchQueue.main.async {
                    print(response?.data)
                    
                    let data = response?.data?.data ?? [UpgradeServiceAccessDataModel]()
                    self.filterServices(data: data)
                }
            }else{
                let error = ErrorModel(code: response?.responseCode, message: response?.message?.value, error: response?.error?.value, errors: response?.errors?.value)
              
                ErrorManager().manageFailResponse(error: error, viewController: self) { isReload in
                    if isReload {
                        self.getServiceAccess()
                    }
                }
            }
        }
    }
    
    // MARK: - Filter Services
    func filterServices(data:[UpgradeServiceAccessDataModel]){
        let array = data.filter { $0.hasAccess == true }
        print(array)
       
        objServiceAccessManager.serviceListArray = array.filter { objServiceAccessManager.servicesAccesskeyArray.contains( $0.accessKey ?? "") }
        
        let tmp = array.filter { $0.label == "Bill Payments" }
        
        if tmp.count > 0 {
            objServiceAccessManager.serviceListArray.insert(tmp.first!, at: 0)
        }
  
        let tmp0 = array.filter { $0.label == "Mobile Recharge" }
        
        if tmp0.count > 0 {
            objServiceAccessManager.serviceListArray.insert(tmp0.first!, at: 0)
        }
        
        objServiceAccessManager.serviceListArray.removeAll { $0.label == "Payment Links" }
        
        
        let tmp1 = array.filter { $0.label == "Dashboard" }
        
        if tmp1.count > 0 {
            objServiceAccessManager.isHasAccessDashboard = true
        }else{
            objServiceAccessManager.isHasAccessDashboard = false
        }
        
        let tmp2 = array.filter { $0.label == "Reports" }
       
        objServiceAccessManager.isHasAccessReports = false
        if tmp2.count > 0, let firstObj = tmp2.first {
            
            objServiceAccessManager.isHasAccessReports = firstObj.hasAccess ?? false
            
            if let subServices = firstObj.subServices {
                
                let obj4 = subServices.filter { $0.label == "Subscription Transactions" }
                objServiceAccessManager.isHasAccessSubscriptionTransactions = false
                if obj4.count > 0, let first = obj4.first {
                    objServiceAccessManager.isHasAccessSubscriptionTransactions = first.hasAccess ?? false
                }
                
                let obj3 = subServices.filter { $0.label == "Scheduling Reports" }
                objServiceAccessManager.isHasAccessSchedulingReports = false
                if obj3.count > 0, let first = obj3.first {
                    objServiceAccessManager.isHasAccessSchedulingReports = first.hasAccess ?? false
                }
                
                let obj2 = subServices.filter { $0.label == "Cashbacks" }
                objServiceAccessManager.isHasAccessCashback = false
                if obj2.count > 0, let first = obj2.first {
                    objServiceAccessManager.isHasAccessCashback = first.hasAccess ?? false
                }
                
                let obj1 = subServices.filter { $0.label == "Transactions" }
                objServiceAccessManager.isHasAccessTransaction = false
                if obj1.count > 0, let first = obj1.first {
                    objServiceAccessManager.isHasAccessTransaction = first.hasAccess ?? false
                }
            }
            
        }
        
        let tmp3 = array.filter { $0.label == "Need Help" }
        if tmp3.count > 0, let first = tmp3.first {
            objServiceAccessManager.isHasAccessHelpNeed = first.hasAccess ?? false
            
            if let subServices = first.subServices {
                let contact = subServices.filter { $0.label == "Contact Us" }
                if contact.count > 0, let hasAccess = contact.first?.hasAccess {
                    objServiceAccessManager.isHasAccessContactUs = hasAccess
                }
                
                let tickets = subServices.filter { $0.label == "Tickets" }
                if tickets.count > 0, let hasAccess = tickets.first?.hasAccess {
                    objServiceAccessManager.isHasAccessTickets = hasAccess
                }
            }
           
        }else{
            objServiceAccessManager.isHasAccessHelpNeed = false
        }
        
        let tmp4 = array.filter { $0.label == "Settings" }
        
        if tmp4.count > 0, let first = tmp4.first {
            
            objServiceAccessManager.isHasAccessSettings = first.hasAccess ?? false
            
            if let subServices = first.subServices {
                let userManagement = subServices.filter { $0.label == "User Management" }
                if userManagement.count > 0, let hasAccess = userManagement.first?.hasAccess {
                    objServiceAccessManager.isHasAccessUserManagement = hasAccess
                }
                
                let savedCards = subServices.filter { $0.label == "Billing & Saved Cards" }
                if savedCards.count > 0, let hasAccess = savedCards.first?.hasAccess {
                    objServiceAccessManager.isHasAccessSavedCards = hasAccess
                }
                
                let plans = subServices.filter { $0.label == "Subscription Plans" }
                if plans.count > 0, let hasAccess = plans.first?.hasAccess {
                   // objServiceAccessManager.isHasAccessSecurity = hasAccess
                }
                
                let security = subServices.filter { $0.label == "Security" }
                if security.count > 0, let hasAccess = security.first?.hasAccess {
                    objServiceAccessManager.isHasAccessSecurity = hasAccess
                }
            }
          
        }else{
            objServiceAccessManager.isHasAccessSecurity = false
        }
      
        // HPM
        if let objHomeVC = HomeViewController.storyboardInstance() {
            self.navigationController?.pushViewController(objHomeVC, animated: false)
        }
        
    }
    
}
