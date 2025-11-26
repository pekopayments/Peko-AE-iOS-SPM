//
//  PhoneCodePickerViewController.swift
//  Peko
//
//  Created by Hardik Makwana on 09/06/25.
//

import UIKit


struct PhoneNumberCodeModel: Codable {
  
    let name:String?
    let phoneCode:String?
    let countryCode:String?
    let maxLength:Int?
}


class PhoneCodePickerViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noSearchDataView: UIView!
    @IBOutlet weak var searchTxt: PekoTextField!
    
    var completionBlock:((_ selectedCodeModel: PhoneNumberCodeModel) -> Void)?
 //   var completionIndexBlock:((_ index: Int) -> Void)?
    
    var selectedString: String = ""
    
    var phoneCodeArray :[PhoneNumberCodeModel] {
        if let url = Bundle.main.url(forResource: "PhoneNumberCode", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                return try decoder.decode([PhoneNumberCodeModel].self, from: data)
             //   self.searchCountryArray = self.countryArray
            } catch {
                print("error:\(error)")
            }
        }
        return [PhoneNumberCodeModel]()
    }
    
    var searchPhoneCodeArray = [PhoneNumberCodeModel]()
    
    static func storyboardInstance() -> PhoneCodePickerViewController? {
        let alert = PhoneCodePickerViewController(nibName: "PhoneCodePickerViewController", bundle: .module)
        return alert
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Phone Code"
        searchPhoneCodeArray = self.phoneCodeArray
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = .white
       
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonCLick))
        /*
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonClick))
        
        if self.selectedString.count == 0 {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }else{
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        */
//        if self.completionBlock != nil {
//            self.tableViewTopConstraint.constant = 70
//        }else{
//            self.tableViewTopConstraint.constant = 0
//        }
        
        self.searchTxt.addTarget(self, action: #selector(textFieldDidChangeSelection), for: .editingChanged)
        // Do any additional setup after loading the view.
    }
    @objc func cancelButtonCLick(){
        self.dismiss(animated: true)
    }
    @objc func doneButtonClick(){
//        if self.completionBlock != nil {
//            self.completionBlock!(selectedString)
//        }
//        
//        self.dismiss(animated: true)
    }
    // MARK: -
    @objc func textFieldDidChangeSelection() {
        let searchText = self.searchTxt.text!.lowercased()
        
        if searchText.count == 0 {
            self.searchPhoneCodeArray = self.phoneCodeArray
            self.noSearchDataView.isHidden = true
            if self.selectedString.count == 0 {
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            }
        }else{
            
            let array1 = self.phoneCodeArray.filter {
                (($0.name ?? "").lowercased().contains(searchText)) ||
                (($0.phoneCode ?? "").lowercased().contains(searchText))
            }
            
            self.searchPhoneCodeArray = array1
            if array1.count == 0 {
             //   self.searchProductsArray = productsArray
                self.noSearchDataView.isHidden = false
            }else{
             //   self.searchProductsArray = array1
                self.noSearchDataView.isHidden = true
            }
        }
        
        self.tableView.reloadData()
    }
}
extension PhoneCodePickerViewController:UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchPhoneCodeArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        let model = self.searchPhoneCodeArray[indexPath.row]
       
        cell.textLabel?.text = model.name ?? ""
        let phoneCode = "+" + (model.phoneCode ?? "")
        cell.detailTextLabel?.text = phoneCode
        
        if phoneCode == self.selectedString {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.searchPhoneCodeArray[indexPath.row]
       let phoneCode = model.phoneCode ?? ""
        if phoneCode == self.selectedString{
            self.selectedString = ""
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }else{
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.selectedString = phoneCode // ?? ""
        }
        tableView.reloadData()
        if self.completionBlock != nil {
            self.completionBlock!(model)
        }
        self.dismiss(animated: true)
    }
}
