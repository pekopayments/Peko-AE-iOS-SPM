//
//  UIViewController+Extension.swift
//  SMAT
//
//  Created by Hardik Makwana on 06/10/22.
//

import UIKit
import SafariServices

public extension UIViewController {
    
    public func showError(error: Error?){
        
        if objShareManager.appTarget == .PEKO_LIVE {
            self.showAlert(title: "", message: "Something went wrong please try again")
        }else {
            self.showAlert(title: "", message: error?.localizedDescription ?? "")
        }
        
    }
    public func showAlert(title:String, message:String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
    }
    @MainActor
    func showAlertWithCompletion(title:String, message:String, completion: @escaping ((UIAlertAction)->Void)){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default,handler: completion))
        self.present(alert, animated: true)
    }
    
    func openURL(urlString:String, inSideApp:Bool = true){
        
        if inSideApp {
            if let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = false
                let vc = SFSafariViewController(url: url, configuration: config)
                present(vc, animated: true)
            }
        }else{
            if let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!), UIApplication.shared.canOpenURL(url) {
                
                print("************** URL => ", url)
                UIApplication.shared.open(url)
            }
        }
        
    }
    
    // MARK: - Back Button
    @IBAction func backButtonClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    // MARK: - Go to Service Page
    /*
    func goToServicePage(serviceName:String) {
        let tmpArray = objServiceAccessManager.serviceListArray.filter { $0.label == serviceName }
        
        if tmpArray.count > 0, let model = tmpArray.first, model.hasAccess == true {
            let dic = objServiceAccessManager.allPaymentServicesDictionary[model.label ?? ""]!
            self.goToServicePage(dic: dic)
            return
        }
        
        if tmpArray.count == 0 {
            self.showAlert(title: "", message: "Sorry, you do not have permission to access this page. For assistance, kindly reach out to our support team.")
            return
        }
        
    }
    
    func goToServicePage(dic:PekoPaymentServiceModel) {
        
        //   let title = dic.title
        let index = dic.index
        let access_key = dic.access_key
        let serviceAccessKey = dic.serviceAccessKey
        
        if access_key.count != 0 && serviceAccessKey.count != 0 {
            HPProgressHUD.show()
            UpgradeViewModel().getIndividualSubscriptionDetails(accessKey: access_key, serviceAccessKey: serviceAccessKey) { response, error in
                HPProgressHUD.hide()
                if error != nil {
                    if objShareManager.appTarget == .PEKO_LIVE {
                        self.showAlert(title: "", message: "Something went wrong please try again")
                    }else {
                        self.showAlert(title: "", message: error?.localizedDescription ?? "")
                    }
                }else if let status = response?.status?.value, status == true {
                    DispatchQueue.main.async {
                        
                        if response?.data?.isPurchased ?? false {
                            self.serviceIndex(index: index)
                        }else{
                            
                            if objUserSession.sub_corporate_id == 0 {
                                if let vc = UpgradeViewController.storyboardInstance() {
                                    //   vc.serviceDictionary = dic
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                            }else{
                                if let vc = UpgradeSubCorporateViewController.storyboardInstance() {
                                    //   vc.serviceDictionary = dic
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                            }
                        }
                    }
                }else{
                    let error = ErrorModel(code: response?.responseCode, message: response?.message?.value, error: response?.error?.value, errors: response?.errors?.value)
                  
                    objErrorManager.manageFailResponse(error: error, viewController: self) { isReload in
                        if isReload {
                            self.goToServicePage(dic: dic)
                        }
                    }
                }
            }
        }else{
            self.serviceIndex(index: index)
        }
    }
    func serviceIndex(index:Int) {
        switch index {
        case 0: // Bills
            if objShareManager.selectedCountry == .UAE {
                if let billsVC = BillsViewController.storyboardInstance() {
                    self.navigationController?.pushViewController(billsVC, animated: true)
                }
            }else{
                if let billsVC = IndiaBillsViewController.storyboardInstance() {
                    self.navigationController?.pushViewController(billsVC, animated: true)
                }
            }
            break
        case 1: // Office Supplies
            objPekoStoreManager = PekoStoreManager.sharedInstance
            if let storeVC = PekoStoreDashboardViewController.storyboardInstance() {
                self.navigationController?.pushViewController(storeVC, animated: true)
            }
            break
        case 2: // SubscriptionPayments
            if let subscriptionPaymentsVC = SubscriptionPaymentsViewController.storyboardInstance() {
                self.navigationController?.pushViewController(subscriptionPaymentsVC, animated: true)
            }
            break
        case 3: // Logistics
            DispatchQueue.main.async {
                if let logisticsVC = LogisticsDashboardViewController.storyboardInstance() {
                    self.navigationController?.pushViewController(logisticsVC, animated: true)
                }
            }
            break
        case 4: // Air Ticket
            if let airTicketVC = AirTicketViewController.storyboardInstance() {
                self.navigationController?.pushViewController(airTicketVC, animated: true)
            }
            break
        case 5: // Hotels
            if let hotelVC = CorporateTravelDashboardViewController.storyboardInstance() {
                hotelVC.travelType = 1
                self.navigationController?.pushViewController(hotelVC, animated: true)
            }
            break
        case 6: // Payroll
            if let vc = PayrollGetStartedViewController.storyboardInstance() {
                self.navigationController?.pushViewController(vc, animated: true)
            }
            //            if let vc = PayrollDashboardViewController.storyboardInstance() {
            //                self.navigationController?.pushViewController(vc, animated: true)
            //            }
            //  self.showAlert(title: "", message: "Coming Soon")
            break
            
        case 7:  //  Invoicing
            if let invoiceVC = InvoicingDashboardViewController.storyboardInstance() {
                self.navigationController?.pushViewController(invoiceVC, animated: true)
            }
            break
        case 8: // Document Attenstation
            if let vc = DocumentAttestationViewController.storyboardInstance() {
                self.navigationController?.pushViewController(vc, animated: true)
            }
            break
        case 9: // Gift Card
            if let giftCardVC = GiftCardsProductsViewController.storyboardInstance() {
                self.navigationController?.pushViewController(giftCardVC, animated: true)
            }
            break
            
        case 10: // Business Docs
            if let businessVC = BusinessDocsViewController.storyboardInstance() {
                self.navigationController?.pushViewController(businessVC, animated: true)
            }
            break
        case 11: // License Renewal
            if let licenseVC = LicenseRenewalViewController.storyboardInstance() {
                self.navigationController?.pushViewController(licenseVC, animated: true)
            }
            break
        case 12: // Marketplace
            if let connectVC = PekoConnectDashboardViewController.storyboardInstance() {
                self.navigationController?.pushViewController(connectVC, animated: true)
            }
            break
            //        case 13: // Office Addresses
            //            if let workspaceVC = WorkspaceViewController.storyboardInstance() {
            //                self.navigationController?.pushViewController(workspaceVC, animated: true)
            //            }
            //            break
        case 13: // eSIM
            if let eSIMVC = TraveleSIMDashboardViewController.storyboardInstance() {
                self.navigationController?.pushViewController(eSIMVC, animated: true)
            }
            break
            //        case 16: // Insurance
            //            if let insuranceVC = InsuranceViewController.storyboardInstance() {
            //                self.navigationController?.pushViewController(insuranceVC, animated: true)
            //            }
            //            break
            //        case 17: // Connect
            //            if let connectVC = ConnectDashboardViewController.storyboardInstance() {
            //                self.navigationController?.pushViewController(connectVC, animated: true)
            //            }
            //  break
        case 14: // Peko Cloud
            if let pekoCloudVC = PekoCloudDashboardViewController.storyboardInstance() {
                self.navigationController?.pushViewController(pekoCloudVC, animated: true)
            }
            break
        case 15: // Business Emails
            if let businessEmailsVC = BusinessEmailsViewController.storyboardInstance() {
                self.navigationController?.pushViewController(businessEmailsVC, animated: true)
            }
            break
        case 16: // eSign
            if let eSignVC = ESignDashboardViewController.storyboardInstance() {
                self.navigationController?.pushViewController(eSignVC, animated: true)
            }
            break
        case 17: // Peko India Mobile recharge
            if let vc = MobileRechargeDashboardViewController.storyboardInstance() {
                self.navigationController?.pushViewController(vc, animated: true)
            }
            break
            
            
            //        case 10: // Carbon Footprint
            //            if let carbonVC = CarbonDashboardViewController.storyboardInstance() {
            //                self.navigationController?.pushViewController(carbonVC, animated: true)
            //            }
            //            break
            
        default:
            break
        }
    }
    
    */
}
