
import UIKit
import Foundation

enum TextFieldType: String {
    case Default
    case Username // 300
    case Password // 400
    case Email // 500
    case Number // 600
    case Decimal // 700
    case Dropdown
    case Phone
    case Mobile
    case PhoneCode
    case Calendar
    case Time
    case Name
    case NameAndDot
    case Landline
    case Alphanumber
    case Zipcode
    case Symbol
    case Symbol_2
    case UppercaseNumber
    case Custom // customRegEx
    case CustomCharachter // customCharacter
}

protocol PekoFloatingTextFieldViewDelegate: UITextFieldDelegate {

    func textChange(textView:PekoFloatingTextFieldView)
    func dropDownClick(textView:PekoFloatingTextFieldView)
    func timeSelected(textView:PekoFloatingTextFieldView)
    
//    @objc optional func didTapOnRightView(textField: SKFloatingTextField)
//    @objc optional func textFieldDidEndEditing(textField : SKFloatingTextField)
//    @objc optional func textFieldDidChangeSelection(textField: SKFloatingTextField)
//    @objc optional func textFieldDidBeginEditing(textField: SKFloatingTextField)
}

public class PekoFloatingTextFieldView : UIView {
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet public weak var textField: UITextField!
    @IBOutlet private weak var titleView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bottomErrorLabel: UILabel!
   
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var infoContainerView: UIView!
    
    public var border_color: UIColor = .textFieldBorderColor //UIColor(named: "EAEAEA")!
    public var border_width: CGFloat = 1
    public var corner_radius: CGFloat = 10
    public var textColor: UIColor?
    public var phoneCodeLabel:UILabel?
    var phoneCountryCode = ""
    var customRegEx = ""
    
    var selectedDateFormat = "dd MMMM, yyyy"
    
    var selectedDate:Date? {
//        get{
//            return self.selectedDate
//        }
        willSet{
            if newValue == nil {
                self.textField.text = ""
                self.clearCalendarTextButton.isHidden = true
            }else{
                self.textField.text = newValue!.formate(format:self.selectedDateFormat)
                self.showFloatingTitle()
                if isShowDateClearButton {
                    self.clearCalendarTextButton.isHidden = false
                }else{
                    self.clearCalendarTextButton.isHidden = true
                }
            }
            
        }
    }
    var selectedTime:String? {
        willSet{
            if newValue == nil {
                self.textField.text = ""
                self.clearCalendarTextButton.isHidden = true
            }else{
                self.textField.text = newValue // newValue!.formate(format: "dd, MMMM, yyyy")
                self.showFloatingTitle()
//                if isShowDateClearButton {
//                    self.clearCalendarTextButton.isHidden = false
//                }else{
//                    self.clearCalendarTextButton.isHidden = true
//                }
            }
            
        }
    }
    
    var isShowDateClearButton = true
    var isAllowPaste = true
    
    var delegate:PekoFloatingTextFieldViewDelegate?
   
    var minimumDate:Date?
    var maximumDate:Date?
    
    var tooltip:ZGTooltipView?
    lazy var clearCalendarTextButton:UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 42, height: 42))
        button.addTarget(self, action: #selector(clearCalendarTextButtonClick(sender:)), for: .touchUpInside)
        button.setImage(UIImage(named: "icon_calendar_cross"), for: .normal)
        return button
    }()
    
    @objc func clearCalendarTextButtonClick(sender: UIButton) {
        self.textField.text = ""
        self.selectedDate = nil
        self.clearCalendarTextButton.isHidden = true
        
        /*
        if self.textFieldType == .Time {
            if self.delegate != nil {
                self.delegate?.textChange(textView: self)
                self.delegate?.timeSelected(textView: self)
            }
        }
        */
        
    }
    
    // MARK: - LEFT IMAGE
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    @IBInspectable var maxLength: Int = 0
    
    func updateView() {
        if let image = leftImage {
            self.textField.leftViewMode = UITextField.ViewMode.always
           
           
            let width = self.textField.bounds.height
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: width))
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))// (frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            imageView.center = CGPoint(x: 20, y: width / 2)
            view.addSubview(imageView)
          //  imageView.center = CGPoint(x: view.bounds.width / 2, y: width / 2)
            self.textField.leftView = view
            
            self.textField.backgroundColor = .clear
            view.backgroundColor = .clear
        } else {
            self.textField.leftViewMode = UITextField.ViewMode.never
            self.textField.leftView = nil
        }
    }

//    @IBInspectable
//    public var active_color: UIColor = .black
    
    @IBInspectable
    public var isSecureTextInput: Bool {
        get {
            return self.textField.isSecureTextEntry
        }
        set {
            self.textField.isSecureTextEntry = newValue
        }
    }
    
    public var text: String? {
        get {
            return textField.text
        }set {
            if newValue != nil {
                DispatchQueue.main.async {
                    self.textField.text = newValue
                    self.textFieldDidChangeSelection()
                }
                
            }
        }
    }
    public var tooltipText: String? {
        didSet {
            if tooltipText?.count == 0 {
                self.infoContainerView.isHidden = true
            }else{
                self.infoContainerView.isHidden = false
            }
        }
    }
    // MARK: - placeholder
    @IBInspectable var placeholder: String = "" {
        didSet {
            let color = UIColor(red: 148/255.0, green: 148/255.0, blue: 148/255.0, alpha: 1.0)
            textField.attributedPlaceholder = NSAttributedString(string: self.placeholder.localizeString(), attributes: [NSAttributedString.Key.foregroundColor : color, NSAttributedString.Key.font : AppFonts.Regular.size(size: 14)])
            self.titleLabel.text = self.placeholder.localizeString()
        }
    }
    
    @IBInspectable var textFieldTypeName: String? {
        didSet {
            // Ensure user enters a valid shape while making it lowercase.
            // Default to a body style if not
            if let newStyle = TextFieldType(rawValue: (textFieldTypeName ?? "Default").trim()) {
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
            self.textField.keyboardType = .default
            break
        case .Username:
            self.textField.keyboardType = .default
            self.textField.textContentType = .emailAddress
            break
        case .Password:
            self.textField.keyboardType = .default
//            self.textField.textContentType = .n //.password
            self.textField.rightViewMode = UITextField.ViewMode.always
            self.textField.isSecureTextEntry = true
            let width = self.textField.bounds.height
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: width))
          
            let button = UIButton(frame: view.bounds)
            button.setImage(UIImage(named: "icon_password_eye"), for: .normal)
            button.setImage(UIImage(named: "icon_password_eye_slash"), for: .selected)
            button.backgroundColor = .clear
            button.addTarget(self, action: #selector(eyeButtonClick), for: .touchUpInside)
            view.addSubview(button)
            view.backgroundColor = .clear
            self.textField.rightView = view

            break
        case .Email:
            self.textField.keyboardType = .emailAddress
            self.textField.textContentType = .emailAddress
            break
        case .Number:
            self.textField.keyboardType = .numberPad
            self.textField.leftViewMode = .never
            break
        case .Decimal:
            self.textField.keyboardType = .decimalPad

            break
        case .Dropdown:
            self.textField.keyboardType = .default
            self.textField.leftViewMode = UITextField.ViewMode.never
            self.textField.rightViewMode = UITextField.ViewMode.always
            
            let width = self.textField.bounds.height
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: width))
          
            let imageView = UIImageView(frame: view.bounds)
            imageView.image = UIImage(named: "icon_arrow_down_black")
            imageView.contentMode = .center
            view.addSubview(imageView)
            view.backgroundColor = .clear
            self.textField.rightView = view
            
            self.textField.isUserInteractionEnabled = false
            
            let dropButton = UIButton() // (frame: CGRect(x: 0, y: 6, width: self.textField.bounds.width, height: self.textField.bounds.height))
            dropButton.addTarget(self, action: #selector(dropDownButtonClick), for: .touchUpInside)
            dropButton.backgroundColor = .clear
            self.addSubview(dropButton)
            
            dropButton.translatesAutoresizingMaskIntoConstraints = false
           
         //   dropButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            dropButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            dropButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            dropButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 14).isActive = true
         //   dropButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -50).isActive = true
            
            
            dropButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            
            
            
            break
        case .Phone:
            self.textField.keyboardType = .numberPad
            self.textField.textContentType = .telephoneNumber
            let width = self.textField.bounds.height
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: width))
            view.backgroundColor = .clear
          
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: width))
           
            //icon_country_uae_flag_square
            
            if objShareManager.selectedCountry == .UAE {
                imageView.image = UIImage(named: "icon_country_uae_flag_square")
            }else if objShareManager.selectedCountry == .INDIA{
                imageView.image = UIImage(named: "icon_country_india_flag_square")
            }
            
            
            imageView.contentMode = .center
            view.addSubview(imageView)
          
            self.phoneCodeLabel = UILabel(frame: CGRect(x: 34, y: 0, width: 35, height: width))
            self.phoneCodeLabel?.font = AppFonts.Regular.size(size: 14)
            
            
            if objShareManager.selectedCountry == .UAE {
                self.phoneCodeLabel?.text = "+971"
                self.maxLength = 9
                self.phoneCountryCode = "AE"
            }else if objShareManager.selectedCountry == .INDIA{
                self.phoneCodeLabel?.text = "+91"
                self.maxLength = 10
                self.phoneCountryCode = "IN"
            }
            
            view.addSubview(self.phoneCodeLabel!)
        
            self.textField.leftViewMode = UITextField.ViewMode.always
            self.textField.leftView = view
            
            break
        case .Mobile:
            self.textField.keyboardType = .numberPad
            self.textField.textContentType = .telephoneNumber
            let width = self.textField.bounds.height
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: width))
            view.backgroundColor = .clear
          
            self.phoneCodeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 35, height: width))
            self.phoneCodeLabel?.font = AppFonts.Regular.size(size: 14)

            if objShareManager.selectedCountry == .UAE {
                self.phoneCodeLabel?.text = "+971"
                self.maxLength = 9
                self.phoneCountryCode = "AE"
            }else if objShareManager.selectedCountry == .INDIA{
                self.phoneCodeLabel?.text = "+91"
                self.maxLength = 10
                self.phoneCountryCode = "IN"
            }
            
            
            view.addSubview(self.phoneCodeLabel!)
        
            self.textField.leftViewMode = UITextField.ViewMode.always
            self.textField.leftView = view
          //  self.maxLength = 9
            break
        case .PhoneCode:
            self.textField.keyboardType = .numberPad
            self.textField.textContentType = .telephoneNumber
            let width = self.textField.bounds.height
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: width))
            view.backgroundColor = .clear
          
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: width))
           
            imageView.image = UIImage(named: "icon_arrow_down_black")
            imageView.contentMode = .center
          //  view.addSubview(imageView)
          
            self.phoneCodeLabel = UILabel() //frame: CGRect(x: 34, y: 0, width: 35, height: width))
            self.phoneCodeLabel?.font = AppFonts.Regular.size(size: 14)
           
            if objShareManager.selectedCountry == .UAE {
                self.phoneCodeLabel?.text = "+971 ▼"
                self.maxLength = 9
                self.phoneCountryCode = "AE"
            }else if objShareManager.selectedCountry == .INDIA{
                self.phoneCodeLabel?.text = "+91 ▼"
                self.maxLength = 10
                self.phoneCountryCode = "IN"
            }
            
         //   view.addSubview(label)
            let stackView = UIStackView(arrangedSubviews: [self.phoneCodeLabel!])
            stackView.frame = view.bounds
            stackView.axis = .horizontal
            stackView.spacing = 3
            view.addSubview(stackView)
            
//            stackView.translatesAutoresizingMaskIntoConstraints = false
//           
//            stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
//            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 14).isActive = true
//            stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
//            
            
            let dropButton = UIButton(frame: view.bounds)
            dropButton.addTarget(self, action: #selector(phoneCodeDropDownButtonClick), for: .touchUpInside)
            dropButton.backgroundColor = .clear
            view.addSubview(dropButton)
            
//            dropButton.translatesAutoresizingMaskIntoConstraints = false
//           
//            dropButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
//            dropButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//            dropButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 14).isActive = true
//            dropButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
//            
            
            self.textField.leftViewMode = UITextField.ViewMode.always
            self.textField.leftView = view
          //  self.maxLength = 9
            break
        case .Landline:
            self.textField.keyboardType = .numberPad
            self.textField.textContentType = .telephoneNumber
            self.maxLength = 10
            break
        case .Calendar:
           
            self.textField.keyboardType = .default
            
            self.textField.leftViewMode = UITextField.ViewMode.always
//            self.textField.clearButtonMode = .unlessEditing
            let width = self.textField.bounds.height
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: width))
          
            let imageView = UIImageView(frame: view.bounds)
            imageView.image = UIImage(named: "icon_textfield_calendar")
            imageView.contentMode = .center
            view.addSubview(imageView)
            view.backgroundColor = .clear
            self.textField.leftView = view
            
            self.textField.isUserInteractionEnabled = false
            
            let dropButton = UIButton()// UIButton(frame:self.textField.bounds)
            dropButton.addTarget(self, action: #selector(calendarButtonClick), for: .touchUpInside)
            dropButton.backgroundColor = .clear //green.withAlphaComponent(0.1)
          //  self.addSubview(dropButton)
            clearCalendarTextButton.isHidden = true
            clearCalendarTextButton.translatesAutoresizingMaskIntoConstraints = false
            clearCalendarTextButton.widthAnchor.constraint(equalToConstant: 42).isActive = true
            
            let stackView = UIStackView(arrangedSubviews: [dropButton, clearCalendarTextButton])
            stackView.axis = .horizontal
            stackView.distribution = .fillProportionally
            stackView.spacing = 5
            self.addSubview(stackView)
          
            stackView.translatesAutoresizingMaskIntoConstraints = false
           
         //   dropButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 14).isActive = true
         //   dropButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -50).isActive = true
            
            
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            stackView.backgroundColor = .clear // .withAlphaComponent(0.1)
            
            
//            let dropButton = UIButton(frame: CGRect(x: 0, y: 6, width: self.textField.bounds.width, height: self.textField.bounds.height))
          
            
          //  stackView.addArrangedSubview(dropButton)
            
            
            break
        case .Time:
           
            self.textField.keyboardType = .default
            
            self.textField.leftViewMode = UITextField.ViewMode.always
            
            self.textField.isUserInteractionEnabled = false
            
            let dropButton = UIButton(frame: CGRect(x: 0, y: 6, width: self.textField.bounds.width, height: self.textField.bounds.height))
            dropButton.addTarget(self, action: #selector(timeButtonClick), for: .touchUpInside)
            dropButton.backgroundColor = .clear
            self.addSubview(dropButton)
            
            /*
            clearCalendarTextButton.isHidden = true
            clearCalendarTextButton.translatesAutoresizingMaskIntoConstraints = false
            clearCalendarTextButton.widthAnchor.constraint(equalToConstant: 42).isActive = true
            self.addSubview(clearCalendarTextButton)
            
         //   dropButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    //        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            clearCalendarTextButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            clearCalendarTextButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
         //   dropButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -50).isActive = true
            
            
            clearCalendarTextButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            */
            
            break
        case .Name:
           
            self.textField.keyboardType = .default
            break
        case .NameAndDot:
           
            self.textField.keyboardType = .default
            break
        case .Alphanumber:
            self.textField.keyboardType = .default
            break
            
        case .Zipcode:
            self.textField.keyboardType = .numberPad
            self.textField.leftViewMode = .never
            break
        case .Symbol:
            self.textField.leftViewMode = .never
            self.textField.keyboardType = .default
            break
        case .Symbol_2:
            self.textField.leftViewMode = .never
            self.textField.keyboardType = .default
            break
        case .UppercaseNumber:
            self.textField.leftViewMode = .never
            self.textField.keyboardType = .default
            self.textField.autocapitalizationType = .allCharacters
            break
        case .Custom:
            self.textField.leftViewMode = .never
            self.textField.keyboardType = .default
            break
        case .CustomCharachter:
            self.textField.leftViewMode = .never
            self.textField.keyboardType = .default
            break
        }
        
    }
    @objc func timeButtonClick(_ sender: UIButton) {
        DispatchQueue.main.async {
            if let calPopupVC = TimePickerViewController.storyboardInstance() {
                calPopupVC.modalPresentationStyle = .overCurrentContext
                
                calPopupVC.completionBlock = { selectedTime in
                    
                    DispatchQueue.main.async {
                        self.textField.text = selectedTime
                      //  self.selectedDate = selectedDate
                        self.showFloatingTitle()
                        if self.delegate != nil {
                            self.delegate?.textChange(textView: self)
                            
                          //  if selectedTime.count != 0 {
                                self.delegate?.timeSelected(textView: self)
                           // }
                        }
                        /*
                        if self.isShowDateClearButton {
                            self.clearCalendarTextButton.isHidden = false
                        }else{
                            self.clearCalendarTextButton.isHidden = true
                        }
                        */
                    }
                }
             //   let appDelegate = UIApplication.shared.delegate as! AppDelegate
                UIApplication.shared.keyWindow?.rootViewController!.present(calPopupVC, animated: false)
            }
        }
    }
    @objc func calendarButtonClick(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            if let calPopupVC = CalendarPopupViewController.storyboardInstance() {
                calPopupVC.modalPresentationStyle = .overCurrentContext
                
                if self.selectedDate != nil {
                    calPopupVC.selectedDate = self.selectedDate!
                }else{
                    calPopupVC.selectedDate = Date()
                }
                
                if self.minimumDate != nil {
                    calPopupVC.minimumDate = self.minimumDate
                }
                if self.maximumDate != nil {
                    calPopupVC.maximumDate = self.maximumDate
                }
                
                calPopupVC.completionBlock = { selectedDate in
                    
                    DispatchQueue.main.async {
                        self.textField.text = selectedDate.formate(format: "dd, MMMM, yyyy")
                        self.selectedDate = selectedDate
                        self.showFloatingTitle()
                        if self.delegate != nil {
                            self.delegate?.textChange(textView: self)
                        }
                        if self.isShowDateClearButton {
                            self.clearCalendarTextButton.isHidden = false
                        }else{
                            self.clearCalendarTextButton.isHidden = true
                        }
                    }
                }
             //   let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let window = UIApplication.shared.keyWindow! //appDelegate.window //UIApplication.shared.keyWindow!
                if let modalVC = window.rootViewController?.presentedViewController {
                    modalVC.present(calPopupVC, animated: false, completion: nil)
                } else {
                    window.rootViewController!.present(calPopupVC, animated: false, completion: nil)
                }
                
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.window?.rootViewController!.present(calPopupVC, animated: false)
                
            }
        }
    }

    // MARK: - Show Title
    public func showFloatingTitle() {
        self.titleView.isHidden = false
    }
    public func hideFloatingTitle() {
        self.titleView.isHidden = true
    }

    // MARK: - Eye Button Click
    @objc func eyeButtonClick(_ sender: UIButton) {
        self.textField.isSecureTextEntry = sender.isSelected
        sender.isSelected = !sender.isSelected
    }
    
    // MARK: - Eye Button Click
    @objc func dropDownButtonClick(_ sender: UIButton) {
        if (self.delegate != nil) {
            self.delegate?.dropDownClick(textView: self)
        }
    }
    @objc func phoneCodeDropDownButtonClick(_ sender: UIButton) {
        if let picker = PhoneCodePickerViewController.storyboardInstance()
        {
            picker.selectedString = self.phoneCodeLabel?.text?.replacingOccurrences(of: " ▼", with: "") ?? ""
            picker.completionBlock = { selectedCode in
                self.phoneCodeLabel!.text = "+" + (selectedCode.phoneCode ?? "") + " ▼"
                self.maxLength = selectedCode.maxLength ?? 0
                self.phoneCountryCode = selectedCode.countryCode ?? ""
            }
            let nav = UINavigationController(rootViewController: picker)
            nav.modalPresentationStyle = .fullScreen
            
        //    let appDelegate = UIApplication.shared.delegate // as! AppDelegate
            let window = UIApplication.shared.keyWindow!
            if let modalVC = window.rootViewController?.presentedViewController {
                modalVC.present(nav, animated: true, completion: nil)
            } else {
                window.rootViewController!.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    
    
    // MARK: - Info Button Click
    @IBAction func infoButtonClick(_ sender: UIButton) {
        if sender.isSelected {
            if tooltip != nil {
                tooltip!.dismiss(remove: false)
                tooltip = nil
            }
        }else{
            
            self.tooltip = ZGTooltipView(direction: .topLeft, text: self.tooltipText ?? "", originView: sender, removeOnDismiss: false)
            tooltip!.displayTooltip()
            sender.isSelected = true
        }
    }
    
    
    //MARK: - Initializer
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
         commoninit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
         commoninit()
    }
    private func commoninit(){
      //  Bundle(identifier: "org.cocoapods.SKFloatingTextField")?.loadNibNamed("SKFloatingTextField", owner: self, options: nil)
        let nib = UINib(nibName: "SKFloatingTextField", bundle: .module)
        contentView =  (nib.instantiate(withOwner: self, options: nil).first as! UIView)
//        addSubview(contentView)
        contentView.backgroundColor = .clear
        insertSubview(contentView, at: 0)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    
      //  self.titleLabel.isHidden = true
        self.titleLabel.textAlignment = .left
        self.titleLabel.font = AppFonts.Regular.size(size: 12)
        self.titleLabel.textColor = .grayTextColor
        
        self.textField.font = AppFonts.Regular.size(size: 14)
        self.borderView.layer.cornerRadius = self.corner_radius
        self.borderView.layer.borderColor = self.border_color.cgColor
        self.borderView.layer.borderWidth = self.border_width
        self.borderView.layer.masksToBounds = true
        
        self.textField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        self.textField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        self.textField.addTarget(self, action: #selector(textFieldDidChangeSelection), for: .editingChanged)
       
        self.textField.tintColor = .black
        self.textField.delegate = self
        self.hideFloatingTitle()
        
        self.textField.spellCheckingType = .no
        self.textField.autocorrectionType = .no
        self.backgroundColor = .clear
    }

    func getTextFieldType(type:String) -> TextFieldType {
        if type == "ALPHANUMERIC" {
            return .Alphanumber
        }else if type == "NUMERIC" {
            return .Number
        }
        return .Default
    }
    
}
extension PekoFloatingTextFieldView {
    @objc fileprivate func textFieldDidEndEditing() {
        if self.textField.text == "" {
            self.textField.placeholder = self.placeholder.localizeString()
            self.hideFloatingTitle()
        } 
//        else if self.isValidInput {
//            self.errorLabelText = ""
//        }
        
      //  self.borderView.layer.borderColor = self.borderColor?.cgColor
        //self.delegate?.textFieldDidEndEditing?(textField: self)
    }
    @objc fileprivate func textFieldDidBeginEditing() {
        self.showFloatingTitle()
        self.textField.placeholder = ""
      //  self.borderView.layer.borderColor = self.active_color.cgColor
       // }
      //  self.delegate?.textFieldDidBeginEditing?(textField: self)
    }
    @objc fileprivate func textFieldDidChangeSelection() {
        
        if self.textField.text == "" {
            self.textField.placeholder = self.placeholder.localizeString()
            self.hideFloatingTitle()
        }else{
            self.showFloatingTitle()
            self.textField.placeholder = ""
        }
      
        if self.delegate != nil {
            self.delegate?.textChange(textView: self)
        }
    }
}
extension PekoFloatingTextFieldView:UITextFieldDelegate{
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
       
        if string.isEmoji { //string.containsEmoji() {
            return false
        }
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        
        
        
        if self.textFieldType != .Decimal {
            if self.maxLength != 0 {
                if newString.count > self.maxLength {
                    return false
                }
            }
        }
        
        if self.textFieldType == .Phone || self.textFieldType == .Mobile || self.textFieldType == .PhoneCode{
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
//            if string == "0" && textField.text?.count == 0 {
//                return false
//            }
            return textField.numberValidation(number: string)
        }else if self.textFieldType == .Decimal {
            
            if string == "." && textField.text?.count == 0 {
                return false
            }
            
            if currentString.contains(".") {
                let arr = currentString.components(separatedBy: ".")
                if arr[1].count == 2 {
                    return false
                }
                if self.maxLength != 0 {
                    if arr[0].count > self.maxLength {
                        return false
                    }
                }
            }else{
                if self.maxLength != 0 {
                    if newString.count > self.maxLength {
                        return false
                    }
                }
            }
            return textField.decimalNumberValidation(number: string)
        }else if self.textFieldType == .Username || self.textFieldType == .Password {
            if string == " " {
                return false
            }
        }else if self.textFieldType == .Name {
            return textField.alphaValidation(string: string)
        }else if self.textFieldType == .NameAndDot {
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
            return textField.customRegexValidation(string: string, customRegex: self.customRegEx)
        }else if self.textFieldType == .CustomCharachter {
            return textField.customCharacterValidation(string: string, customRegex: self.customRegEx)
        }
        
        return true
    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(paste(_:)) && !self.isAllowPaste {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}

