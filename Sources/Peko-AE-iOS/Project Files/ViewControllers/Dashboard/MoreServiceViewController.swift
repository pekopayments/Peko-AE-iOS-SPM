//
//  MoreServiceViewController.swift
//  Peko
//
//  Created by Hardik Makwana on 08/01/23.
//

import UIKit


class MoreServiceViewController: UIViewController {

    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var serviceCollectionView: UICollectionView!
  //  @IBOutlet var searchView: UIView!
    
    @IBOutlet weak var searchTxt: UITextField!
    
    static func storyboardInstance() -> MoreServiceViewController? {
        return AppStoryboards.Home.instantiateViewController(identifier: "MoreServiceViewController") as? MoreServiceViewController
    }
  
//    var allServiceArray:[Dictionary<String,String>] = 
    
    //    Corporate Cards
   //     Works
    var upcomingServiceArray = [
        PekoPaymentServiceModel(title: "Connect", icon: "icon_peko_connect", access_key: "", serviceAccessKey: "/more-services/connect", index: 17),
        PekoPaymentServiceModel(title: "Tax and More", icon: "icon_taxt_more", access_key: "", serviceAccessKey: "/tax-&-more", index: 19),
        PekoPaymentServiceModel(title: "Zero Carbon", icon: "icon_carbon_footprint", access_key: "", serviceAccessKey: "/more-services/zero-carbon", index: 10),
        PekoPaymentServiceModel(title: "Office Address", icon: "icon_office_space", access_key: "", serviceAccessKey: "/more-services/office-address", index: 14),
        PekoPaymentServiceModel(title: "WhatsApp for Business", icon: "icon_whatsApp_business", access_key: "", serviceAccessKey: "/whatsApp-for-business", index: 0),
        PekoPaymentServiceModel(title: "Works", icon: "icon_works", access_key: "", serviceAccessKey: "/more-services/works", index: 0),
        PekoPaymentServiceModel(title: "Corporate Cards", icon: "icon_corporate_cards", access_key: "", serviceAccessKey: "/corporate-cards", index: 0),
        PekoPaymentServiceModel(title: "PRO Services", icon: "icon_PRO_service", access_key: "", serviceAccessKey: "/more-services/PRO-Service", index: 0),
        PekoPaymentServiceModel(title: "Hike", icon: "icon_hike", access_key: "", serviceAccessKey: "/more-services/hike", index: 0),
        PekoPaymentServiceModel(title: "Accounting", icon: "icon_accounting", access_key: "", serviceAccessKey: "/accounting", index: 0),
     //   PekoPaymentServiceModel(title: "eSign", icon: "icon_eSign", access_key: "", serviceAccessKey: "/more-services/eSign", index: 0),
  
    ]
   
    var searchAllServiceArray = [UpgradeServiceAccessDataModel]() //[Dictionary<String,String>]()
    var searchUpcomingServiceArray = [PekoPaymentServiceModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.serviceCollectionView.delegate = self
        self.serviceCollectionView.dataSource = self
      
       // self.isBackNavigationBarView = true
        
      //  self.setTitle(title: "All Payments & Expenses")
        self.setTitle(title: "All Services")
        
        self.serviceCollectionView.register(UINib(nibName: "DashboardServiceCollectionViewCell", bundle: .module), forCellWithReuseIdentifier: "DashboardServiceCollectionViewCell")
      
    
        
        self.searchAllServiceArray = objServiceAccessManager.serviceListArray //Constants.paymentServicesArray
        self.searchUpcomingServiceArray = self.upcomingServiceArray
        
        self.searchTxt.addTarget(self, action: #selector(textFieldDidChangeSelection), for: .editingChanged)
       
    }
    override func viewWillAppear(_ animated: Bool) {
    //    self.navigationController?.isNavigationBarHidden = true
    }
  // MARK: -
    @objc func textFieldDidChangeSelection() {
        let searchText = self.searchTxt.text!.lowercased()
      
      // Constants.paymentServicesArray.filter { $0["title"]!.lowercased().contains(searchText) }
        if searchText.count == 0 {
            self.searchAllServiceArray = objServiceAccessManager.serviceListArray
            
            self.searchUpcomingServiceArray = upcomingServiceArray
        }else{
            let array1 = objServiceAccessManager.serviceListArray.filter { ($0.label ?? "").lowercased().contains(searchText) }
            self.searchAllServiceArray = array1
            
            let array2 = self.upcomingServiceArray.filter { $0.title.lowercased().contains(searchText) }
          
            self.searchUpcomingServiceArray = array2
        }
        
        if self.searchAllServiceArray.count == 0 && self.searchUpcomingServiceArray.count == 0 {
            self.noDataView.isHidden = false
        }else{
            self.noDataView.isHidden = true
        }
        self.serviceCollectionView.reloadData()
    }
    
}
extension MoreServiceViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if UserSession().sub_corporate_id == 0 {
            return 2
        }
        return 1
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if section == 0{
            if self.searchAllServiceArray.count == 0 {
                return CGSize(width: screenWidth, height: 0)
            }
        }else if section == 1 {
            if self.searchUpcomingServiceArray.count == 0 {
                return CGSize(width: screenWidth, height: 0)
            }
        }
        return CGSize(width: screenWidth, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader{
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HomeHeaderCollectionReusableView", for: indexPath) as! HomeHeaderCollectionReusableView
            headerView.backgroundColor = UIColor.clear
            
            headerView.titleLabel.textAlignment = .left
            headerView.titleLabel.font = UIFont.medium(size: 16)
            headerView.titleLabel.textColor = .black
            
            if indexPath.section == 0 {
                headerView.titleLabel.text = "All Services"
            }else if indexPath.section == 1 {
                headerView.titleLabel.text = "Services available on Peko Web"
            }
            return headerView
        }
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.searchAllServiceArray.count
        }else if section == 1 {
            return self.searchUpcomingServiceArray.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (screenWidth - 106) / 4
        let height = width * 0.80
        return CGSize(width: width, height: height + 30)
   
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardServiceCollectionViewCell", for: indexPath) as! DashboardServiceCollectionViewCell
        cell.backgroundColor = .clear
        cell.imgContainerView.backgroundColor = UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1.0)
      
        var dic1:PekoPaymentServiceModel?
        if indexPath.section == 0 {
            let model = searchAllServiceArray[indexPath.row]
            
            if let dic = objServiceAccessManager.allPaymentServicesDictionary[model.label ?? ""]{
                dic1 = dic
            }
            
        }else{
            dic1 = searchUpcomingServiceArray[indexPath.row]
        }
      
        cell.titleLabel.font = UIFont.regular(size: 10)
        cell.titleLabel.text = dic1?.title
        cell.logoImgView.image = UIImage(named: dic1?.icon ?? "", in: .module, with: nil)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        if indexPath.section == 0 {// Payments
            
            var dic1:PekoPaymentServiceModel?
            
            let model = searchAllServiceArray[indexPath.row]
            
            dic1 = objServiceAccessManager.allPaymentServicesDictionary[model.label ?? ""]!
            
            // HPM
            // self.goToServicePage(dic: dic1!)
            
        }else if indexPath.section == 1 {
          //  var dic1 = [String:String]()
            let dic1 = searchUpcomingServiceArray[indexPath.row]
      
            let url = ApiEnd().WEB_URL + (dic1.serviceAccessKey)
            print(url)
            self.openURL(urlString:url, inSideApp: false)
        }
    }
}
class MoreFooterCollectionReusableView:UICollectionReusableView {
    
   // @IBOutlet weak var titleLabel: UILabel!
}
