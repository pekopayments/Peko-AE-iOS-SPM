//
//  PekoTextFieldView.swift
//  Peko
//
//  Created by Hardik Makwana on 19/02/24.
//

import UIKit


protocol PekoTextFieldDelegate: UITextFieldDelegate {

    func textChange(textField:PekoTextField)
    func textEndEditing(textField:PekoTextField)

}
public class PekoTextField: UITextField {
    
    var pekoTextFieldViewDelegate:PekoTextFieldDelegate?
    @IBInspectable var maxLength: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    func setup(){
        self.delegate = self
        
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
      
        
    }
    
    @IBInspectable var textFieldTypeName: String? {
        didSet {
            if let newStyle = TextFieldType(rawValue: textFieldTypeName?.capitalized ?? "Default") {
                self.textFieldType = newStyle
            }
        }
    }
    
    var textFieldType: TextFieldType = .Default {
        didSet {
            self.setupTextField()
        }
    }
    
    func setupTextField(){
        switch self.textFieldType {
        case .Default:
            self.keyboardType = .default
            break
        case .Username:
            self.keyboardType = .default
            self.textContentType = .username
            break
        case .Password:
            self.keyboardType = .default
            self.textContentType = .password
            self.rightViewMode = UITextField.ViewMode.always
            self.isSecureTextEntry = true
            let width = self.bounds.height
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: width))
            
            let button = UIButton(frame: view.bounds)
            button.setImage(UIImage(named: "icon_password_eye"), for: .normal)
            button.setImage(UIImage(named: "icon_password_eye_slash"), for: .selected)
            button.backgroundColor = .clear
            button.addTarget(self, action: #selector(eyeButtonClick), for: .touchUpInside)
            view.addSubview(button)
            view.backgroundColor = .clear
            self.rightView = view
            
            break
        case .Email:
            self.keyboardType = .emailAddress
            self.textContentType = .emailAddress
            break
        case .Number:
            self.keyboardType = .numberPad
            
            break
        case .Decimal:
            self.keyboardType = .decimalPad
            
            break
        case .Dropdown:
            self.keyboardType = .default
            
            self.rightViewMode = UITextField.ViewMode.always
            
            let width = self.bounds.height
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: width))
            
            let imageView = UIImageView(frame: view.bounds)
            imageView.image = UIImage(named: "icon_arrow_down_black")
            imageView.contentMode = .center
            view.addSubview(imageView)
            view.backgroundColor = .clear
            self.rightView = view
            
            self.isUserInteractionEnabled = false
            break
        case .Phone:
            self.keyboardType = .numberPad
            self.textContentType = .telephoneNumber
            let width = self.bounds.height
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: width))
            view.backgroundColor = .clear
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: width))
            
            if objShareManager.selectedCountry == .UAE {
                imageView.image = UIImage(named: "icon_country_uae_flag_square")
            }else if objShareManager.selectedCountry == .INDIA{
                imageView.image = UIImage(named: "icon_country_india_flag_square")
            }
            
            imageView.contentMode = .center
            view.addSubview(imageView)
            
            let label = UILabel(frame: CGRect(x: 34, y: 0, width: 35, height: width))
            label.font = AppFonts.Regular.size(size: 14)
            
            if objShareManager.selectedCountry == .UAE {
                label.text = "+971"
            }else if objShareManager.selectedCountry == .INDIA{
                label.text = "+91"
            }
            
            view.addSubview(label)
            
            self.leftViewMode = UITextField.ViewMode.always
            self.leftView = view
            self.maxLength = 9
            break
        case .Mobile:
            self.keyboardType = .numberPad
            self.textContentType = .telephoneNumber
            let width = self.bounds.height
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: width))
            view.backgroundColor = .clear
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: width))
            label.font = AppFonts.Regular.size(size: 14)
          
            // label.text = "+91"
            
            if objShareManager.selectedCountry == .UAE {
                label.text = "+971"
                self.maxLength = 9
            }else if objShareManager.selectedCountry == .INDIA{
                label.text = "+91"
                self.maxLength = 10
            }
            
            view.addSubview(label)
            
            self.leftViewMode = UITextField.ViewMode.always
            self.leftView = view
            
            break
        case .PhoneCode:
            
            break
        case .Landline:
            self.keyboardType = .numberPad
            self.textContentType = .telephoneNumber
            self.maxLength = 10
            break
        case .Calendar:
            
            break
        case .Time:
            
            break
            
        case .Name:
            self.keyboardType = .default
            
            break
        case .NameAndDot:
            self.keyboardType = .default
            
            break
        case .Alphanumber:
            self.keyboardType = .numbersAndPunctuation
            
            break
        case .Zipcode:
            self.keyboardType = .numberPad
            
            break
        case .Symbol:
            self.keyboardType = .default
           
            break
        case .Symbol_2:
            self.keyboardType = .default
           
            break
        case .UppercaseNumber:
            self.leftViewMode = .never
            self.keyboardType = .default
            self.autocapitalizationType = .allCharacters
            break
        case .Custom:
            self.leftViewMode = .never
            self.keyboardType = .default
            break
        case .CustomCharachter:
            self.leftViewMode = .never
            self.keyboardType = .default
            break
        }
    }
    // MARK: - Eye Button Click
    @objc func eyeButtonClick(_ sender: UIButton) {
        self.isSecureTextEntry = sender.isSelected
        sender.isSelected = !sender.isSelected
    }
}
extension PekoTextField{
//    @objc fileprivate func textFieldDidEndEditing() {
//        if self.text == "" {
//            self.placeholder = self.placeholder.localizeString()
//            self.hideFloatingTitle()
//        }
//    }
//    @objc fileprivate func textFieldDidBeginEditing() {
//        self.showFloatingTitle()
//        self.placeholder = ""
//        //  self.borderView.layer.borderColor = self.active_color.cgColor
//        // }
//        //  self.delegate?DidBeginEditing?(textField: self)
//    }
    @objc func textFieldDidChange(_ textField: PekoTextField) {
        if self.pekoTextFieldViewDelegate != nil {
            self.pekoTextFieldViewDelegate?.textChange(textField: self)
        }
    }
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
}
extension PekoTextField:UITextFieldDelegate{
    public func textField(_ textField: UITextField,shouldChangeCharactersIn range: NSRange,replacementString string: String) -> Bool
    {
        
        if string.count == 0 {
            return true
        }
        
        if string == " " {
            if textField.text?.count == 0 {
                return false
            }
            let array = Array(textField.text!)
            if array.last == " " {
                return false
            }
        }
        if string.containsEmoji() {
            return false
        }
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        
        if newString.containsEmoji() {
            return false
        }
        
        if self.maxLength != 0 {
            if newString.count > self.maxLength {
                return false
            }
        }
        
        if self.textFieldType == .Phone || self.textFieldType == .Mobile {
            if string == "0" && textField.text?.count == 0 {
                return false
            }
            return textField.numberValidation(number: string)
        }else if self.textFieldType == .Landline {
            return textField.numberValidation(number: string)
        }else if self.textFieldType == .Number {
            if string == "0" && textField.text?.count == 0 {
                return false
            }
            return textField.numberValidation(number: string)
        }else if self.textFieldType == .Zipcode {
            
            return textField.numberValidation(number: string)
        }else if self.textFieldType == .Decimal {
            return textField.decimalNumberValidation(number: string)
        }else if self.textFieldType == .Username || self.textFieldType == .Password {
            if string == " " {
                return false
            }
        }else if self.textFieldType == .Name {
            return textField.alphaValidation(string: string)
        }
        else if self.textFieldType == .NameAndDot {
            return textField.alphaDotValidation(string: string)
        }
        else if self.textFieldType == .Alphanumber {
            return textField.alphaNumericValidation(string: string)
        }
        else if self.textFieldType == .Email {
            return textField.emailValidation(string: string)
        }else if self.textFieldType == .Symbol {
            return textField.alphaNumberSymbolValidation(string: string)
        }else if self.textFieldType == .Symbol_2 {
            return textField.alphaNumberSymbol_2Validation(string: string)
        }else if self.textFieldType == .UppercaseNumber {
            return textField.uppercaseNumber(string: string)
        }else if self.textFieldType == .Custom {
           // return textField.customRegexValidation(string: string, customRegex: self.cu)
        }else if self.textFieldType == .CustomCharachter {
//            return textField.customCharacterValidation(string: string, customRegex: self.customRegEx)
        }
        return true
//
//        if self.textFieldType == .Phone || self.textFieldType == .Mobile || self.textFieldType == .Landline {
//            
//            let maxLength = 10
//            let currentString = (textField.text ?? "") as NSString
//            let newString = currentString.replacingCharacters(in: range, with: string)
//            
//            if newString.count <= maxLength {
//                return textField.numberValidation(number: string)
//            }
//            return false
//        }else if self.textFieldType == .Number {
//            return textField.numberValidation(number: string)
//        }else if self.textFieldType == .Decimal {
//            return textField.decimalNumberValidation(number: string)
//        }else if self.textFieldType == .Username || self.textFieldType == .Password {
//            if string == " " {
//                return false
//            }
//        }else if self.textFieldType == .Name {
//            return textField.alphaValidation(string: string)
//        }else if self.textFieldType == .Alphanumber {
//            return textField.alphaNumericValidation(string: string)
//        }
//        return true
    }
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if self.pekoTextFieldViewDelegate != nil {
            self.pekoTextFieldViewDelegate?.textEndEditing(textField: self)
        }
    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //        if textField == self.emailTxt {
        //            self.passwordTxt.becomeFirstResponder()
        //        }else{
        //            self.loginButtonClick(UIButton())
        //        }
        textField.resignFirstResponder()
        return true
    }
}
