//
//  ProfileDetailModel.swift
//  Peko
//
//  Created by Hardik Makwana on 15/03/23.
//

import UIKit

public struct ProfileDetailModel: Codable, @unchecked Sendable {

    public var city:String?
    public var companyName:String?
    public var companySize:String?
    public var contactPersonName:String?
    public var countryCode:String?
    
    public var designation:String?
    public var email:String?
    public var mobileNo:String?
    public var landlineNo:String?
    
    public var activity:String?
   
    public var name:String?
    public var logo:String?
   
    public var package:PackageModel?
    public var credential:CredentialModel?
 
    public var subCorporateDetails:SubCorporateDetails?
   
    public var tradeLicenseNo:String?
    public var tradeLicenseExpiry:String?
    public var tradeLicenseDoc:String?
  
    public var trnCertificate:String?
    public var trnNo:String?
    public var trnExpiry:String?
    
    public var eidDoc:String?
    
    public var tradeLicenseExpiryDate:Date? {
        get {
            if tradeLicenseExpiry != nil {
           //     public let str = self.trnExpiry?.components(separatedBy: "T").first
                return self.tradeLicenseExpiry!.dateFromISO8601() ?? Date()
            }
            return nil
        }
    }
    
    public var trnExpiryDate:Date? {
        get {
            if trnExpiry != nil {
                 let str = self.trnExpiry?.components(separatedBy: "T").first
                return str?.convertToDate()//self.trnExpiry!.dateFromISO8601() ?? Date()
            }
            return nil
        }
    }
}


public struct ProfileAdvanceDetailModel: Codable, @unchecked Sendable {

    public let id:Int?
    public let email:String?
    public let mobileNo:String?
    public let landlineNo:String?
    
    public let name:String?
  
    public let firstName:String?
    public let lastName:String?
  
    public let designation:String?
    public let website:String?
   
    public let country:String?
    public let countryCode:String?
    public let city:String?
    public let sector:String?
    public let poBox:String?
    
    public let contactPersonName:String?
    public let companyName:String?
    public let companySize:String?
    
    public let contactPersonEmail:String?
    public let contactPersonPhone:String?
   
    public let tradeLicenseNo:String?
    public let tradeLicenseExpiry:String?
    public let tradeLicenseDoc:String?
  
    public let activity:String?
    
    public let trnCertificate:String?
    public let trnNo:String?
    public let trnExpiry:String?
    
    public let eidDoc:String?
    
    public let issuingAuthority:String?
  
    public let logo:String?
   
    public let kycRemarks:String?
    public let kycStatus:String?
    
    public let latLng:String?
    
    public let isActive:Int?
   
    public let isMFA:Int?
    public let sendMfaCodeToEmail:Int?
    public let sendMfaCodeToPhone:Int?
    public let sendMfaCodeToAuthApp:Int?
    
    public let totpSecret:String?
    public let registeredBy:String?
  
    public let createdAt:String?
    public let updatedAt:String?
    
    
    public let package:PackageModel?
    public let credential:CredentialModel?
 
    public let subCorporateDetails:SubCorporateDetails?
   
    
    public let credentialId:Int?
    public let packageId:Int?
   
    public let role:String?
    
    public var tradeLicenseExpiryDate:Date? {
        get {
            if tradeLicenseExpiry != nil {
           //     public let str = self.trnExpiry?.components(separatedBy: "T").first
                return self.tradeLicenseExpiry!.dateFromISO8601() ?? Date()
            }
            return nil
        }
    }
    
    public var trnExpiryDate:Date? {
        get {
            if trnExpiry != nil {
                let str = self.trnExpiry?.components(separatedBy: "T").first
                return str?.convertToDate()//self.trnExpiry!.dateFromISO8601() ?? Date()
            }
            return nil
        }
    }
}

// MARK: -
public class CompanyDetailModel: Codable, @unchecked Sendable {
    
    public let activity:String?
    public let trnExpiry:String?
    public let trnNo:String?
    public let tradeLicenseExpiry:String?
    public let tradeLicenseNo:String?
 
    public let tradeLicenseDoc:String?
    public let trnCertificate:String?
    public let eidDoc:String?
 
    
}

// MARK: -
public class CredentialModel: Codable, @unchecked Sendable {
    
    public let id:Int?
  
    public let role:String?
    public let name:String?
    public let email:String?
    public let password:String?
    public let passwordResetToken:String?
    public let passwordResetExpires:String?
    
    public let lastLogin:String?
    public let createdAt:String?
    public let updatedAt:String?
   
   
}

// MARK: -
struct ProfileUpdateResponseModel: Codable, @unchecked Sendable {
    
    public let result:[CustomString]?
   // public let docs:[String:String]?
    
    
}


public class ProfileWalletModel: Codable, @unchecked Sendable {
    
    public let balance:CustomDouble?
    public let credentialId:CustomInt?
 
    
    public let roleName:String?
    public let role:String?
    
    public let logo:String?
   
    public let contactPersonName:String?
   
    public let email:String?
    public let mobileNo:String?
    
    public let lastLogin:String?
    public let createdAt:String?
    public let updatedAt:String?
   
    public let chatId:String?
    public let companyName:String?
    public let username:String?
    
    public let isPekoCreditAvailable:Bool?
    public let isPekoCreditActive:Bool?
    public let pekoCredits:CustomDouble?
 
}


public class ProfileProgressModel: Codable, @unchecked Sendable {
    
    public let addressDetailsProgress:CustomDouble?
    public let bankDetailsProgress:CustomInt?
    public let basicInfoProgress:CustomDouble?
    public let companyInfoProgress:CustomInt?
 
    
    public let progress:String?
    public let strength:String?
   
    public let tips:[String]?
   
    public let referralLink:String?
 
}

// HPM
/*
public class IndianStatesResponseModel: Codable, @unchecked Sendable {
    public let states:[BillPaymentStatesModel]?
}

public class BankAccountTypeResponseModel: Codable, @unchecked Sendable {
    public let accountType:[BillPaymentStatesModel]?
}
*/

public class SubCorporateDetails:Codable, @unchecked Sendable {
    
    public let name:String?
    public let email:String?
    public let mobileNo:String?
    public let role:String?
   
    public let credential:CredentialModel?
   
}
