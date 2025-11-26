//
//  ProfileViewModel.swift
//  Peko
//
//  Created by Hardik Makwana on 09/04/23.
//

import UIKit
import Peko_AE_iOS_Utility

struct ProfileViewModel {

    
    func getProfileBasicDetails(response:  @escaping (ResponseModel<ProfileDetailModel>?, _ error: Error?) -> Void) {
        let url = ApiEnd().GET_PROFILE_BASIC_DETAILS
        
        WSManager.getRequest(url: url, resultType: ResponseModel<ProfileDetailModel>.self) { result, error  in
            response(result!, error)
        }
        
    }
    func getProfileAdvanceDetails(response:  @escaping (ResponseModel<ProfileAdvanceDetailModel>?, _ error: Error?) -> Void) {
        let url = ApiEnd().GET_PROFILE_ADVANCE_DETAILS
        
        WSManager.getRequest(url: url, resultType: ResponseModel<ProfileAdvanceDetailModel>.self) { result, error  in
            response(result!, error)
        }
    }
    func getCompanyDetails(response:  @escaping (ResponseModel<CompanyDetailModel>?, _ error: Error?) -> Void) {
        let url = ApiEnd().GET_COMPANY_DETAILS
        
        WSManager.getRequest(url: url, resultType: ResponseModel<CompanyDetailModel>.self) { result, error  in
            response(result!, error)
        }
    }
    
    // HPM
    /*
    func updateProfileDetails(otp:String, profileRequest:ProfileRequest, response: @escaping (CommonResponseModel) -> Void) {
        
        let url = ApiEnd().UPDATE_PROFILE_DETAILS
        
        var parameter :[String:Any] = [
            "contactPersonName": profileRequest.fullName ?? "",
            "city": profileRequest.city ?? "",
            "designation": profileRequest.designation ?? "",
            "tradeLicenseNo": profileRequest.tradeLicenseNo ?? "",
            "activity": profileRequest.activity ?? "",
            "companySize": profileRequest.companySize ?? "",
            "trnNo": profileRequest.trnNo ?? "",
            "landlineNo": profileRequest.landlineNo ?? "",
            "otp":otp,
            "scope":Constants.OTP_SCOPE,
        //    "tradeLicenseExpiry" : profileRequest.tradeLicenseExpiryDate?.formate(format: "yyyy-MM-dd") ?? "",
          //  "trnExpiry":profileRequest.trnExpiryDate?.formate(format: "yyyy-MM-dd") ?? ""
        ]
       
        if profileRequest.emiratesFileBaseString.count != 0 {
            parameter["eidDoc"] = profileRequest.emiratesFileBaseString
            parameter["eidDocFormat"] = profileRequest.emiratesFileType
        }
        if profileRequest.tradeLicenseFileBaseString.count != 0 {
            parameter["tradeLicenseDoc"] = profileRequest.tradeLicenseFileBaseString
            parameter["trdLcnFormat"] = profileRequest.tradeLicenseFileType
        }
        if profileRequest.trnCertificateFileBaseString.count != 0 {
            parameter["trnCertificate"] = profileRequest.trnCertificateFileBaseString
            parameter["trnCertFormat"] = profileRequest.trnCertificateFiletype
        }
        
        if profileRequest.profileBaseString.count != 0 {
            parameter["profileImageBase"] = profileRequest.profileBaseString
            parameter["profileImageFormat"] = "png"
        }else{
            parameter["profileImageBase"] = profileRequest.profilePicServerURL
        }
        
        if profileRequest.tradeLicenseExpiryDate != nil{
            parameter["tradeLicenseExpiry"] = profileRequest.tradeLicenseExpiryDate?.formate(format: "yyyy-MM-dd") ?? ""
        }
        if profileRequest.trnExpiryDate != nil{
            parameter["trnExpiry"] = profileRequest.trnExpiryDate?.formate(format: "yyyy-MM-dd") ?? ""
        }
        
      //  print(parameter.toJSON())
        WSManager.patchRequest(url: url, param: parameter, resultType: CommonResponseModel.self) { result, error  in
           // print(result)
            response(result!)
        }
    }
   // MARK: - Get Address
    func getAddreess(response: @escaping (ResponseModel<AddressResponseDataModel>?, _ error: Error?) -> Void) {
      
        let url = ApiEnd().GET_ADDRESS_LIST
        WSManager.getRequest(url: url, resultType: ResponseModel<AddressResponseDataModel>.self) { result, error  in
            response(result!, error)
        }
    }
   
    func sendOTP(request:AddressRequest, response: @escaping (CommonResponseModel, _ error: Error?) -> Void) {
      
        var url = ApiEnd().SEND_ADDRESS_OTP + "?scope=\(Constants.OTP_SCOPE)"
        
        if request.id != 0 {
            url = url + "&method=update&id=\(request.id)"
        }
        
        print(url)
        WSManager.getRequest(url: url, resultType: CommonResponseModel.self) { result, error  in
            response(result!, error)
        }
    }
    
    func addAddreess(request:AddressRequest, OTP:String, response: @escaping (ResponseModel<AddressModel>?, _ error: Error?) -> Void) {
       
         let url = ApiEnd().ADD_ADDRESS
        
        var parameter = [
            "addressType": request.addressType,
            "name": request.fullName,
            "addressLine1": request.addressLine1,
            "addressLine2": request.addressLine2,
            "phoneNumber": request.phoneNumber,
            "default": request.isDefault,
//            "otp":OTP,
//            "scope":Constants.OTP_SCOPE
        ] as [String : Any]
        
        if objShareManager.selectedCountry == .INDIA {
            parameter["city"] = request.city
            parameter["state"] = request.state
            parameter["zipCode"] = request.zipCode
        }
        
        print(parameter.toJSON())
        if request.id != 0 {
            parameter["id"] = request.id
            
            WSManager.putRequest(url: url, param: parameter, resultType: ResponseModel<AddressModel>.self) { result, error in
                response(result, error)
            }
        }else{
            WSManager.postRequest(url: url, param: parameter, resultType: ResponseModel<AddressModel>.self) { result, error in
                response(result, error)
            }
        }
     }
    func deleteAddreess(id:Int, response: @escaping (ResponseModel<AddressModel>?, _ error: Error?) -> Void) {
        let url = ApiEnd().ADD_ADDRESS + "/\(id)"
        
        WSManager.deleteRequest(url: url, param: [:], resultType: ResponseModel<AddressModel>.self) { result, error in
            response(result, error)
        }
       
    }
    
    // MARK: - BANK
    func getBankList(response: @escaping (ResponseModel<BankResponseDataModel>?, _ error: Error?) -> Void) {
      
        let url = ApiEnd().GET_BANKS_LIST
        WSManager.getRequest(url: url, resultType: ResponseModel<BankResponseDataModel>.self) { result, error  in
            response(result!, error)
        }
    }
    
    func addUpdateBank(request:AddBankRequest, otpString:String, response: @escaping (ResponseModel<BankModel>?, _ error: Error?) -> Void) {
       
         let url = ApiEnd().ADD_BANK
        
        var parameter = [
            
            "accountHolderName": request.accountHolderName,
            "accountNumber": request.accountNumber,
            "accountType": request.accountType,
            "bankName": request.bankName,
            "default": request.isDefault,
            "otp": otpString,
            "scope": Constants.OTP_SCOPE,
        ] as [String : Any]
       
        if objShareManager.selectedCountry == .UAE {
            parameter["iban"] = request.ibanNumber
            parameter["bankAddress"] = request.bankAddress
            parameter["swiftCode"] = request.swiftCode
        }else{
            parameter["bankBranch"] = request.branchName
            parameter["ifscCode"] = request.IFSCCode
        }
        
        print(parameter.toJSON())
        
        if request.id != 0 {
            parameter["id"] = request.id
            
            WSManager.putRequest(url: url, param: parameter, resultType: ResponseModel<BankModel>.self) { result, error in
                response(result, error)
            }
        }else{
            WSManager.postRequest(url: url, param: parameter, resultType: ResponseModel<BankModel>.self) { result, error in
                response(result, error)
            }
        }
     }
    
    func getBankAccountType(response: @escaping (ResponseModel<BankAccountTypeResponseModel>?, _ error: Error?) -> Void) {
      
        let url = ApiEnd().BANK_ACCOUNT_TYPE
      
        WSManager.getRequest(url: url, resultType: ResponseModel<BankAccountTypeResponseModel>.self) { result, error in
            response(result!, error)
        }
    }
    
    
    
    
    func deleteBank(id:Int, response: @escaping (ResponseModel<BankModel>?, _ error: Error?) -> Void) {
        let url = ApiEnd().ADD_BANK + "/\(id)"
        
        WSManager.deleteRequest(url: url, param: [:], resultType: ResponseModel<BankModel>.self) { result, error in
            response(result!, error)
        }
       
    }
    
    
    // MARK: -
    func updateMFASettings(param:[String:Any], response: @escaping (ResponseModel<CommonResponseModel>?, _ error: Error?) -> Void) {
        
        let url = ApiEnd().UPDATE_MFA_Setting
//        WSManager.getRequest(url: url, resultType: ResponseModel<CommonResponseModel>.self) { result, error  in
//            response(result!, error)
//        }
        print(param.toJSON())
        WSManager.putRequest(url: url, param: param, resultType: ResponseModel<CommonResponseModel>.self) { result, error  in
            response(result!, error)
        }
    }
    
    
    // MARK: - Get Progress
    func getProgress(response: @escaping (ResponseModel<ProfileProgressModel>?, _ error: Error?) -> Void) {
      
        let url = ApiEnd().GET_PROFILE_PROGRESS_DETAILS
        
        WSManager.getRequest(url: url, resultType: ResponseModel<ProfileProgressModel>.self) { result, error  in
            response(result, error)
        }
    }
    
    func sendReferralMail(emailID:String, response: @escaping (CommonResponseModel, _ error: Error?) -> Void) {
      
        let url = ApiEnd().REFER_MAIL_URL
        
        let param = [
            "email":"hardikmakwa@putsbox.com"
            ]
        WSManager.patchRequest(url: url, param: param, resultType: CommonResponseModel.self) { result, error  in
            response(result!, error)
        }
    }
    
    
    func getIndianStates(response: @escaping (ResponseModel<IndianStatesResponseModel>?, _ error: Error?) -> Void) {
      
        let url = ApiEnd().GET_INDIAN_STATES_URL
      
        WSManager.getRequest(url: url, resultType: ResponseModel<IndianStatesResponseModel>.self) { result, error in
            response(result!, error)
        }
    }
    */
}
