//
//  HomeViewController.swift
//  Peko
//
//  Created by Hardik Makwana on 04/01/23.
//

import UIKit
//import AzureCommunicationChat
//import AzureCommunicationCommon
//import AzureCommunicationCalling
//import PusherSwift
import SkeletonView
import SDWebImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    //    @IBOutlet weak var companyNameLabel: UILabel!
    //    @IBOutlet weak var userNameLabel: UILabel!
    //    @IBOutlet weak var cashbackLabel: UILabel!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var dummyView: DashboardDummyView!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var notificationBadgeLabel: PekoLabel!
    
    var bannerCollectionView: UICollectionView?
    var bannerPageControl: UIPageControl?
    var bannerTimer:Timer?
    var bannerCurrentIndex = 0
    
    var dashboardModel:DashboardModel?
    var alertPageControl: UIPageControl?
    var alertArray = [[AlertDataModel]]()
   
    var isShowSkeletonView = true
    var offerBannerArray = ["banner_tax_registration", "banner_peko_expense_card", "banne_buy_esim", "baner_carbon_footprint"]
    
    // HPM
    // var incomingView:ConnectChatVoiceCallViewController?
    
    static func storyboardInstance() -> HomeViewController? {
        return AppStoryboards.Home.instantiateViewController(identifier: "HomeViewController") as? HomeViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            
            //  self.homeCollectionView.isHidden = true
            self.homeCollectionView.isUserInteractionEnabled = false
            self.homeCollectionView.delegate = self
            self.homeCollectionView.dataSource = self
            
            self.homeCollectionView.register(UINib(nibName: "DashboardServiceCollectionViewCell", bundle: .module), forCellWithReuseIdentifier: "DashboardServiceCollectionViewCell")
            self.homeCollectionView.register(UINib(nibName: "UpcomingPaymentsCollectionViewCell", bundle: .module), forCellWithReuseIdentifier: "UpcomingPaymentsCollectionViewCell")
            self.homeCollectionView.register(UINib(nibName: "ApplyForCardCollectionViewCell", bundle: .module), forCellWithReuseIdentifier: "ApplyForCardCollectionViewCell")
            self.homeCollectionView.register(UINib(nibName: "PaymentCollectionViewCell", bundle: .module), forCellWithReuseIdentifier: "PaymentCollectionViewCell")
            self.homeCollectionView.reloadData()
            
            self.notificationBadgeLabel.layer.cornerRadius = 9
            self.notificationBadgeLabel.layer.masksToBounds = true
            
            self.notificationBadgeLabel.isHidden = true
            
            // PEKO CONNECT
           // self.getTokenForConnectChat()
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.getNotifications), name: Notification.Name("GET_NOTIFICATION_COUNT"), object: nil)
            
            self.userNameLabel.text = ""
            
            // HPM
           // self.addPusherEventForNotification()
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        //   self.getProfileDetails()
        self.homeCollectionView.isHidden = false
        
        DispatchQueue.main.async {
            self.getDashboardData()
        }
        // HPM
        /*
        objLicenseRenewalManager = nil
        objGiftCardManager = nil
        objAirTicketManager = nil
        objOfficeAddressManager = nil
        objInvoiceGeneratorManager = nil
        objBusinessEmailsManager = nil
        objHotelBookingManager = nil
        */
        if self.bannerTimer != nil {
            self.bannersStartTimer()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        //  self.homeCollectionView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        if self.bannerTimer != nil {
            self.bannersStopTimer()
        }
    }
    // MARK: - Get Dahboard
    func getDashboardData(){
        DashboardViewModel().getDashboardDetails() { response, error in

            if error != nil {
                self.showError(error: error)
            }else if let status = response?.status?.value, status == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let data = response?.data
                    
                    self.dashboardModel = data
                    UserSession().balance = data?.balance?.value ?? 0.0
                    UserSession().totalCashback = data?.totalCashback?.value ?? 0.0
                    UserSession().totalSpend = data?.totalSpend?.value ?? 0.0
                    UserSession().totalSpendCurrentMonth = data?.totalSpendCurrentMonth?.value ?? 0.0
                    
                    self.alertArray = data?.alerts?.chunked(into: 2) ?? [[AlertDataModel]]()
                    
                    print(self.alertArray)
                    self.homeCollectionView.isUserInteractionEnabled = true
                    self.isShowSkeletonView = false
                    self.homeCollectionView.reloadData()
                    
                    if self.dummyView != nil {
                        self.dummyView.removeFromSuperview()
                    }
                }
            }else{
               
                let error = ErrorModel(code: response?.responseCode, message: response?.message?.value, error: response?.error?.value, errors: response?.errors?.value)
              
                ErrorManager().manageFailResponse(error: error, viewController: self) { isReload in
                    if isReload {
                        self.getDashboardData()
                        self.getNotifications()
                    }
                }
            }
        }
        
        DashboardViewModel().getProfileWalletDetails { response, error in
            if error != nil {
                self.showError(error: error)
            }else if let status = response?.status?.value, status == true {
                DispatchQueue.main.async {
                    UserSession().walletDetailsModel = response?.data!
                    self.homeCollectionView.reloadData()
                }
            }else{
               
            }
        }
      
        ProfileViewModel().getProfileBasicDetails() { response, error in
            HPProgressHUD.hide()
            if error != nil {
                self.showError(error: error)
            }else if let status = response?.status?.value, status == true {
                DispatchQueue.main.async {
                    let data = response?.data
                    UserSession().profileBasicDetail = data
                    
                    if data?.subCorporateDetails == nil {
                        self.userNameLabel.text = "Hey " +  (data?.contactPersonName ?? "").trimmingCharacters(in: .whitespaces)
                    }else{
                        self.userNameLabel.text = "Hey " +  (data?.subCorporateDetails?.name ?? "").trimmingCharacters(in: .whitespaces)
                    }
                }
            }else{
            }
        }
        self.getNotifications()
      //  self.getServiceAccess()
    }
    // MARK: - Notifications
    @objc func getNotifications(){
        
        NotificationViewModel().getNotificationsCount() { response, error in
            if error != nil {
                if objShareManager.appTarget == .PEKO_LIVE {
                    self.showAlert(title: "", message: "Something went wrong please try again")
                }else {
                    self.showAlert(title: "", message: error?.localizedDescription ?? "")
                }
            }else if let status = response?.status?.value, status == true {
                DispatchQueue.main.async {
                    if response?.data?.count == 0 {
                        self.notificationBadgeLabel.isHidden = true
                    }else{
                       // self.notificationButton.b
                        self.notificationBadgeLabel.isHidden = true
                     
                        
                        let count = response?.data?.count ?? 0
                        var countString = ""
                        if count > 9 {
                            countString = "9+"
                        }else{
                            countString = "\(count)"
                        }
                        UIApplication.shared.applicationIconBadgeNumber = count
                        let dic = ["notification_count":countString]
                       
                        NotificationCenter.default.post(name: Notification.Name("UPDATE_NOTIFICATION_COUNT"), object: nil, userInfo: dic)
                        
                    }
                    
                }
            }
        }
    }
    
  
    // MARK: - Search Button CLick
    @IBAction func searchButtonClick(_ sender: UIButton) {
        if let serachVC = MoreServiceViewController.storyboardInstance() {
            self.navigationController?.pushViewController(serachVC, animated:true)
        }
    }
    
    // MARK: -
    @IBAction func notificationButtonClick(_ sender: Any) {
       // HPM
        /*
        if let vc = PaymentTransactionViewController.storyboardInstance() {
            vc.paymentPayNow =  .PekoStore//"Gift Crads"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        */
    }
    
    /*
    // MARK: - Login Required
    func loginRequired() {
        let actionSheet = UIAlertController(title: "", message: "Login Required", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Login", style: .default, handler: { action in
            objShareManager.navigateToViewController = .LoginVC
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ChangeViewController"), object: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            
        }))
        self.present(actionSheet, animated:true)
    }
    */
}

// MARK: - UICollectionView
extension HomeViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if objServiceAccessManager.isHasAccessDashboard {
            if collectionView == self.homeCollectionView {
                return 7
            }
        }
        if UserSession().sub_corporate_id != 0 {
            return 2
        }
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == self.homeCollectionView {
            return CGSize(width: screenWidth, height: 10)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.homeCollectionView {
            if section == 0 { // Payment Services
                if objServiceAccessManager.isHasAccessDashboard {
                    if objServiceAccessManager.serviceListArray.count > 7 {
                        return 8 // Constants.paymentServicesArray.count
                    }else{
                        return objServiceAccessManager.serviceListArray.count
                    }
                }
                return objServiceAccessManager.serviceListArray.count
            }else if section == 1 { // BANNERS
                return 1 // Baners
            }else if section == 2 { // Peko Credits
                return 1
            }else if section == 3 { // Alerts
                if self.isShowSkeletonView {
                    return 1
                }
                if self.dashboardModel?.alerts?.count != 0 {
                    return 1
                }
            }else if section == 4 { //  Offers
                return 1
            }else if section == 5 { //  Reward
                return 1
            }else if section == 6 { // PEKO Made with
                return 1
            }
        } else if collectionView.tag == 100 {
            return self.dashboardModel?.allBanners?.count ?? 0
        }else if collectionView.tag == 200 {
            return self.offerBannerArray.count
        }else if collectionView.tag == 300 {
            return self.alertArray.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.homeCollectionView {
            
           if indexPath.section == 0 { // Service Options
                let width = (screenWidth - 106) / 4
                let height = width * 0.90
                return CGSize(width: width, height: height + 30)
           }else if indexPath.section == 1 { // Banners
               
               if UserSession().sub_corporate_id == 0 {
                   let height = screenWidth * 0.33
                   return CGSize(width: screenWidth - 36, height: height + 24)
               }else{
                   let height = screenWidth * 0.58
                   return CGSize(width: screenWidth, height: height)
               }
               
           } else if indexPath.section == 2 { // Peko Credits
               let width = screenWidth - 36
               let height = width * 0.276
               return CGSize(width: width, height: height)
          
           }else if indexPath.section == 3 { // Alerts
                if self.isShowSkeletonView {
                    return CGSize(width: screenWidth - 36, height: 60)
                }else{  if self.dashboardModel?.alerts?.count == 1 {
                            return CGSize(width: screenWidth - 36, height: 67 + 75)
                        }
                        return CGSize(width: screenWidth - 36, height: (67 * 2) + 75)
                }
            }else if indexPath.section == 4 { // Offers
                let height = 0.41 * screenWidth
                return CGSize(width: screenWidth, height: height)
           
            }else if indexPath.section == 5 { // rewards
                let width = screenWidth - 36
                let height = 0.31 * screenWidth
                return CGSize(width: width, height: height)
           
            }else if indexPath.section == 6 { // Peko
                let height = screenWidth * 0.58
                return CGSize(width: screenWidth, height: height)
            }
        }else if collectionView.tag == 100 {
          //  return CGSize(width: screenWidth - 36, height: screenWidth * 0.30)
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        }else if collectionView.tag == 200 {
            let height = 0.41 * screenWidth
            let width = height * 1.0312
            return CGSize(width: width, height: height)
            
        }else if collectionView.tag == 300 {
            return collectionView.bounds.size //CGSize(width: screenWidth - 36, height: 67)
        }
        
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.homeCollectionView {
           
            if indexPath.section == 0 { // Payment SERVICE OPTION
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardServiceCollectionViewCell", for: indexPath) as! DashboardServiceCollectionViewCell
                cell.backgroundColor = .clear
                cell.imgContainerView.backgroundColor = UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1.0)
                if self.isShowSkeletonView {
                    cell.showAnimatedGradientSkeleton()
                }else{
                    cell.hideSkeleton()
                    
                    if UserSession().sub_corporate_id == 0 && indexPath.row == 7 {
                        cell.titleLabel.text = "All Services"
                        cell.logoImgView.image = UIImage(named: "icon_more_services", in: .module, with: nil)
                        
                    }else{
                        let model = objServiceAccessManager.serviceListArray[indexPath.row] // searchAllServiceArray[indexPath.row]
                        
                        if let dic = objServiceAccessManager.allPaymentServicesDictionary[model.label ?? ""] {
                            cell.titleLabel.font = UIFont.regular(size: 10)
                            cell.titleLabel.text = dic.title
                            cell.logoImgView.image = UIImage(named: dic.icon, in: .module, with: nil)
                        }
                    }
                }
                return cell
            }else if indexPath.section == 1 { // Banners
               
                if UserSession().sub_corporate_id == 0 {
                    
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardBannerCollectionViewCell", for: indexPath) as! DashboardBannerCollectionViewCell
                    cell.backgroundColor = .clear
                    
                    if self.isShowSkeletonView {
                        cell.view_1.isSkeletonable = true
                        cell.view_1.showAnimatedGradientSkeleton()
                    }else{
                        cell.view_1.hideSkeleton()
                        
                        cell.bannerCollectionView.delegate = self
                        cell.bannerCollectionView.dataSource = self
                        cell.bannerCollectionView.backgroundColor = .clear
                        cell.bannerCollectionView.tag = 100
                        cell.pageControl.numberOfPages = self.dashboardModel?.allBanners?.count ?? 0
                        
                        self.bannerPageControl = cell.pageControl
                        self.bannerCollectionView = cell.bannerCollectionView
                        
                        if self.bannerTimer == nil {
                            self.bannersStartTimer()
                        }
                    }
                    
                    return cell
                }else{
                    let footerCell = self.getFooterCollectionViewCell(indexPath: indexPath, collectionView: collectionView)
                    return footerCell
                }
               
            }else if indexPath.section == 2 { // Peko Credits
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardPekoCreditCollectionViewCell", for: indexPath) as! DashboardPekoCreditCollectionViewCell
                cell.backgroundColor = .clear
                cell.clipsToBounds = false
                
                
                if (UserSession().walletDetailsModel?.isPekoCreditActive ?? false) && (UserSession().walletDetailsModel?.isPekoCreditAvailable ?? false) {
                    let credit = objUserSession.currency + ((UserSession().walletDetailsModel?.pekoCredits?.value ?? 0.0).withCommas())
                    cell.titleLabel.attributedText = NSMutableAttributedString().color(.black, "Your Peko Credits: ", font: .medium(size: 14))
                        .color(.redButtonColor, credit, font: .medium(size: 14))
                    cell.buttonTitleLabel.text = "View Now"
                }else{
                    cell.titleLabel.attributedText = NSMutableAttributedString().color(.black, "Claim your free Peko Credits", font: .medium(size: 14))
                    cell.buttonTitleLabel.text = "Claim Now"
                }
                
                cell.viewButton.removeTarget(self, action: nil, for: .touchUpInside)
                cell.viewButton.addTarget(self, action: #selector(viewPekoCreditButtonClick(sender: )), for: .touchUpInside)
                
                
                return cell
                
            }else if indexPath.section == 3 { // Alert // Up Coming
                //DashboardBannerCell
                
                if self.isShowSkeletonView {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingPaymentsCollectionViewCell", for: indexPath) as! UpcomingPaymentsCollectionViewCell
                    cell.backgroundColor = .clear
                    cell.clipsToBounds = false
                    cell.contentView.clipsToBounds = false
                    cell.view_1.showAnimatedGradientSkeleton()
                    return cell
                }else{
                    
                    if self.dashboardModel?.alerts?.count == 0 {
                        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardNoUpcomingPaymentCollectionViewCell", for: indexPath)
                        cell.backgroundColor = .clear
                        
                        return cell
                    }else{
                        
                        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardAlertCollectionViewCell", for: indexPath) as! DashboardAlertCollectionViewCell
                        cell.backgroundColor = .clear
                        cell.clipsToBounds = false
                        cell.contentView.clipsToBounds = false
                        cell.view_1.hideSkeleton()
                      
                        cell.alertCollectionView.tag = 300
                      
                        cell.alertCollectionView.delegate = self
                        cell.alertCollectionView.dataSource = self
                        cell.alertCollectionView.register(UINib(nibName: "UpcomingPaymentsCollectionViewCell", bundle: .module), forCellWithReuseIdentifier: "UpcomingPaymentsCollectionViewCell")
                        cell.alertCollectionView.backgroundColor = .clear
                      
                        cell.pageControl.numberOfPages = self.alertArray.count
                        self.alertPageControl = cell.pageControl
                        
                        return cell
                    }
                
                }
            }else if indexPath.section == 4 { // Offers
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardOfferContainerCollectionViewCell", for: indexPath) // as! DashboardBannerCollectionViewCell
                cell.backgroundColor = .clear
                
                let offerCollectionView = cell.viewWithTag(200) as! UICollectionView
                
                offerCollectionView.register(UINib(nibName: "ApplyForCardCollectionViewCell", bundle: .module), forCellWithReuseIdentifier: "ApplyForCardCollectionViewCell")
                offerCollectionView.delegate = self
                offerCollectionView.dataSource = self
                offerCollectionView.backgroundColor = .clear
                //cell.bannerCollectionView.tag = 200
                offerCollectionView.reloadData()
                
                return cell
                
            }else if indexPath.section == 5 {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ApplyForCardCollectionViewCell", for: indexPath) as! ApplyForCardCollectionViewCell
                cell.backgroundColor = .clear
                cell.bannerImgView.backgroundColor = .clear
                cell.bannerImgView.cornerRadius = 12
                cell.bannerImgView.contentMode = .scaleAspectFill
                
                if self.isShowSkeletonView {
                    cell.view_1.showAnimatedGradientSkeleton()
                }else{
                    cell.view_1.hideSkeleton()
                    cell.bannerImgView.image = UIImage(named: "banner_gift_cards", in: .module, with: nil)
                }
                return cell
            }else if indexPath.section == 6 {
                
                let footerCell = self.getFooterCollectionViewCell(indexPath: indexPath, collectionView: collectionView)
                return footerCell
                
            }
          
        }else if collectionView.tag == 100 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardBannerCell", for: indexPath) // as! UpcomingPaymentsCollectionViewCell
            cell.backgroundColor = .clear
            
            if let model = self.dashboardModel?.allBanners![indexPath.row] as? BannersDataModel{
                let imgview = cell.viewWithTag(301) as! UIImageView
                imgview.sd_setImage(with: URL(string: model.bannerImage ?? ""))
                imgview.contentMode = .scaleAspectFill
                imgview.backgroundColor = .clear
//                imgview.layer.cornerRadius = 15
//                imgview.maskToBounds = true
//                imgview.clipsToBounds = true
            }
            return cell
        }else if collectionView.tag == 200 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ApplyForCardCollectionViewCell", for: indexPath) as! ApplyForCardCollectionViewCell
            cell.backgroundColor = .clear
            cell.bannerImgView.backgroundColor = .clear
            cell.bannerImgView.cornerRadius = 13
            cell.bannerImgView.contentMode = .scaleAspectFill
            
            if self.isShowSkeletonView {
                cell.view_1.showAnimatedGradientSkeleton()
            }else{
                cell.view_1.hideSkeleton()
                cell.bannerImgView.image = UIImage(named: self.offerBannerArray[indexPath.row], in: .module, with: nil)
            }
            return cell
        }else if collectionView.tag == 300 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardAlertTableConatinerCollectionViewCell", for: indexPath) as! DashboardAlertTableConatinerCollectionViewCell
            cell.backgroundColor = .clear
            cell.clipsToBounds = false
            cell.contentView.clipsToBounds = false
           
            cell.tableView.tag = indexPath.row
            cell.tableView.delegate = self
            cell.tableView.dataSource = self
            cell.tableView.separatorStyle = .none
            cell.tableView.backgroundColor = .clear
            cell.tableView.reloadData()
            /*
            cell.view_1.hideSkeleton()
            
            let model = self.dashboardModel?.alerts![indexPath.row]
            
            cell.titleLabel.text = model?.message ?? ""
            cell.detailLabel.text = model?.type ?? ""
            
            if model?.providerImage == nil {
                cell.logoImgView.image = nil
            }else{
                cell.logoImgView.sd_setImage(with: URL(string: model?.providerImage ?? ""))
            }
            */
            return cell
        }
        
        
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.isShowSkeletonView {
            return
        }
        
        // HPM
        /*
        if UserSession().username == Constants.guest_username {
            self.loginRequired()
        }else{
            if collectionView == self.homeCollectionView {
                if indexPath.section == 0 {
                    
                    if UserSession().sub_corporate_id == 0 && indexPath.row == 7 {
                        self.searchButtonClick(UIButton())
                    }else{
//                        var dic1 = [String:String]()
//                        dic1 = Constants.paymentServicesArray[indexPath.row]
                        
                        let model = objServiceAccessManager.serviceListArray[indexPath.row] // searchAllServiceArray[indexPath.row]
                        
                        let dic = objServiceAccessManager.allPaymentServicesDictionary[model.label ?? ""]!
                        
                        self.goToServicePage(dic: dic)
                    }
                
                }else if indexPath.section == 1 { // Upcomming Payments
                  
                }else if indexPath.section == 5 {
                 // HARDIK M
                    /*
                    let dic = [
                         "title":"Gift Cards",
                         "icon":"icon_gift_cards",
                         "index":"9",
                         "access_key":"youGotAGift"
                     ]
                     self.goToServicePage(dic: dic)
                    */
                    self.goToServicePage(serviceName: "Gift Cards")
                }
            }else if collectionView.tag == 100 {
                if let model = self.dashboardModel?.allBanners![indexPath.row] as? BannersDataModel{
                    let title = model.bannerTitle ?? ""
                    
                    self.goToServicePage(serviceName: title)
                }
            }else if collectionView.tag == 200 {
               
                var url = ""
                if indexPath.row == 0 { // TAX
                    url = "/tax-&-more"
                }else if indexPath.row == 1 { // CARD
                    url = "/corporate-cards"
                }else if indexPath.row == 2 { // ESIM
//                    url = "/corporate-travel/eSIM"
                    self.goToServicePage(serviceName: "eSIM")
                    return
                    
                }else if indexPath.row == 3 { // CARBON
                    url = "/more-services/zero-carbon"
                }
                let url2 = ApiEnd().WEB_URL + url
                print(url)
                self.openURL(urlString:url2, inSideApp: false)
               
            }
        }
        */
    }
    // MARK: - DashboardRewardCollectionViewCell
    func getFooterCollectionViewCell(indexPath:IndexPath, collectionView:UICollectionView) -> DashboardRewardCollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardRewardCollectionViewCell", for: indexPath) as! DashboardRewardCollectionViewCell
        cell.backgroundColor = .clear
       
        if objShareManager.selectedCountry == .UAE {
            cell.indiaImgView.isHidden = true
            cell.uaeImgView.isHidden = false
        }else{
            cell.indiaImgView.isHidden = false
            cell.uaeImgView.isHidden = true
        }
        return cell
    }
    // MARK: - View Peko Credit
    @objc func viewPekoCreditButtonClick(sender:UIButton){
       // HPM
        /*
        if let viewController = PekoCreditsViewController.storyboardInstance(){
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        */
    }
    // HPM
    /*
    // MARK: - Open Whats App
    func openWhatsapp(){
        let urlWhats = "whatsapp://send?phone=\(Constants.WhatsAppHelpNumber)"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    print("Install Whatsapp")
                    
                    //  UIApplication.shared.open(URL(string: "https://api.whatsapp.com/send?phone=\(Constants.WhatsAppHelpNumber)")!, options: [:], completionHandler: nil)
                    // &text=Invitation
                }
            }
        }
    }
  */
    //MARK: -  BANNER TIMERS
    // MARK: -
    
    func bannersStartTimer(){
        if (self.dashboardModel?.allBanners?.count ?? 0) > 0 {
            self.bannerTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(bannersTimerAction), userInfo: nil, repeats: true)
        }
    }
    func bannersStopTimer(){
        if self.bannerTimer != nil {
            self.bannerTimer?.invalidate()
            // self.bannerTimer = nil
        }
    }
    @objc func bannersTimerAction(){
        
        if self.bannerCurrentIndex < (self.dashboardModel?.allBanners?.count ?? 0) {
            
        } else {
            self.bannerCurrentIndex = 0
        }
        
        self.bannerCollectionView!.scrollToItem(at: IndexPath(item: self.bannerCurrentIndex, section: 0), at: .centeredHorizontally, animated: true)
        self.bannerPageControl!.currentPage = self.bannerCurrentIndex
        self.bannerCurrentIndex += 1
        
    }
}
// MARK: - UITableViewView Delegate
extension HomeViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let array = self.alertArray[tableView.tag]
        
        return array.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingPaymentTableViewCell") as! UpcomingPaymentTableViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.payNowButton.backgroundColor = .redButtonColor
        
        let array = self.alertArray[tableView.tag]
        
        let model = array[indexPath.row]
        
        cell.titleLabel.text = model.message ?? ""
        cell.detailLabel.text = model.type ?? ""
        
        if model.providerImage == nil {
            cell.logoImgView.image = nil
            
            if model.type == "Cashback" {
                cell.logoImgView.image = UIImage(named: "icon_alert_cashback", in: .module, with: nil)
            }else if model.type == "Order Pending" {
                cell.logoImgView.image = UIImage(named: "icon_office_supplies", in: .module, with: nil)
            }else if model.type == "Monthly Spending" {
                cell.logoImgView.image = UIImage(named: "icon_dashbaord_month_spend", in: .module, with: nil)
            }else if model.type == "DED Renewal" {
                cell.logoImgView.image = UIImage(named: "icon_license_renewal", in: .module, with: nil)
            }else if model.type == "TRN Number Expired" {
                cell.logoImgView.image = UIImage(named: "icon_trn_number", in: .module, with: nil)
            }else if model.type == "Trade License Expired" {
                cell.logoImgView.image = UIImage(named: "icon_trade_license", in: .module, with: nil)
            }else{
                cell.logoImgView.image = UIImage(named: "icon_alert_default", in: .module, with: nil)
            }
        }else{
            cell.logoImgView.sd_setImage(with: URL(string: model.providerImage ?? ""))
        }
        cell.payNowButton.isUserInteractionEnabled = true
        cell.payNowButton.removeTarget(self, action: nil, for: .touchUpInside)
        cell.payNowButton.tag = indexPath.row
    //    cell.payNowButton.addTarget(self, action: #selector(alertPayNowButtonClick(sender: )), for: .touchUpInside)
        
        if model.action == "View" {
            cell.payNowButton.setTitle("View", for: .normal)
        }else{
            cell.payNowButton.setTitle("Pay Now", for: .normal)
        }
        // HPM
        /*
        cell.payNowButton.removeAllActions()
        cell.payNowButton.removeTarget(self, action: nil, for: .touchUpInside)
        cell.payNowButton.addAction(for: .touchUpInside) {
            
            if model.type == "Cashback" {
               // self.tabBarController?.selectedIndex = 3 // TRANSACTION SCREEN
                if let reportVC = ReportsViewController.storyboardInstance() {
                    reportVC.isShowCashback = true
                    self.navigationController?.pushViewController(reportVC, animated: true)
                }
            }else if model.type == "Order Pending" { // OFFICE SUPPLIES SCREEN
                DispatchQueue.main.async {
                    objPekoStoreManager = PekoStoreManager.sharedInstance
                    self.trolleyButtonClick()
                }
            }else if model.type == "Monthly Spending" { // TRANSACTION SCREEN
                if let reportVC = ReportsViewController.storyboardInstance() {
                    self.navigationController?.pushViewController(reportVC, animated: true)
                }
            }else if model.type == "DED Renewal" { // LICENCE RENEWAL SCREEN
                DispatchQueue.main.async {
                  self.goToServicePage(serviceName: "License Renewal")
                }
            }else if model.type == "TRN Number Expired" || model.type == "Trade License Expired" {
                DispatchQueue.main.async {
                    if let profileVC = ProfileViewController.storyboardInstance() {
                        self.navigationController?.pushViewController(profileVC, animated: true)
                    }
                }
            }else{
                DispatchQueue.main.async { // BILL PAYMENTS SCREEN
                    self.goToServicePage(serviceName: "Bill Payments")
                   }
                }
            }
        
        }
        */
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
   
}



extension HomeViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == bannerCollectionView {
            if self.bannerCollectionView != nil {
                let visibleRect = CGRect(origin: self.bannerCollectionView!.contentOffset, size: self.bannerCollectionView!.bounds.size)
                let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
                if let visibleIndexPath = self.bannerCollectionView!.indexPathForItem(at: visiblePoint) {
                    self.bannerPageControl!.currentPage = visibleIndexPath.row
                    self.bannerCurrentIndex = visibleIndexPath.row
                }
            }
        }else if scrollView.tag == 300 {
            let visibleRect = CGRect(origin: scrollView.contentOffset, size: scrollView.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            if let visibleIndexPath = (scrollView as! UICollectionView).indexPathForItem(at: visiblePoint) {
                self.alertPageControl!.currentPage = visibleIndexPath.row
                // self.bannerCurrentIndex = visibleIndexPath.row
            }
        }
    }
}

class HomeHeaderCollectionReusableView:UICollectionReusableView {
    @IBOutlet weak var titleLabel: PekoLabel!
    
}

// MARK: -
class DashboardCardCollectionViewCell:UICollectionViewCell {
    @IBOutlet weak var monthlySpendLabel: UILabel!
    @IBOutlet weak var totalCashbackLabel: UILabel!
    
    @IBOutlet weak var view_1: UIView!
    @IBOutlet weak var view_2: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //        self.view_1.isSkeletonable = true
        //        self.view_2.isSkeletonable = true
        self.layoutSubviews()
        self.layoutSkeletonIfNeeded()
    }
    
    override func layoutSubviews() {
        
    }
    
}
class DashboardBannerCollectionViewCell:UICollectionViewCell {
    
    @IBOutlet weak var view_1: UIView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    //  @IBOutlet weak var bannerImgView: UIImageView!
    override func layoutSubviews() {
        self.view_1.isSkeletonable = true
    }
    
}
class DashboardOfferCollectionViewCell:UICollectionViewCell {
    
    @IBOutlet weak var arrowImgView: UIImageView!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var view_1: UIView!
    
    @IBOutlet weak var titleLabel: PekoLabel!
    
    let layer0 = CAGradientLayer()
    
    func applyColor1(){
        // Auto layout, variables, and unit scale are not yet supported
      
        layer0.removeFromSuperlayer()
        
        layer0.colors = [
        UIColor(red: 0.489, green: 0.803, blue: 0.3, alpha: 1).cgColor,
        UIColor(red: 0.547, green: 0.922, blue: 0.388, alpha: 1).cgColor,
        UIColor(red: 0.483, green: 0.87, blue: 0.249, alpha: 1).cgColor
        ]
        
        layer0.locations = [0, 0.43, 1]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1.23, b: 0, c: 0, d: 1.23, tx: 0, ty: -0.12))
        layer0.bounds = view_1.bounds.insetBy(dx: -0.5*view_1.bounds.size.width, dy: -0.5*view_1.bounds.size.height)
        layer0.position = view_1.center
        view_1.layer.insertSublayer(layer0, at: 0) //addSublayer(layer0)

        view_1.layer.cornerRadius = 8

        
    }
    func applyColor2(){
        layer0.removeFromSuperlayer()
        
        layer0.colors = [
        UIColor(red: 0.975, green: 0.96, blue: 1, alpha: 1).cgColor,
        UIColor(red: 1, green: 0.967, blue: 0.957, alpha: 1).cgColor
        ]
        layer0.locations = [0, 1]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer0.bounds = view_1.bounds.insetBy(dx: -0.5*view_1.bounds.size.width, dy: -0.5*view_1.bounds.size.height)
        layer0.position = view_1.center
        
        view_1.layer.insertSublayer(layer0, at: 0)
        view_1.layer.cornerRadius = 8

        
    }
}
class DashboardAlertCollectionViewCell:UICollectionViewCell {
    
    @IBOutlet weak var alertCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    //@IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var view_1: UIView!
}

class DashboardAlertTableConatinerCollectionViewCell:UICollectionViewCell{
    @IBOutlet weak var tableView: UITableView!
    
}

//
class UpcomingPaymentTableViewCell:UITableViewCell{
    @IBOutlet weak var logoImgView: UIImageView!
    
    @IBOutlet weak var payNowButton: PekoButton!
    @IBOutlet weak var detailLabel: PekoLabel!
    @IBOutlet weak var titleLabel: PekoLabel!
}

// HPM

/*
// MARK: - AZURE
// MARK: - Setup Azure Chat
extension HomeViewController{
    // MARK: - Get Token for Chat
    func getTokenForConnectChat(){
        objConnectManager = ConnectManager.sharedInstance
        
        ConnectViewModel().getTokenForChat { response, error in
            if error != nil {
                if objShareManager.appTarget == .PEKO_LIVE {
                    self.showAlert(title: "", message: "Something went wrong please try again")
                }else {
                    self.showAlert(title: "", message: error?.localizedDescription ?? "")
                }
            }else if let status = response?.status?.value, status == true {
                DispatchQueue.main.async {
                    print(response)
                    objConnectManager?.connectTokenModel = response?.data
                    
                    self.setupAzure()
                }
            }else{
                /*
                if let code = response?.responseCode, code == "002"{
                    objErrorManager.manageSession(viewController: self) { result in
                        if result {
                            self.getTokenForConnectChat()
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
                */
                let error = ErrorModel(code: response?.responseCode, message: response?.message?.value, error: response?.error?.value, errors: response?.errors?.value)
              
                objErrorManager.manageFailResponse(error: error, viewController: self) { isReload in
                    if isReload {
                        self.getTokenForConnectChat()
                    }
                }
            }
        }
    }
    func setupAzure(){
        
        let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global(qos: .background).async {
            do {
                let endpoint = "https://peko-communication.uae.communication.azure.com/"
                let credential =
                try CommunicationTokenCredential(
                    token: objConnectManager?.connectTokenModel?.token ?? ""
                )
                let options = AzureCommunicationChatClientOptions()
                
                objConnectManager!.chatClient = try ChatClient(
                    endpoint: endpoint,
                    credential: credential,
                    withOptions: options
                )
                
//                objConnectManager!.chatClient?.startPushNotifications(deviceToken: UserSession().FCM_Token, completionHandler: { result in
//                    print(result)
//                })
                self.createCallAgent()

                objConnectManager!.chatClient!.startRealTimeNotifications { result in
                    switch result {
                    case .success:
                        print("Real-time notifications started.")
                        objConnectManager?.registerChatMessageReceived()
                    case .failure:
                        print("Failed to start real-time notifications.")
                    }
                    semaphore.signal()
                }
                semaphore.wait()

                
            } catch {
                print("Quickstart failed: \(error.localizedDescription)")
            }
        }
    }
    // MARK: - Create
    func createCallAgent() {
       
        var userCredential: CommunicationTokenCredential?
        do {
            userCredential = try CommunicationTokenCredential(token: objConnectManager?.connectTokenModel?.token ?? "")
        } catch {
            print("ERROR: It was not possible to create user credential.")
            return
        }
       
        // Creates the call agent
        objConnectManager!.callClient.createCallAgent(userCredential: userCredential!) { (agent, error) in
            if error != nil {
                print("ERROR: It was not possible to create a call agent.")
                return
            }
            else {
               // self.callAgent = agent
                print("Call agent successfully created.")
                objConnectManager?.callAgent = agent!
                objConnectManager?.callAgent?.delegate = self
                
                objConnectManager!.callClient.getDeviceManager { (deviceManager, error) in
                    if (error == nil) {
                        print("Got device manager instance")
                        objConnectManager!.deviceManager = deviceManager
                    } else {
                        print("Failed to get device manager instance")
                    }
                }
                
            }
        }
    }
}

// MARK: -
extension HomeViewController: CallAgentDelegate {
    func callAgentDidReceiveCall(call: Call) {
        print("Call agent received call.")
        
    }
    func callAgent(_ callAgent: CallAgent, didUpdateCalls args: CallsUpdatedEventArgs) {
//        if let removedCall = args.removedCalls.first {
//            removedCall.hangUp(options: HangUpOptions()) { error in
//                
//            }
//            self.incomingView = nil
//        }
    }
    /*
    func callAgent(_ callAgent: CallAgent, didUpdateCalls args: CallsUpdatedEventArgs) async {
      //  print(args.)
        print("Added Calls: ", (args.addedCalls))
        print("\nRemove Calls: ", args.removedCalls)
        
        if let removedCall = args.removedCalls.first {
            removedCall.hangUp(options: HangUpOptions()) { error in
                
            }
//            await removedCall.hangUp(options: HangUpOptions())
            self.incomingView = nil
        }
    }
    */
    func callAgent(_ callAgent: CallAgent, didRecieveIncomingCall incomingCall: IncomingCall) {
      //  print(incomingCall.participants)
        
        if let vc = ConnectChatIncomingCallViewController.storyboardInstance() {
            vc.incomingCall = incomingCall
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let window = appDelegate.window
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            
            vc.completionBlock = { call in
                
                self.incomingView = ConnectChatVoiceCallViewController.storyboardInstance()
                self.incomingView!.name = incomingCall.callerInfo.displayName
                self.incomingView!.isOutgoingCall = false
                self.incomingView!.call = call
                self.incomingView?.isVideo = incomingCall.isVideoEnabled
                
                // voiceCll.calleesArray = callees
                // self.navigationController?.pushViewController(voiceCll, animated: true)
                
                self.incomingView!.modalTransitionStyle = .crossDissolve
                self.incomingView!.modalPresentationStyle = .fullScreen
                
                if let modalVC = window!.rootViewController?.presentedViewController {
                    modalVC.present(self.incomingView!, animated: true, completion: nil)
                } else {
                    window!.rootViewController!.present(self.incomingView!, animated: true, completion: nil)
                }
            }
            
            if let modalVC = window!.rootViewController?.presentedViewController {
                modalVC.present(vc, animated: true, completion: nil)
            } else {
                window!.rootViewController!.present(vc, animated: true, completion: nil)
            }
        }
    }
}
// MARK: - PUSHER
extension HomeViewController {
    func addPusherEventForNotification(){
        let myChannel = objShareManager.pusher!.subscribe("push-notification")
        
        let _ = myChannel.bind(eventName: "real-time-notification", eventCallback: { (data: Any?) -> Void in
            
            print("\nDATA -> ", data)
            if let event = data as? PusherEvent {
                print("EVENT => ", event)
                let dictionary = (event.data ?? "").convertToDictionary()
                if let body = dictionary!["body"] as? String, UserSession().username == body {
                    self.getNotifications()
                }
            }
        })
        
    }
}
*/

class DashboardRewardCollectionViewCell:UICollectionViewCell{
    
    @IBOutlet weak var uaeImgView: UIImageView!
    
    @IBOutlet weak var indiaImgView: UIImageView!
    
    
}

class DashboardPekoCreditCollectionViewCell:UICollectionViewCell{
    
    @IBOutlet weak var titleLabel: PekoLabel!
    @IBOutlet weak var viewButton: PekoButton!
    @IBOutlet weak var buttonTitleLabel: PekoLabel!
    //    @IBOutlet weak var uaeImgView: UIImageView!
//    
//    @IBOutlet weak var indiaImgView: UIImageView!
    
    
}
