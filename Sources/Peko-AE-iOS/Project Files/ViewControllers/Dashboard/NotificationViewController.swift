//
//  NotificationViewController.swift
//  Peko
//
//  Created by Hardik Makwana on 07/01/23.
//

import UIKit


class NotificationViewController: UIViewController {

    
    @IBOutlet weak var notificationTableView: UITableView!
    @IBOutlet weak var noDataView: UIView!
    
    @IBOutlet weak var searchTxt: PekoTextField!
    @IBOutlet weak var noSearchView: UIView!
  
    var isSkeletonView:Bool = true
    
    var notificationArray = [NotificationModel]()
    var searchNotificationArray = [NotificationModel]()
   
    var page = 1
    var isPageRefreshing:Bool = false
   
    var fromDate = Date().addMonths(months: -1)
    var toDate = Date()
    
    static func storyboardInstance() -> NotificationViewController? {
        return AppStoryboards.Notification.instantiateViewController(identifier: "NotificationViewController") as? NotificationViewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
//        self.isBackNavigationBarView = true
//        self.setTitle(title: "Notifications")
//        
      //  self.isBackNavigationBarView = false
        
     //   self.setTitle(title: "Notifications")
   
        self.noDataView.isHidden = true
        self.notificationTableView.delegate = self
        self.notificationTableView.dataSource = self
        self.notificationTableView.register(UINib(nibName: "NotificationTableViewCell", bundle: .module), forCellReuseIdentifier: "NotificationTableViewCell")
        self.notificationTableView.backgroundColor = .clear
        self.notificationTableView.separatorStyle = .none
        self.notificationTableView.isUserInteractionEnabled = false
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 20))
        self.notificationTableView.tableFooterView = footerView
        
        self.tabBarItem.badgeValue = nil
        
        self.searchTxt.addTarget(self, action: #selector(textFieldDidChangeSelection), for: .editingChanged)
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        page = 1
        self.getNotifications()
      
        let dic = ["notification_count":""]
        UIApplication.shared.applicationIconBadgeNumber = 0
        NotificationCenter.default.post(name: Notification.Name("UPDATE_NOTIFICATION_COUNT"), object: nil, userInfo: dic)
    }
    
    // MARK: -
      @objc func textFieldDidChangeSelection() {
          let searchText = self.searchTxt.text!.lowercased()
          
          if searchText.count == 0 {
              self.searchNotificationArray = self.notificationArray
          }else{
              let array:[NotificationModel] = (self.notificationArray.filter { ($0.notificationBrief ?? "").lowercased().contains(searchText) || ($0.notificationTitle ?? "").lowercased().contains(searchText) })
              
              self.searchNotificationArray = array
              
              if array.count == 0 {
               //   self.searchProductsArray = productsArray
                  self.noSearchView.isHidden = false
              }else{
               //   self.searchProductsArray = array1
                  self.noSearchView.isHidden = true
              }
          }
          
          self.notificationTableView.reloadData()
      }
    
    // MARK: - Notifications
    func getNotifications(){
        
        NotificationViewModel().getAllNotifications(fromDate: self.fromDate!, toDate: self.toDate, page: self.page) { response, error in
            if error != nil {
                self.showError(error: error)
            }else if let status = response?.status?.value, status == "true" {
                DispatchQueue.main.async {
                    
                    if self.page == 1 {
                        self.notificationArray.removeAll()
                    }
                    
                    let array = response?.data?.data ?? [NotificationModel]()
                    
                    self.notificationArray.append(contentsOf: array)
                    self.searchNotificationArray = self.notificationArray
                    
                    self.notificationTableView.isUserInteractionEnabled = true
                    self.isSkeletonView = false
                    self.notificationTableView.reloadData()
                    
                    if self.notificationArray.count == 0 {
                        self.noDataView.isHidden = false
                    }else{
                        self.noDataView.isHidden = true
                    }
                    
                    if self.notificationArray.count < response?.data?.recordsTotal ?? 0 {
                        self.isPageRefreshing = false
                    }else{
                        self.isPageRefreshing = true
                    }
                    
                    self.readAllNotification()
                }
            }else{
                if let code = response?.responseCode, code == "002"{
                    ErrorManager().manageSession(viewController: self) { result in
                        if result {
                            self.getNotifications()
                        }
                    }
                }else{
                    var msg = ""
                    if response?.message != nil {
                        msg = response?.message ?? ""
                    }else if response?.error?.count != nil {
                        msg = response?.error ?? ""
                    }
                    self.showAlert(title: "", message: msg)
                }
            }
        }
    }
    func readAllNotification(){
        NotificationViewModel().resetNotificationCount() { response, error in
            if error != nil {
                self.showError(error: error)
            }else if let status = response?.status?.value, status == true {
                DispatchQueue.main.async {
                    
                    
                }
            }
        }
    }
    
    // MARK: - Sort
    
    @IBAction func sortButtonClick(_ sender: Any) {
        if let dateVC = SelectDateRangeViewController.storyboardInstance(){
            
            dateVC.preSelectedStartDate = self.fromDate
            dateVC.preSelectedEndDate = self.toDate
            //
            dateVC.completionBlock = { date1, date2 in
                self.fromDate = date1
                self.toDate = date2
                self.page = 1
                self.getNotifications()
                //
                //                self.hotelCheckInDateView.text = date1.formate(format: "dd MMMM, yyyy")
                //                self.hotelCheckOutDateView.text = date2.formate(format: "dd MMMM, yyyy")
            }
            dateVC.modalPresentationStyle = .fullScreen
            self.present(dateVC, animated: true)
        }
        
    }
}
extension NotificationViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isSkeletonView {
            return 10
        }
        return self.searchNotificationArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell") as! NotificationTableViewCell
        cell.selectionStyle = .none
        
        if self.isSkeletonView {
            cell.view_1.showAnimatedGradientSkeleton()
        }else{
            cell.hideSkeleton()
            
            let notificationModel = self.searchNotificationArray[indexPath.row]
            
            cell.titleLabel.attributedText = NSMutableAttributedString().color(.black, (notificationModel.notificationTitle ?? "").trimmingCharacters(in: .whitespaces), font: .medium(size: 13), 4).color(.black, ("\n" + (notificationModel.notificationBrief ?? "").trimmingCharacters(in: .whitespaces)), font: .regular(size: 12), 4)
            
            let date = notificationModel.createdAt?.dateFromISO8601()
            let str = date!.mediumDate + " at " + (date?.formate(format: "hh:mm a") ?? "")
            cell.dateLabel.text = str
            
            if notificationModel.flag ?? false {
                cell.backgroundColor = .white
            }else{
                cell.backgroundColor = UIColor(red: 255/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1.0)
            }
            
            // notificationModel.createdAt?.dateFromISO8601()?.formate(format: "EEEE, dd MMM, yyyy at hh:mm a")
            
            
            
            
           // if notificationModel.flag ?? false {
//
//            }else{
//                
//            }
        }
        return cell
    }
}
// MARK: -
extension NotificationViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.notificationTableView.contentOffset.y >= (self.notificationTableView.contentSize.height - self.notificationTableView.bounds.size.height)) {
            if !isPageRefreshing {
                isPageRefreshing = true
                self.page += 1
                self.getNotifications()
            }
        }
    }
}
