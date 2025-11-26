// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

@MainActor
public class PekoManager: NSObject {

    // public let sharedInstance = PekoManager()
   
    public override init() {
        super.init()
        
        objShareManager.appTarget = .PEKO_TEST
        objShareManager.selectedCountry = .UAE
       
        _ = Self.runOnce
    }
    
    static let runOnce: Void = {
        let bundle = Bundle.module
        
        let fontURLs = [
            bundle.url(forResource: "Roboto-Bold", withExtension: "ttf"),
            bundle.url(forResource: "Roboto-Italic", withExtension: "ttf"),
            bundle.url(forResource: "Roboto-Light", withExtension: "ttf"),
            bundle.url(forResource: "Roboto-Medium", withExtension: "ttf"),
            bundle.url(forResource: "Roboto-Regular", withExtension: "ttf"),
            bundle.url(forResource: "Inter-SemiBold", withExtension: "ttf")
            
        ].compactMap { $0 }
        
        for url in fontURLs {
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }()
    
    @MainActor
    public func userLogin(username:String, password:String, viewController:UIViewController) {
        
        HPProgressHUD.show()
        UserSession().token = ""
        UserSession().sessionId = ""
        UserSession().is_login = false
       
        LoginViewModel().userLogin(username: username, password: password) { response, error  in
            HPProgressHUD.hide()
            if error != nil {
                DispatchQueue.main.async {
                    viewController.showError(error: error)
                }
            }else if let status = response?.status?.value, status == true {
                DispatchQueue.main.async {
                     self.goToDashboard(data: (response?.data)!, viewController: viewController)
                }
            }else if let status = response?.success, status == true {
                DispatchQueue.main.async {
                    self.goToDashboard(data: (response?.data)!, viewController: viewController)
                }
            }else{
                var msg = ""
                if response?.message != nil {
                    msg = response?.message?.value ?? ""
                }else if response?.error?.value.count != nil {
                    msg = response?.error?.value ?? ""
                }
                viewController.showAlert(title: "", message: msg)
            }
        }
    }
    func goToDashboard(data:LoginDataModel, viewController:UIViewController){
        
        DispatchQueue.main.async {
//            UserSession().savedUsername = self.userNameTxt.text ?? "" //self.emailTxt.text!
//            UserSession().savedPassword = self.passwordTxt.text ?? ""
//            
         //   UserDefaults.standard.setValue(self.checkButton.isSelected, forKey: Constants.kRememberMe)
            // UserDefaults.standard.setValue(self.userNameTxt.text, forKey: Constants.kSavedUserName)
            // UserDefaults.standard.setValue(self.passwordTxt.text, forKey: Constants.kSavedPassword)
            UserDefaults.standard.synchronize()
            
            UserSession().user_id = data.id ?? 0
            UserSession().sub_corporate_id = data.subCorporateId ?? 0
            UserSession().username = data.username ?? ""
            UserSession().token = data.token ?? ""
            UserSession().role = data.role ?? ""
            UserSession().sessionId = data.sessionId ?? ""
            UserSession().refreshToken = data.refreshToken ?? ""
            
//            if UserSession().username == Constants.guest_username {
//                UserSession().is_login = false
//            }else{
                UserSession().is_login = true
         //   }
            
            if let objServiceVC = ServiceAccessViewController.storyboardInstance() {
                viewController.navigationController?.pushViewController(objServiceVC, animated: true)
            }
//            objPekoUtility.navigateToViewController = .ServiceAccess
//            self.navigationController?.popToRootViewController(animated: false)
        }
    }
}
