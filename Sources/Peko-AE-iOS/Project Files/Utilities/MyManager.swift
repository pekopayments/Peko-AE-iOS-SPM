//
//  MyManager.swift
//  Peko
//
//  Created by Hardik Makwana on 03/01/23.
//

// HPM

import UIKit
//import PusherSwift?
//import libPhoneNumber

enum NavigateTo: Int {
    case Onboarding = 0
    case LoginVC
    case TabBarVC
    case ProfileVC
    case LogoutVC
    case FaceID
    case ServiceAccess
    case ChooseCountry
}

enum AppTarget: Int {
    case PEKO_LIVE = 0
    case PEKO_TEST
}

enum AppCountry: Int {
    case NONE = 0
    case UAE
    case INDIA
}

enum SelectedPaymentType: Int {
    case None = 0
    case PekoWallet
    case ApplePay
    case Card
}

enum PaymentPayNow: Int {
    case PekoStore = 0
    case AirTicket
    case SubscriptionPayment
    case Logistics
    case License
    case OfficeAddress
    case GiftCard
    case HotelBooking
    case PhoneBill
    case UtilityBill
    case DocumentAttestation
    case ZeroCarbon
    case eSIM
    case MobileRechargePrepaid
    case MobileRechargePostpaid
    case UtilityBillIndia
    case PekoCloud
    case BusinessEmail
    case BillBulkPayment
    case DubaiPolice
    case eSign
}

//@MainActor let objShareManager = MyManager.sharedInstance

@MainActor let objShareManager = MyManager.sharedInstance

@MainActor
class MyManager: NSObject {
     static let sharedInstance = MyManager()
    var navigateToViewController:NavigateTo = NavigateTo(rawValue: 0)!
   // var pusher:Pusher?
    
   
    override init() {
        super.init()
        // HPM
        /*
        let options = PusherClientOptions(
            host: .cluster("ap2")
        )
        
        if appTarget == .PEKO_LIVE {
            self.pusher = Pusher(key: "e9224e6a3689e809ee15", options: options)
        }else{
            self.pusher = Pusher(key: "c071f84777ea23ecd9a6", options: options)
            // 7cfcb9180f6d9321247a
        }
        self.pusher!.connect()
        */
    }
    
    func getAppleMetchantID(paymentPayNow:PaymentPayNow) -> String {
        
        if objShareManager.appTarget == .PEKO_LIVE {
            if objShareManager.selectedCountry == .UAE {
                if paymentPayNow == .PhoneBill || paymentPayNow == .UtilityBill || paymentPayNow == .License {
                    return Constants.Apple_Merchant_ID_Live_Mobile
                }else{
                    return Constants.Apple_Merchant_ID_Live_Others
                }
            }else if objShareManager.selectedCountry == .INDIA {
               // areaCode = "91"
            }
            
            
        }else if objShareManager.appTarget == .PEKO_TEST {
            if objShareManager.selectedCountry == .UAE {
                return Constants.Apple_Merchant_ID_Sandbox
            }else if objShareManager.selectedCountry == .INDIA {
               // areaCode = "91"
            }
            
            
        }else{
            
        }
        return ""
    }
   
    public lazy var appTarget: AppTarget? = .PEKO_TEST
    /*
    {
        let bundleID = Bundle.main.bundleIdentifier
        
        if bundleID == "com.app.peko.payment" {
            return .PEKO_LIVE
        }
//        else if bundleID == "com.app.peko.india" {
//            return .PekoIndia
//        }
        else if bundleID == "com.app.peko.payment.uat" {
            return .PEKO_TEST
        }
        return .PEKO_LIVE
    }()
    */
     var selectedCountry: AppCountry {
         get{
             /*
             let country = UserDefaults.standard.integer(forKey: "SELECTED_APP_COUNTRY")
             
             if country == 0 {
                 if let code = Locale.current.regionCode {
                     if code == "IN" {
                         return .INDIA
                     }
                     return .UAE
                 }
             }
             return AppCountry(rawValue: country)!
             */
             return .UAE
         }set{
             UserDefaults.standard.set(newValue.rawValue, forKey: "SELECTED_APP_COUNTRY")
             UserDefaults.standard.synchronize()
         }
    }
    
    func getColorStatusColor(status:OredrStatusType) -> OrderStatusColor {
        
        switch status {
        case .Success:
            return OrderStatusColor(textColor: UIColor(red: 16/255.0, green: 197/255.0, blue: 0, alpha: 1.0), backgroundColor: UIColor(red: 237/255.0, green: 255/255.0, blue: 239/255.0, alpha: 1.0))
            //            break
        case .Cancel:
            return OrderStatusColor(textColor: UIColor(red: 241/255.0, green: 80/255.0, blue: 70/255.0, alpha: 1.0), backgroundColor: UIColor(red: 255/255.0, green: 242/255.0, blue: 234/255.0, alpha: 1.0))
            
            //            break
        case .Other:
            return OrderStatusColor(textColor: UIColor(red: 183/255.0, green: 137/255.0, blue: 18/255.0, alpha: 1.0), backgroundColor: UIColor(red: 255/255.0, green: 253/255.0, blue: 212/255.0, alpha: 1.0))
            //            break
            
        }
        // return UIFont(name: self.rawValue, size: CGFloat(size))!
    }
    /*
    // MARK: - Validate Phone / Mobile Number
    func validatePhoneNumber(phoneNumber: String, regionCode: String) -> Bool {
      
        let phoneUtil = NBPhoneNumberUtil.sharedInstance() //NBPhoneNumberUtil()
        do {
            let number = try phoneUtil.parse(phoneNumber, defaultRegion: regionCode)
            return phoneUtil.isValidNumber(number) ?? false
        } catch {
            return false
        }
      
     }
     */

}

