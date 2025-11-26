//
//  MainViewController.swift
//  Peko
//
//  Created by Hardik Makwana on 04/01/23.
//

import UIKit
import MessageUI
//import Reachability

//class MainViewController: UIViewController {
public extension UIViewController {
//
    //    var connectionLostAlert: ConnectionLostAlertUIView!
  // HPM
    
    // var documentController: UIDocumentInteractionController?
    
//    public var backNavigationView : BackNavigationView {
//        let view = BackNavigationView()
//        view.xibSetup()
//        //   self.headerView?.translatesAutoresizingMaskIntoConstraints = false
//        return view
//     
//        
//    }
    
//    public var isBackNavigationBarView: Bool {
//        set {
//            self.setupBackNavigationBarView(isBackButton: newValue)
//        }
//        get { return self.isBackNavigationBarView }
//    }
   
    // MARK: - Set Title
    public func setTitle(title:String) {
//        if self.backNavigationView != nil {
//            self.backNavigationView.titleLabel.text = title.localizeString()
//        }
        self.setupBackNavigationBarView(title:title)
    }
//    public func getTitle() -> String {
//        if self.backNavigationView != nil {
//            return (self.backNavigationView.titleLabel.text)!
//        }
//        return ""
//    }
   
    // MARK: - Setup Back Navigation bar
    public func setupBackNavigationBarView(title:String)  {
        let backNavigationView = BackNavigationView()
        backNavigationView.xibSetup()
        //   self.headerView?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(backNavigationView)
//        
        backNavigationView.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = self.view.layoutMarginsGuide
        
        backNavigationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        backNavigationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        backNavigationView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        backNavigationView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        
        //  self.backNavigationView?.backButton.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
        
      //  if isBackButton {
            backNavigationView.backButton.isHidden = false
            backNavigationView.backButton.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
//        }else{
//            backNavigationView.backButton.isHidden = true
//        }
        backNavigationView.titleLabel.text = title.localizeString()
        // UIApplication.shared.statusBarFrame.height
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let view1 = UIView()
        if statusBarHeight > 0 {
            //UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: statusBarHeight))
            view1.backgroundColor = .white
            self.view.addSubview(view1)
            view1.translatesAutoresizingMaskIntoConstraints = false
            
            view1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            view1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            
            view1.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            
            // view1.heightAnchor.constraint(equalToConstant: statusBarHeight).isActive = true
            
            view1.bottomAnchor.constraint(equalTo: backNavigationView.topAnchor).isActive = true
            
        }
        
        backNavigationView.containerView?.backgroundColor = .white
        view1.backgroundColor = .white
        backNavigationView.titleLabel.textColor = .black
        
        
        backNavigationView.trolleyButton.addTarget(self, action: #selector(trolleyButtonClick), for: .touchUpInside)
        
        
        //   self.backNavigationView?.notificationButton.addTarget(self, action: #selector(notificationButtonClick), for: .touchUpInside)
        
    }
    
    // MARK: - Back Button Click
    //    @objc func backButtonClick() {
    //        if self.isPopToRoot{
    //            self.navigationController?.popToRootViewController(animated: false)
    //        }else{
    //            self.navigationController?.popViewController(animated: true)
    //        }
    //
    //    }
    
    // MARK: -  PEKO STORE TROLLEY
    @objc func trolleyButtonClick(){
        // HPM
//        if let trolleyVC = PekoStoreTrolleyViewController.storyboardInstance() {
//            self.navigationController?.pushViewController(trolleyVC, animated: true)
//        }
    }
    
    
    func supportMail() {
        if MFMailComposeViewController.canSendMail() {
            
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self
            mailComposerVC.navigationBar.tintColor = UIColor.white
            
            mailComposerVC.setToRecipients([Constants.support_email])
            mailComposerVC.setSubject("\(NSLocalizedString("Feedback for App", comment: ""))")
            
            let appVersion = "App Version : \(Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String ?? "")"
            let osVersion = "OS Version : \(UIDevice.current.systemVersion)"
            let deviceModel = "Device Model : \(UIDevice.modelName)"
            
            let body = "\n\n\n\n\n\n\(appVersion)\n\(osVersion)\n\(deviceModel)"
            
            mailComposerVC.setMessageBody(body, isHTML: false)
            
            mailComposerVC.navigationBar.barTintColor = UIColor.white
            mailComposerVC.navigationBar.backgroundColor = UIColor.white
            
            mailComposerVC.navigationBar.tintColor = UIColor.black
            mailComposerVC.navigationBar.setBackgroundImage(UIImage(), for: .default)
            
            self.present(mailComposerVC, animated: true, completion: { () in
                //  UIApplication.sharedApplicationtatusBarStyle = UIStatusBarStyle.LightContent
                
            })
            // self.present(mailComposerVC, animated: true, completion: nil)
            
        }else{
            self.showAlert(title: "", message: "Please configure Apple Mail on this device")
        }
    }
//    open override func viewDidLoad() {
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
//    }
   
}

// MARK: MFMailComposeViewControllerDelegate Method
extension UIViewController:@MainActor MFMailComposeViewControllerDelegate {
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
extension UIViewController:UIGestureRecognizerDelegate{
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let navVc = navigationController {
            return navVc.viewControllers.count > 1
        }
        return false
    }
}

// MARK: -
// MARK: - Download File & Preview
extension UIViewController:UIDocumentInteractionControllerDelegate {
   
    func saveFileIntoDocument(type:String, with byte: [UInt8], defaultFileName:String = "Transaction") {
        let data = Data(byte)
        var file_extension = type
        
        if type == "excel" {
            file_extension = "xlsx"
        }
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = documentsPath + "/" + defaultFileName + "." + file_extension
        // xlsx
        
        let url = URL(fileURLWithPath: filePath)
        do{
            try data.write(to: url, options: .atomic)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.previewFile(fileURL: url)
            }
            
        }catch let failedError {
           // HPProgressHUD.hide()
            print("Failed to write the pdf data due to \(failedError.localizedDescription)")
            self.showAlert(title: "", message: "Failed to write the file data due to \(failedError.localizedDescription)")
        }
    }
    
    func previewFile(fileURL:URL){
        HPProgressHUD.hide()
        var documentController: UIDocumentInteractionController?
        
        documentController = UIDocumentInteractionController(url: fileURL)
        documentController?.delegate = self
        documentController?.presentPreview(animated: true)
        
    }
    public func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        
        return self
    }
}
