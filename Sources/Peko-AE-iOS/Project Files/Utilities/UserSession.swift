//
//  UserSession.swift
//  Peko
//
//  Created by Hardik Makwana on 19/01/23.
//

import UIKit

@MainActor let objUserSession = UserSession.sharedInstance

@MainActor
class UserSession: NSObject {

    @MainActor static let sharedInstance = UserSession()
   
    override init() {
        super.init()
    }
    
    static let kUserIsLoggedIn = "User_Is_Logged_In"
    static let kUserID = "User_Id"
    static let kUserName = "User_Name"
    static let kSubCorporateID = "Sub_Corporate_Id"
    
    static let kEmail = "Email"
    static let kFirstName = "First_Name"
    static let kLastName = "Last_Name"
    static let kMobileNo = "Mobile_No"
    static let kLandlineNo = "Landline_No"
    static let kCompanyName = "Company_Name"
    static let kCompanyLogo = "Company_Logo"
  
    static let kPackage = "Package"
  
    static let kUserRole = "User_Role"
    static let kUserToken = "User_Token"
    static let kUserRefreshToken = "User_Refresh_Token"
    static let kSessionId = "Session_Id"
    
    static let kCountry = "Country "
    static let kCountryCode = "CountryCode"
   
    static let kWebsite = "Website"
   
    static let kProfileDetails = "ProfileDetails"
   
    static let kTotalSpendCurrentMonth = "TotalSpendCurrentMonth"
    static let kTotalSpend = "TotalSpend"
    static let kTotalCashback = "TotalCashback"
    static let kWalletBalance = "WalletBalance"
    
    static let kFCMTOKEN = "FCM_Token"
   
    static let kReferralURL = "REFERRAL_URL"
   
    static let KSavedUsername = "saved_username"
    static let KSavedPassword = "saved_password"
  
    var is_login:Bool {
        get{
            return UserDefaults.standard.bool(forKey: UserSession.kUserIsLoggedIn)
        }set{
            UserDefaults.standard.setValue(newValue, forKey: UserSession.kUserIsLoggedIn)
            UserDefaults.standard.synchronize()
        }
    }
    
    var user_id:Int {
        get{
            return UserDefaults.standard.integer(forKey: UserSession.kUserID)
        }set{
            UserDefaults.standard.setValue(newValue, forKey: UserSession.kUserID)
            UserDefaults.standard.synchronize()
        }
    }
    var sub_corporate_id:Int {
        get{
            return UserDefaults.standard.integer(forKey: UserSession.kSubCorporateID)
        }set{
            UserDefaults.standard.setValue(newValue, forKey: UserSession.kSubCorporateID)
            UserDefaults.standard.synchronize()
        }
    }
    
    var role:String {
        get{
            return UserDefaults.standard.string(forKey: UserSession.kUserRole) ?? ""
        }set{
            UserDefaults.standard.setValue(newValue, forKey: UserSession.kUserRole)
            UserDefaults.standard.synchronize()
        }
    }
    
    var username:String {
        get{
            return UserDefaults.standard.string(forKey: UserSession.kUserName) ?? ""
        }set{
            UserDefaults.standard.setValue(newValue, forKey: UserSession.kUserName)
            UserDefaults.standard.synchronize()
        }
    }
    var token:String {
//        get{
//            return UserDefaults.standard.string(forKey: UserSession.kUserToken) ?? ""
//        }set{
//            UserDefaults.standard.setValue(newValue, forKey: UserSession.kUserToken)
//            UserDefaults.standard.synchronize()
//        }
        
        get{
            KeychainService.load(key: UserSession.kUserToken) ?? ""
        }set{
            let success = KeychainService.save(key: UserSession.kUserToken, value: newValue)
            print(success)
        }
        
    }
    var refreshToken:String {
//        get{
//            return UserDefaults.standard.string(forKey: UserSession.kUserRefreshToken) ?? ""
//        }set{
//            UserDefaults.standard.setValue(newValue, forKey: UserSession.kUserRefreshToken)
//            UserDefaults.standard.synchronize()
//        }
        get{
            KeychainService.load(key: UserSession.kUserRefreshToken) ?? ""
        }set{
            let success = KeychainService.save(key: UserSession.kUserRefreshToken, value: newValue)
            print(success)
        }
    }
    
    var sessionId:String {
//        get{
//            return UserDefaults.standard.string(forKey: UserSession.kSessionId) ?? ""
//        }set{
//            UserDefaults.standard.setValue(newValue, forKey: UserSession.kSessionId)
//            UserDefaults.standard.synchronize()
//        }
        
        get{
            KeychainService.load(key: UserSession.kSessionId) ?? ""
        }set{
            let success = KeychainService.save(key: UserSession.kSessionId, value: newValue)
            print(success)
        }
    }
   
    var FCM_Token:String {
        get{
            return UserDefaults.standard.string(forKey: UserSession.kFCMTOKEN) ?? ""
        }set{
            UserDefaults.standard.setValue(newValue, forKey: UserSession.kFCMTOKEN)
            UserDefaults.standard.synchronize()
        }
    }
    var referralURL:String {
        get{
            return UserDefaults.standard.string(forKey: UserSession.kReferralURL) ?? ""
        }set{
            UserDefaults.standard.setValue(newValue, forKey: UserSession.kReferralURL)
            UserDefaults.standard.synchronize()
        }
    }
    
    var savedUsername:String{
//        get{
//            UserDefaults.standard.string(forKey: UserSession.KSavedUsername) ?? ""
//        }set{
//            UserDefaults.standard.set(newValue, forKey: UserSession.KSavedUsername)
//            UserDefaults.standard.synchronize()
//        }
        
        get{
            KeychainService.load(key: UserSession.KSavedUsername) ?? ""
        }set{
            let success = KeychainService.save(key: UserSession.KSavedUsername, value: newValue)
            print(success)
        }
    }
    var savedPassword:String{
//        get{
//            UserDefaults.standard.string(forKey: UserSession.KSavedPassword) ?? ""
//        }set{
//            UserDefaults.standard.set(newValue, forKey: UserSession.KSavedPassword)
//            UserDefaults.standard.synchronize()
//        }
        get{
            KeychainService.load(key: UserSession.KSavedPassword) ?? ""
        }set{
            let success = KeychainService.save(key: UserSession.KSavedPassword, value:newValue )
            print(success)
        }
    }
    
    
        /*
    var email:String {
        get{
            return UserDefaults.standard.string(forKey: UserSession.kEmail) ?? ""
        }set{
            UserDefaults.standard.setValue(newValue, forKey: UserSession.kEmail)
            UserDefaults.standard.synchronize()
        }
    }
    var first_name:String {
        get{
            return UserDefaults.standard.string(forKey: UserSession.kFirstName) ?? ""
        }set{
            UserDefaults.standard.setValue(newValue, forKey: UserSession.kFirstName)
            UserDefaults.standard.synchronize()
        }
    }
    var last_name:String {
        get{
            return UserDefaults.standard.string(forKey: UserSession.kLastName) ?? ""
        }set{
            UserDefaults.standard.setValue(newValue, forKey: UserSession.kLastName)
            UserDefaults.standard.synchronize()
        }
    }
    var company_name:String {
        get{
            return UserDefaults.standard.string(forKey: UserSession.kCompanyName) ?? ""
        }set{
            UserDefaults.standard.setValue(newValue, forKey: UserSession.kCompanyName)
            UserDefaults.standard.synchronize()
        }
    }
    var mobile_number:String {
        get{
            return UserDefaults.standard.string(forKey: UserSession.kMobileNo) ?? ""
        }set{
            UserDefaults.standard.setValue(newValue, forKey: UserSession.kMobileNo)
            UserDefaults.standard.synchronize()
        }
    }
    var landline_number:String {
        get{
            return UserDefaults.standard.string(forKey: UserSession.kLandlineNo) ?? ""
        }set{
            UserDefaults.standard.setValue(newValue, forKey: UserSession.kLandlineNo)
            UserDefaults.standard.synchronize()
        }
    }
    var company_logo:String {
        get{
            return UserDefaults.standard.string(forKey: UserSession.kCompanyLogo) ?? ""
        }set{
            UserDefaults.standard.setValue(newValue, forKey: UserSession.kCompanyLogo)
            UserDefaults.standard.synchronize()
        }
    }
    var country:String {
        get{
            return UserDefaults.standard.string(forKey: UserSession.kCountry) ?? ""
        }set{
            UserDefaults.standard.setValue(newValue, forKey: UserSession.kCountry)
            UserDefaults.standard.synchronize()
        }
    }
    var country_code:String {
        get{
            return UserDefaults.standard.string(forKey: UserSession.kCountryCode) ?? ""
        }set{
            UserDefaults.standard.setValue(newValue, forKey: UserSession.kCountryCode)
            UserDefaults.standard.synchronize()
        }
    }
    
    var website:String {
        get{
            return UserDefaults.standard.string(forKey: UserSession.kWebsite) ?? ""
        }set{
            UserDefaults.standard.setValue(newValue, forKey: UserSession.kWebsite)
            UserDefaults.standard.synchronize()
        }
    }
    
    var package:PackageModel? {
        get{
            if let data = UserDefaults.standard.data(forKey: UserSession.kPackage) {
                do {
                    // Create JSON Decoder
                    let decoder = JSONDecoder()

                    // Decode Note
                    let note = try decoder.decode(PackageModel.self, from: data)

                    return note
                } catch {
                    print("Unable to Decode Note (\(error))")
                }
            }
            return nil
        }set{
            do {
                // Create JSON Encoder
                let encoder = JSONEncoder()

                // Encode Note
                let data = try encoder.encode(newValue)

                // Write/Set Data
                UserDefaults.standard.set(data, forKey: UserSession.kPackage)

            } catch {
                print("Unable to Encode Note (\(error))")
            }
        }
    }
    */
    var profileBasicDetail:ProfileDetailModel?
    var walletDetailsModel:ProfileWalletModel?
    /*
    {
        get{
            if let data = UserDefaults.standard.data(forKey: UserSession.kProfileDetails) {
                do {
                    // Create JSON Decoder
                    let decoder = JSONDecoder()

                    // Decode Note
                    let note = try decoder.decode(ProfileDetailModel.self, from: data)

                    return note
                } catch {
                    print("Unable to Decode Note (\(error))")
                }
            }
            return nil
        }set{
            do {
                // Create JSON Encoder
                let encoder = JSONEncoder()

                // Encode Note
                let data = try encoder.encode(newValue)

                // Write/Set Data
                UserDefaults.standard.set(data, forKey: UserSession.kProfileDetails)

            } catch {
                print("Unable to Encode Note (\(error))")
            }
        }
    }
    */
    var balance:Double {
        get {
            return UserDefaults.standard.double(forKey: UserSession.kWalletBalance)
        }set{
            UserDefaults.standard.set(newValue, forKey: UserSession.kWalletBalance)
        }
    }
    var totalSpendCurrentMonth:Double {
        get {
            return UserDefaults.standard.double(forKey: UserSession.kTotalSpendCurrentMonth)
        }set{
            UserDefaults.standard.set(newValue, forKey: UserSession.kTotalSpendCurrentMonth)
        }
    }
    var totalSpend:Double {
        get {
            return UserDefaults.standard.double(forKey: UserSession.kTotalSpend)
        }set{
            UserDefaults.standard.set(newValue, forKey: UserSession.kTotalSpend)
        }
    }
    var totalCashback:Double {
        get {
            return UserDefaults.standard.double(forKey: UserSession.kTotalCashback)
        }set{
            UserDefaults.standard.set(newValue, forKey: UserSession.kTotalCashback)
        }
    }
    var currency:String{
//        if objShareManager.appTarget == .PEKO_LIVE {
//            return "AED "
//        }else if objShareManager.appTarget == .PEKO_TEST {
//            return "AED "
//        }else{
//            return "₹ "
//        }
//
        if objShareManager.selectedCountry == .UAE {
            return "AED "
        }else if objShareManager.selectedCountry == .INDIA {
            return "₹ "
        }
        return ""
    }
    
    var userAccessibleServices:[String] = [String]()
    
    func logout(){
      
           HPProgressHUD.show()
           LoginViewModel().logout { reeponse, error in
               HPProgressHUD.hide()
             //  print(reeponse)
               self.user_id = 0
               self.sub_corporate_id = 0
               self.username = ""
               self.token = ""
               self.role = ""
               self.referralURL = ""
               self.is_login = false
              
               // HPM
               // objConnectManager?.dealloc()
             //  UserDefaults.standard.setValue("", forKey: Constants.kSavedUserName)
              // UserDefaults.standard.setValue("", forKey: Constants.kSavedPassword)
               UserDefaults.standard.synchronize()
               // HPM
//               objShareManager.pusher?.unsubscribe("real-time-notification")
               objShareManager.navigateToViewController = .LoginVC
               NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ChangeViewController"), object: nil)
           }
           
       }
}
