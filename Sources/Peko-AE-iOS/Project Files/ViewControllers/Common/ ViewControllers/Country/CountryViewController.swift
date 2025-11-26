//
//  CountryViewController.swift
//  Peko
//
//  Created by Hardik Makwana on 14/09/23.
//

import UIKit

class CountryViewController: UIViewController {

    @IBOutlet weak var searchTxt: PekoTextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noSearchView: UIView!
  
    var completionBlock:((_ selectedCountryName: String,_ selectedCountryCode:String) -> Void)?
    var countryArray = [CountryModel]()
    var searchCountryArray = [CountryModel]()
    var flagIndicesDictionary = [String:Int]()
    var selectedCountryName = ""
    var selectedCountryCode = ""
    
    
    static func storyboardInstance() -> CountryViewController? {
        return AppStoryboards.Common.instantiateViewController(identifier: "CountryViewController") as? CountryViewController
    }
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Country"
        
        if let url = Bundle.main.url(forResource: "Countries", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                self.countryArray = try decoder.decode([CountryModel].self, from: data)
                self.searchCountryArray = self.countryArray
            } catch {
                print("error:\(error)")
            }
        }
        
        if let url = Bundle.main.url(forResource: "flag_indices", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
               
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [String:Int] {
                    self.flagIndicesDictionary = jsonResult
                }
            } catch {
                // handle error
            }
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
    
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonCLick))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonClick))
        
        if self.selectedCountryName.count == 0 {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }else{
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        
        self.searchTxt.addTarget(self, action: #selector(textFieldDidChangeSelection), for: .editingChanged)
        // Do any additional setup after loading the view.
    }
    @objc func cancelButtonCLick(){
        self.dismiss(animated: true)
    }
    @objc func doneButtonClick(){
        if self.completionBlock != nil {
            self.completionBlock!(self.selectedCountryName, self.selectedCountryCode)
        }
        self.dismiss(animated: true)
    }
    
    // MARK: -
    @objc func textFieldDidChangeSelection() {
        let searchText = self.searchTxt.text!.lowercased()
        
        if searchText.count == 0 {
            self.searchCountryArray = self.countryArray
            self.noSearchView.isHidden = true
        }else{
            
            let array1 = self.countryArray.filter {
                (($0.name ?? "").lowercased().contains(searchText))
            }
            
            self.searchCountryArray = array1
            if array1.count == 0 {
             //   self.searchProductsArray = productsArray
                self.noSearchView.isHidden = false
            }else{
             //   self.searchProductsArray = array1
                self.noSearchView.isHidden = true
            }
        }
        self.tableView.reloadData()
    }
    
    // MARK: -
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    func imageFromCountryCode(code:String) -> UIImage {
        
        let y = self.flagIndicesDictionary[code]
        if (y != nil) {
            let image = UIImage(named: "flags.png")?.cgImage
            let cropRect = CGRect(x: 0, y: y! * 2, width: 32, height: 32)
            let imageRef = image!.cropping(to: cropRect)
            
            return UIImage(cgImage: imageRef!)
        }
        
        return UIImage(named: "flag_missing.png")!
    }
    
    /*
    
    
    + (UIImage *)imageForCountryCode:(NSString *)code{
        NSNumber * y = [NSJSONSerialization JSONObjectWithData:[[[NSString alloc] initWithContentsOfFile:[[PCCPViewController resourceBundle] pathForResource:@"flag_indices" ofType:@"json"]
                                                                                                encoding:NSUTF8StringEncoding
                                                                                                   error:NULL]
                                                                dataUsingEncoding:NSUTF8StringEncoding]
                                                       options:kNilOptions
                                                         error:nil][code];
        if (!y) {
            y = @0;
        }
        CGImageRef cgImage = CGImageCreateWithImageInRect([[UIImage imageWithContentsOfFile:[[PCCPViewController resourceBundle] pathForResource:@"flags" ofType:@"png"]] CGImage], CGRectMake(0, y.integerValue * 2, 32, 32));
     
     UIImage * result = [UIImage imageWithCGImage:cgImage scale:2.0 orientation:UIImageOrientationUp];
        CGImageRelease(cgImage);
        return result;
    }
   */
}
extension CountryViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchCountryArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell") as! CountryTableViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        let country = self.searchCountryArray[indexPath.row]
       
        cell.titleLabel?.text = country.name
      //  cell.imgView?.sd_setImage(with: URL(string: country.flag!), placeholderImage: nil)
        let url = URL(string: country.flag!)
        cell.imgView?.image = self.imageFromCountryCode(code: country.alpha2Code ?? "")

        if self.selectedCountryName == country.name {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let country = self.searchCountryArray[indexPath.row]
        self.selectedCountryName = country.name ?? ""
        self.selectedCountryCode = country.alpha2Code ?? ""
        tableView.reloadData()
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        
    }
}
class CountryTableViewCell:UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
}


struct CountryModel: Codable {
  
    let name:String?
    let alpha2Code:String?
    let alpha3Code:String?
    let flag:String?
}


