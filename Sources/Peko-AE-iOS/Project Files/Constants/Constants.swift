//
//  Constants.swift
//  Peko
//
//  Created by Hardik Makwana on 03/01/23.
//

import UIKit


//let is_live = true
class Constants: NSObject {
    
  //  static let TERMS_CONDITIONS = "https://peko.one/index.php/terms-of-use/"
    
    static let sectorArray = ["Sector 1", "Sector 2", "Sector 3", "Sector 4", "Sector 5", "Sector 6"]
 
    static let companySizeArray = ["1-10", "11-30", "31-75", "75-100", "100 & Above"]

    static let UAE_AGREEMENT_URL = "https://peko.one/ae/platform-agreement"
    static let UAT_PRIVACY_POLICY_URL = "https://peko.one/ae/privacy-policy"
    static let UAT_REFUND_POLICY_URL = "https://peko.one/ae/refund-policy"
    
    static let INDIA_AGREEMENT_URL = "https://peko.one/in/platform-agreement"
    static let INDIA_PRIVACY_POLICY_URL = "https://peko.one/in/privacy-policy"
    static let INDIA_REFUND_POLICY_URL = "https://peko.one/in/refund-policy"
    
    static let support_email = "help@peko.one"
    
    static let UAE_SUPPORT_PHONE_NUMBER = "+971 425 153 54"
    static let INDIA_SUPPORT_PHONE_NUMBER = "+91 9682557501"
    
    static let WhatsAppHelpNumber = "+971800697356"
    
    static let guest_username = "100000484"
    static let guest_password = "Hardik@1234"
    
    static let Apple_Merchant_ID_Live_Mobile = "merchant.com.app.peko.payment.mobile"
    static let Apple_Merchant_ID_Live_Others = "merchant.com.app.peko.payment.others"
    static let Apple_Merchant_ID_Sandbox = "merchant.com.peko.payment"
    
    
//    var DAPI_SDK_APP_KEY:String {
//        if is_live {
//            return "976f7b2b90b06b871d43c2d950c8940f07edb614dcbe45f4a5a820fe3fc979cb"
//        }else{
//            return "80f928a1e94b72f93a00a11ce6ad63adb9eb3fff74b956c9a57033f6c5619991"
//        }
//    }
//    var DAPI_SDK_APP_SECRET:String {
//        if is_live {
//            return "eaef08b860877229e0ec79e2b3756d1c60693e32bf783d910d76b9b774a38695"
//        }else{
//            return "2265fec45c59b9e00baec52001f78d596209c46754045baff3d052b21c59f0f6"
//        }
//    }
    
    
    // MARK: - SHipment Services
    static let logisticsDomesticParcelServiceType = [
        [
            "name":"Overnight (Parcel)",
            "code":"ONP"
        ],
        [
            "name":"Same Day (Parcel)",
            "code":"SDD"
        ]
    ]
    
    static let logisticsDomesticDocumentServiceType = [
        [
            "name":"Overnight (Document)",
            "code":"OND"
        ]
    ]
    
    static let logisticsIntenationalParcelServiceType =  [
//        [
//            "name":"Parcel Express",
//            "code":"GPX"
//        ]
//        ,
        [
            "name":"Priority Parcel",
            "code":"PPX"
        ]
    ]
    static let logisticsIntenationalDocumentServiceType =  [
        [
            "name":"Priority Document Express",
            "code":"PDX"
        ]
    ]
    
    static let OTP_SCOPE = "email" // "both" // //"phone"
    
    
    // Office Address / Workspace
    
    static let officeAddress_LicenseType = ["Existing License", "New License"]
    
    /*
    static let paymentServicesArray = [
        [
            "title":"Bills Payments",
            "icon":"icon_bills",
            "new_icon":"icon_new_bills",
            "index":"0",
            "access_key":""
        ],
        [
            "title":"Office Supplies",
            "icon":"icon_office_supplies",
            "new_icon":"icon_new_office_supplies",
            "index":"1",
            "access_key":"ecommerce"
        ],
        [
            "title":"Softwares",
            "icon":"icon_subscription_payments",
            "new_icon":"icon_new_subscription_payments",
            "index":"2",
            "access_key":"subscription_payments"
        ],
        [
            "title":"Logistics",
            "icon":"icon_logistics",
            "new_icon":"icon_new_logistics",
            "index":"3",
            "access_key":""
        ],
        
        [
            "title":"Air Ticket",
            "icon":"icon_air_tickets",
            "new_icon":"icon_new_air_tickets",
            "index":"4",
            "access_key":"travelApi_airline"
        ],
        
        [
            "title":"Hotels",
            "icon":"icon_hotel_booking",
            "new_icon":"icon_new_hotel_booking",
            "index":"5",
            "access_key":"hotels_api"
        ],
        [
            "title":"Gift Cards",
            "icon":"icon_gift_cards",
            "new_icon":"icon_new_gift_cards",
            "index":"9",
            "access_key":"youGotAGift"
        ],
        [
            "title":"Payroll",
            "icon":"icon_payroll",
            "index":"6",
            "access_key":"payroll",
            "serviceAccessKey":"peko_payroll"
        ],
        [
            "title":"Document Attestation",
            "icon":"icon_document_attestation",
            "index":"8",
            "access_key":"document_attestation"
        ],
        [
            "title":"License Renewal",
            "icon":"icon_license_renewal",
            "index":"12",
            "access_key":""
        ],
        
        [
            "title":"Hub",
            "icon":"icon_peko_cloud",
            "index":"18",
            "access_key":"peko_cloud",
            "serviceAccessKey":"pekoCloud"
        ],
        [
            "title":"eSIM",
            "icon":"icon_eSIM",
            "index":"15",
            "access_key":"esim"
        ],
        
        [
            "title":"Invoicing",
            "icon":"icon_invoicing",
            "index":"7",
            "access_key":"the_collector",
            "serviceAccessKey":"quick_links"
        ],
        [
            "title":"Business Emails",
            "icon":"icon_business_emails",
            "index":"19",
            "access_key":"email_domain_service",
            "serviceAccessKey":""
        ],
        [
            "title":"Business Docs",
            "icon":"icon_business_docs",
            "index":"11",
            "web_url":"/more-services/business-docs",
            "serviceAccessKey":""
        ],
        [
            "title":"Marketplace",
            "icon":"icon_connect",
            "index":"13",
            "web_url":"/marketplace",
            "serviceAccessKey":""
        ],
        /*
         [
             "title":"Connect",
             "icon":"icon_peko_connect",
             "index":"17",
             "access_key":"peko_connect"
         ],
        
        [
            "title":"Insurance",
            "icon":"icon_insurance",
            "index":"16",
            "access_key":""
        ],
         [
            "title":"Tax and More",
            "icon":"icon_taxt_more",
            "index":"19",
            "access_key":""
        ]
        */
    ]
    */
}
/*
enum AppStoryboards {
    
    static let Splash = UIStoryboard(name: "Splash", bundle: .module)
    
    static let Base = UIStoryboard(name: "Base", bundle: .module)

    static let Main = UIStoryboard(name: "Main", bundle: .module)
    static let Onboarding = UIStoryboard(name: "Onboarding", bundle: .module)
    static let Login = UIStoryboard(name: "Login", bundle: .module)
    static let SignUp = UIStoryboard(name: "SignUp", bundle: .module)
    static let CreateAccount = UIStoryboard(name: "CreateAccount", bundle: .module)
    static let FaceID = UIStoryboard(name: "FaceID", bundle: .module)
   
    
    static let Home = UIStoryboard(name: "Home", bundle: .module)
    static let Transactions = UIStoryboard(name: "Transactions", bundle: .module)
    static let Bills = UIStoryboard(name: "Bills", bundle: .module)
    static let IndiaBills = UIStoryboard(name: "IndiaBills", bundle: .module)
  
    
    static let Analytics = UIStoryboard(name: "Analytics", bundle: .module)
    static let ServiceAccess = UIStoryboard(name: "ServiceAccess", bundle: .module)
    static let  PekoCredits = UIStoryboard(name: "PekoCredits", bundle: .module)
   
    static let Settings = UIStoryboard(name: "Settings", bundle: .module)
    static let About = UIStoryboard(name: "About", bundle: .module)
    static let Account = UIStoryboard(name: "Account", bundle: .module)
    static let Referral = UIStoryboard(name: "Referral", bundle: .module)
   
    static let SubCorporate = UIStoryboard(name: "SubCorporate", bundle: .module)
   
    static let Reports = UIStoryboard(name: "Reports", bundle: .module)
   
    
    
    static let Notification = UIStoryboard(name: "Notification", bundle: .module)
    static let Help = UIStoryboard(name: "Help", bundle: .module)
    static let Profile = UIStoryboard(name: "Profile", bundle: .module)
    static let ManageBeneficiary = UIStoryboard(name: "ManageBeneficiary", bundle: .module)
    
    static let PekoClub = UIStoryboard(name: "PekoClub", bundle: .module)
    static let Upgrade = UIStoryboard(name: "Upgrade", bundle: .module)
    
    static let BulkPayment = UIStoryboard(name: "BulkPayment", bundle: .module)
    static let Phone_Bill = UIStoryboard(name: "Phone_Bill", bundle: .module)
    static let Pay_Later = UIStoryboard(name: "Pay_Later", bundle: .module)
    static let Air_Ticket = UIStoryboard(name: "Air_Ticket", bundle: .module)
    static let AirTicketIndia = UIStoryboard(name: "AirTicketIndia", bundle: .module)
  
    
    
    static let Beneficiary = UIStoryboard(name: "Beneficiary", bundle: .module)
  
    
    static let DubaiPolice = UIStoryboard(name: "DubaiPolice", bundle: .module)
    static let Utility = UIStoryboard(name: "Utility", bundle: .module)
    static let GiftCards = UIStoryboard(name: "GiftCards", bundle: .module)
    static let PekoStore = UIStoryboard(name: "PekoStore", bundle: .module)
    static let PaymentsLinks = UIStoryboard(name: "PaymentsLinks", bundle: .module)
    static let PekoConnect = UIStoryboard(name: "PekoConnect", bundle: .module)
    
    static let InvoiceGenerator = UIStoryboard(name: "InvoiceGenerator", bundle: .module)
    static let CreateInvoice = UIStoryboard(name: "CreateInvoice", bundle: .module)
    static let KYB = UIStoryboard(name: "KYB", bundle: .module)
   
    
    
    static let Carbon = UIStoryboard(name: "Carbon", bundle: .module)
    static let Workspace = UIStoryboard(name: "Workspace", bundle: .module)
    static let SubscriptionPayments = UIStoryboard(name: "SubscriptionPayments", bundle: .module)
    
    static let HotelBooking = UIStoryboard(name: "HotelBooking", bundle: .module)
    static let CorporateTravel = UIStoryboard(name: "CorporateTravel", bundle: .module)
    static let eSim = UIStoryboard(name: "eSIM", bundle: .module)
    static let TraveleSIM = UIStoryboard(name: "TraveleSIM", bundle: .module)
    
    
    static let DocumentAttestation = UIStoryboard(name: "DocumentAttestation", bundle: .module)
  
    static let Payroll = UIStoryboard(name: "Payroll", bundle: .module)
    static let PayrollEmpDept = UIStoryboard(name: "PayrollEmpDept", bundle: .module)
    static let PayrollWPS = UIStoryboard(name: "PayrollWPS", bundle: .module)
    static let PayrollLeave = UIStoryboard(name: "PayrollLeave", bundle: .module)
    static let PayrollSalary = UIStoryboard(name: "PayrollSalary", bundle: .module)
    static let PayrollCalendar = UIStoryboard(name: "PayrollCalendar", bundle: .module)
    static let Insurance = UIStoryboard(name: "Insurance", bundle: .module)
    static let Connect = UIStoryboard(name: "Connect", bundle: .module)
    static let PekoCloud = UIStoryboard(name: "PekoCloud", bundle: .module)
   
    static let BusinessEmails = UIStoryboard(name: "BusinessEmails", bundle: .module)
    static let ESign = UIStoryboard(name: "ESign", bundle: .module)
   
    static let Common = UIStoryboard(name: "Common", bundle: .module)
    static let OTP = UIStoryboard(name: "OTP", bundle: .module)
  
    
    static let License = UIStoryboard(name: "License", bundle: .module)
   
    static let Logistics = UIStoryboard(name: "Logistics", bundle: .module)
    static let BusinessDocs = UIStoryboard(name: "BusinessDocs", bundle: .module)
   
    
    static let MobileRecharge = UIStoryboard(name: "MobileRecharge", bundle: .module)
    static let Electricity = UIStoryboard(name: "Electricity", bundle: .module)
   
    static let ForgotPassword = UIStoryboard(name: "ForgotPassword", bundle: .module)
   
    
    static let Payment = UIStoryboard(name: "Payment", bundle: .module)
    static let PaymentIndia = UIStoryboard(name: "PaymentIndia", bundle: .module)
    static let PaymentUAE = UIStoryboard(name: "PaymentUAE", bundle: .module)
   
    
    /*
    
    
    
    
    */
}
enum AppFonts : String{
    
    case Light = "Roboto-Light"
    case Regular = "Roboto-Regular"
    case Medium = "Roboto-Medium"
    case SemiBold = "Inter-SemiBold"
    case Bold = "Roboto-Bold"
    case ExtraBold = "Inter-ExtraBold"
    
    func size(size:Float) -> UIFont {
        return UIFont(name: self.rawValue, size: CGFloat(size))!
    }
}

struct AppColors {
    
    static let borderThemeColor = UIColor(named: "BorderThemeColor")
    static let blackThemeColor = UIColor(named: "BlackThemeColor")
    static let backgroundThemeColor = UIColor(named: "BackgroundThemeColor")
    static let darkThemeColor = UIColor(named: "DarkThemeColor")

    static let greenThemeColor = UIColor(named: "GreenThemeColor")
   
    static let color_EA4C36 = UIColor(named: "EA4C36")
    static let color_8A8A8A = UIColor(named: "8A8A8A")
}
*/
enum OredrStatusType {
    case Success
    case Cancel
    case Other
}
    
struct OrderStatusColor {
    var textColor, backgroundColor: UIColor?
}

// Screen width.
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

// Screen height.
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}

