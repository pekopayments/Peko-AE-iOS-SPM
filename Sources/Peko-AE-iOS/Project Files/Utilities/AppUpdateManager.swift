
import Foundation
import UIKit

enum AppUpdateKeys: String {
    case KCurrentAppStoreVersion = "AppStoreVersion"
    case KISRquireForceUpdate    = "isEnterdForceUpdate"
    case KDisplayUpadteAlertDate = "DisplayUpadteAlertDate"
}

@objc class AppUpdateManager: NSObject {
    
    let bundleIdentifier = "com.app.peko.payment"
    
   // let KShowUpdatePopup = "ShowUpdatePopup"
    let KAPP_UPDATE_STATUS = "APP_UPDATE_STATUS"
    let KFORCE_UPDATE_VERSION = "FORCE_UPDATE_VERSION"

    
    @objc let shared = AppUpdateManager()
  //  @objc var viewController: UIViewController!
    var appStoreAPPVersion: String!
    var currentAppVersion: String!
    
    
    
    override init() {
        super.init()
        
    }

    @objc var forceUpdateVersion:String {
        get{
            UserDefaults.standard.string(forKey: KFORCE_UPDATE_VERSION) ?? "0.0"
        }set{
            UserDefaults.standard.set(newValue, forKey: KFORCE_UPDATE_VERSION)
            UserDefaults.standard.synchronize()
        }
    }
    @objc var updateStatus:Bool {
        get{
            UserDefaults.standard.bool(forKey: KAPP_UPDATE_STATUS)//  ?? false
        }set{
            UserDefaults.standard.set(newValue, forKey: KAPP_UPDATE_STATUS)
            UserDefaults.standard.synchronize()
        }
    }
    
    
    //MARK: APP_UPDATE Methods
    @objc func checkUpdate() {
  //      UserDefaults.standard.set(false, forKey: KShowUpdatePopup)
        // if AdmobManager.isConnectedToNetwork() {
        DispatchQueue.global().async {
            do {
                let update = try self.isUpdateAvailable()
                DispatchQueue.main.async {
                    if update {
                        self.checkForceAppUpadate()
                    }else{
                        print("NO Need to Update")
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    func isUpdateAvailable() throws -> Bool {
        guard let info = Bundle.main.infoDictionary,
              let currentVersion = info["CFBundleShortVersionString"] as? String,
        //      let identifier = info["CFBundleIdentifier"] as? String,
              let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(bundleIdentifier)") else {
            throw VersionError.invalidBundleInfo
        }
        let data = try Data(contentsOf: url)
        guard let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] else {
            throw VersionError.invalidResponse
        }
        if let result = (json["results"] as? [Any])?.first as? [String: Any], let appStoreVersion = result["version"] as? String{
            print("Store Version: \(appStoreVersion)")
            UserDefaults.standard.setValue(appStoreVersion, forKey: AppUpdateKeys.KCurrentAppStoreVersion.rawValue)
            print("Current Version: \(currentVersion)")
            appStoreAPPVersion = appStoreVersion //(appStoreVersion as NSString).doubleValue
            currentAppVersion =  currentVersion //(currentVersion as NSString).doubleValue
            
                if appStoreAPPVersion.compare(currentAppVersion, options: .numeric) == .orderedDescending {
                    print("store version is newer")
                    return true
                }else{
                    return false
                }
          
        }
        throw VersionError.invalidResponse
    }

    func checkForceAppUpadate() {
        
        let currentAppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String //"2.1"
        
        if self.updateStatus {
            let forceVersionFrom = "\(self.forceUpdateVersion)"
            
            if forceVersionFrom.compare(currentAppVersion, options: .numeric) == .orderedDescending ||  forceVersionFrom.compare(currentAppVersion, options: .numeric) == .orderedSame{
                print("Force User to Update version")
                UserDefaults.standard.set(true, forKey: AppUpdateKeys.KISRquireForceUpdate.rawValue)
                self.presentAppUpdateVC()
            }
            else {
                UserDefaults.standard.set(false, forKey: AppUpdateKeys.KISRquireForceUpdate.rawValue)
                self.showUpdateAlertOnceInAday()
            }
        }
        else {
            UserDefaults.standard.set(false, forKey: AppUpdateKeys.KISRquireForceUpdate.rawValue)
            print("Normal Update")
            self.showUpdateAlertOnceInAday()
        }
    }
    
    func showUpdateAlertOnceInAday(){
        if let lastAlertDate = UserDefaults.standard.object(forKey: AppUpdateKeys.KDisplayUpadteAlertDate.rawValue) as? Date {
            if Calendar.current.isDateInToday(lastAlertDate) {
                print("Alert was shown today!")
            } else {
                presentAppUpdateVC()
            }
        } else {
            presentAppUpdateVC()
        }
    }
    func presentAppUpdateVC() {
        // HPM
        /*
        if let vc = ForceUpdateViewController.storyboardInstance() {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            vc.modalPresentationStyle = .fullScreen
  
            let window = appDelegate.window //UIApplication.shared.keyWindow!
            if let modalVC = window!.rootViewController?.presentedViewController {
                modalVC.present(vc, animated: true, completion: nil)
            } else {
                window!.rootViewController!.present(vc, animated: true, completion: nil)
            }
        }
        */
//        let appUpdateVC = AppUpdateVC(nibName: "AppUpdateVC", bundle: .module)
//        appUpdateVC.modalPresentationStyle = .fullScreen
//        viewController.present(appUpdateVC, animated: true, completion: nil)
    }

}


enum VersionError: Error {
    case invalidResponse, invalidBundleInfo
}
