//
//  WebViewController.swift
//  Peko
//
//  Created by Hardik Makwana on 15/03/24.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var pdfURL:URL?
    var mimeType = "application/pdf"
    
    static func storyboardInstance() -> WebViewController? {
        return AppStoryboards.Common.instantiateViewController(identifier: "WebViewController") as? WebViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

      //  self.isBackNavigationBarView = true
        self.setTitle(title: pdfURL?.lastPathComponent ?? "")
        self.view.backgroundColor = .white
    
        // HPM
//        self.backNavigationView?.orderHistoryView.isHidden = false
//        self.backNavigationView?.historyButton.setImage(UIImage(named: "icon_share"), for: .normal)
//      
//        self.backNavigationView?.historyButton.addTarget(self, action: #selector(shareButtonClick), for: .touchUpInside)
//    
        
        let data = try! Data(contentsOf: pdfURL!)
        self.webView.load(data, mimeType: mimeType, characterEncodingName:"", baseURL: pdfURL!.deletingLastPathComponent())
        
        
    }
    // MARK: - Share
    @objc func shareButtonClick(){
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = documentsPath + "/" + (pdfURL?.lastPathComponent ?? "")
        
        if FileManager.default.fileExists(atPath: filePath) {
           
            let fileURL = NSURL(fileURLWithPath: filePath)
                    
            // Create the Array which includes the files you want to share
            var filesToShare = [Any]()
                    
            // Add the path of the file to the Array
            filesToShare.append(fileURL)
                    
            // Make the activityViewContoller which shows the share-view
            let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)

            // Be notified of the result when the share sheet is dismissed
            activityViewController.completionWithItemsHandler = { activityType, completed, returnedItems, activityError in
                
            }

            // Show the share-view
            self.present(activityViewController, animated: true, completion: nil)
            
//            let documento = NSData(contentsOfFile: filePath)
//            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [documento!], applicationActivities: nil)
//            activityViewController.popoverPresentationController?.sourceView=self.view
//            present(activityViewController, animated: true, completion: nil)
        }
        else {
            print("document was not found")
            let data = try! Data(contentsOf: pdfURL!)
            
            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [data], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView=self.view
            present(activityViewController, animated: true, completion: nil)
        }
    }


}
