//
//  CommonOTPViewController.swift
//  Peko
//
//  Created by Hardik Makwana on 11/03/24.
//

import UIKit

enum CommonOTPAction {
    case UpdateProfile
    case AddBank
    case UpdateBank
    case OfficeSuppliesCancelOrder
    case HotelBookingCancel
    case AddAddress
    case AirTikect
}


class CommonOTPViewController: UIViewController {

    @IBOutlet weak var titleLabel: PekoLabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var resendLabel: PekoLabel!
    
    @IBOutlet weak var otpView: OTPFieldView!
    @IBOutlet weak var resendOTPButton: UIButton!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
 
    var timer:Timer?
    var totalSecond = 121
   
    //var isEditProfile = false
    var otpAction:CommonOTPAction = .UpdateProfile
    
//    var completionBlock:((_ success: Bool) -> Void)?
//    var profileRequest:ProfileRequest?
//    var bankRequest:AddBankRequest?
//    var addressRequest:AddressRequest?
    
    static func storyboardInstance() -> CommonOTPViewController? {
        return AppStoryboards.Common.instantiateViewController(identifier: "CommonOTPViewController") as? CommonOTPViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailLabel.attributedText = NSMutableAttributedString().color(.darkGray, "OTP has been sent to your registered email address.", font: .regular(size: 12), 3, .center)
            
            // .color(.black, objUserSession.profileDetail?.email ?? "", font: .bold(size: 12), 3, .center)
        
        self.setupOtpView()
        
        self.view.backgroundColor = AppColors.blackThemeColor?.withAlphaComponent(0.8)
     
        self.updateResendLabel()
        /*
        if self.otpAction == .UpdateProfile {
            self.titleLabel.text = "Update Profile Details"
        }else if self.otpAction == .AddBank {
            self.titleLabel.text = "Add Bank Details"
        }else if self.otpAction == .UpdateBank {
            self.titleLabel.text = "Update Bank Details"
        }else if self.otpAction == .OfficeSuppliesCancelOrder {
            self.titleLabel.text = "Cancel Order"
        }else if self.otpAction == .HotelBookingCancel {
            self.titleLabel.text = "Confirmation"
        }else{
            self.titleLabel.text = "Confirmation"
        }
        */
        self.titleLabel.text = "Confirmation"
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.layoutIfNeeded()
        self.animation()
    }
    
    // MARK: - ANIMATION
    func animation(){
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: .curveEaseIn, // curveEaseIn
                       animations: { () -> Void in
            
          //  self.superview?.layoutIfNeeded()
            self.bottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        }, completion: { (finished) -> Void in
            
        })
    }
    
    // MARK: -
    override func viewWillAppear(_ animated: Bool) {
        self.startTimer()
        self.navigationController?.isNavigationBarHidden = true
    }
   // MARK: -
    override func viewWillDisappear(_ animated: Bool) {
        self.invalidateTimer()
    }
    
    
    func startTimer(){
        
        self.resendOTPButton.isHidden = true
        self.resendLabel.isHidden = false
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateResendLabel), userInfo: nil, repeats: true)
    }
    
    func invalidateTimer(){
        if timer != nil {
            timer?.invalidate()
        }
    }
    @objc func updateResendLabel()  {
        totalSecond = totalSecond - 1
        
       // let str = "Resend code in \(self.totalSecond) sec"
        let str = "Time Remaining: " + self.totalSecond.timeString()
        
        self.resendLabel.text = str //attr
        
        if totalSecond == 0 {
            self.invalidateTimer()
            self.resendOTPButton.isHidden = false
            self.resendLabel.isHidden = true
        }
    }
    
    // MARK: - Setup OTP View
    func setupOtpView(){
       
        self.otpView.backgroundColor = .clear
        self.otpView.fieldsCount = 6
        self.otpView.fieldBorderWidth = 1
        self.otpView.defaultBorderColor = UIColor.gray
        self.otpView.filledBorderColor = AppColors.borderThemeColor!
        self.otpView.cursorColor = UIColor.black
        self.otpView.displayType = .roundedCorner
        self.otpView.fieldSize = 45
        self.otpView.separatorSpace = (screenWidth - (45 * 6) - 60) / 5
        self.otpView.shouldAllowIntermediateEditing = false
     //   self.otpView.delegate = self
        self.otpView.secureEntry = true
        self.otpView.initializeUI()
        self.otpView.fieldFont = AppFonts.ExtraBold.size(size: 40)
        
    }
    // MARK: - Resend
    @IBAction func resendButtonClick(_ sender: Any) {
        if self.otpAction == .UpdateProfile {
            self.resendProfileOTP()
        }else if self.otpAction == .AddBank || self.otpAction == .UpdateBank{
            self.resendBankDetailOTP()
        }else if self.otpAction == .OfficeSuppliesCancelOrder {
            self.resendOTPForOfficeSuppliesOrderCancel()
        }else if self.otpAction == .HotelBookingCancel {
            self.resendOTPForHotelBooking()
        }else if self.otpAction == .AddAddress {
            self.resendOTPForAddAddress()
        }else if self.otpAction == .AirTikect {
            self.resendOTPForAirTicket()
        }
    }
    
    // MARK: -
    @IBAction func closeButtonClick(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    // MARK: - Verify
    @IBAction func verifyButtonClick(_ sender: Any) {
        
        let emailOtpString = self.otpView.getEnteredOTP()
       
        if emailOtpString.count != 6 {
            self.showAlert(title: "", message: "Please enter the OTP received on your registered email ID")
            return
        }
        
        if self.otpAction == .UpdateProfile {
            self.updateProfile(otpString: emailOtpString)
        }else if self.otpAction == .AddBank || self.otpAction == .UpdateBank {
            self.addBank(otpString: emailOtpString)
        }else if self.otpAction == .OfficeSuppliesCancelOrder {
            self.officeSuppliesCancelOrder(otpString: emailOtpString)
        }else if self.otpAction == .HotelBookingCancel {
            self.cancelHotelBooking(otp: emailOtpString)
        }else if self.otpAction == .AddAddress {
            self.addAddress(otpString: emailOtpString)
        }else if self.otpAction == .AirTikect {
            self.airTicketCancekBookung(otpString: emailOtpString)
        }
    }
    // MARK: -
    // MARK: - Update profile
    func updateProfile(otpString:String) {
        // HPM
        /*
        HPProgressHUD.show()
        ProfileViewModel().updateProfileDetails(otp:otpString, profileRequest: profileRequest!) { response in
            HPProgressHUD.hide()
            print(response)
            if let status = response.status?.value, status == true {
                DispatchQueue.main.async {
                    if let message = response.message {
                        self.showAlertWithCompletion(title: "", message: (response.message ?? "").capitalized) { action in
                            if self.completionBlock != nil {
                                self.completionBlock!(true)
                            }
                            self.dismiss(animated: false)
                        }
                    }
                }
            }else{
                if let code = response.responseCode, code == "002"{
                    objErrorManager.manageSession(viewController: self) { result in
                        if result {
                            self.updateProfile(otpString: otpString)
                        }
                    }
                }else{
                    var msg = ""
                    if response.message != nil {
                        msg = response.message ?? ""
                    }else if response.error?.count != nil {
                        msg = response.error ?? ""
                    }
                    self.showAlert(title: "", message: msg)
                }
            }
        }
        */
    }
    
    // MARK: - Add/Update Bank
    func addBank(otpString:String) {
        // HPM
        /*
        HPProgressHUD.show()
        
        ProfileViewModel().addUpdateBank(request: self.bankRequest!, otpString: otpString) { response, error in
            HPProgressHUD.hide()
       //     print(response)
            if let status = response?.status?.value, status == true {
                DispatchQueue.main.async {
                    
                    var msg = "Bank Account added successfully"
                  
                    if self.bankRequest?.id != 0 {
                        msg = "Bank Account updated successfully"
                    }
                    
                    self.showAlertWithCompletion(title: "", message: msg) { action in
                        if self.completionBlock != nil {
                            self.completionBlock!(true)
                        }
                        self.dismiss(animated: false)
                    }
                }
            }else{
                let error = ErrorModel(code: response?.responseCode, message: response?.message?.value, error: response?.error?.value, errors: response?.errors?.value)
              
                objErrorManager.manageFailResponse(error: error, viewController: self) { isReload in
                    if isReload {
                        self.addBank(otpString: otpString)
                    }
                }
            }
        }
         */
    }
    
    
    // MARK: -
    func resendProfileOTP(){
        // HPM
        /*
        HPProgressHUD.show()
        OTPViewModel().generateOTPForUpdate { response, error in
            HPProgressHUD.hide()
            if error != nil {
#if DEBUG
                self.showAlert(title: "", message: error?.localizedDescription ?? "")
#else
                self.showAlert(title: "", message: "Something went wrong please try again")
#endif

            }else if let status = response?.status?.value, status == true {
                DispatchQueue.main.async {
                    self.showAlert(title: "", message: response?.message?.value ?? "")
                    
                    self.totalSecond = 121
                    self.updateResendLabel()
                    self.startTimer()
                }
            }else{
                let error = ErrorModel(code: response?.responseCode, message: response?.message?.value, error: response?.error?.value, errors: response?.errors?.value)
              
                objErrorManager.manageFailResponse(error: error, viewController: self) { isReload in
                    if isReload {
                        self.resendProfileOTP()
                    }
                }
            }
        }
         */
    }
    func resendBankDetailOTP(){
        // HPM
        /*
        HPProgressHUD.show()
        OTPViewModel().generateOTPForBankDetail(request: self.bankRequest!) { response, error in
            HPProgressHUD.hide()
            if error != nil {
#if DEBUG
                self.showAlert(title: "", message: error?.localizedDescription ?? "")
#else
                self.showAlert(title: "", message: "Something went wrong please try again")
#endif

            }else if let status = response?.status?.value, status == true {
                DispatchQueue.main.async {
                    self.showAlert(title: "", message: response?.message?.value ?? "")
                    self.totalSecond = 121
                    self.updateResendLabel()
                    self.startTimer()
                }
            }else{
                let error = ErrorModel(code: response?.responseCode, message: response?.message?.value, error: response?.error?.value, errors: response?.errors?.value)
              
                objErrorManager.manageFailResponse(error: error, viewController: self) { isReload in
                    if isReload {
                        self.resendBankDetailOTP()
                    }
                }
            }
        }
         */
    }
    
    // MARK: -
    // MARK: -
    func officeSuppliesCancelOrder(otpString:String){
        // HPM
        /*
        HPProgressHUD.show()
        var request = objPekoStoreManager?.orderCancelRequest
        request?.otp = otpString
        PekoStoreHistoryViewModel().cancelOrder(request: request!) { response, error in
            HPProgressHUD.hide()
            if error != nil {
                
#if DEBUG
                self.showAlert(title: "", message: error?.localizedDescription ?? "")
#else
                self.showAlert(title: "", message: "Something went wrong please try again")
#endif
                
            }else if let status = response?.status?.value, status == true {
                DispatchQueue.main.async {
                    self.showAlertWithCompletion(title: "", message: "Order cancellation request raised successfully.") { action in
                        if self.completionBlock != nil {
                            self.completionBlock!(true)
                        }
                        self.dismiss(animated: false)
                    }
                }
            }else{
                if let code = response?.responseCode, code == "002"{
                    objErrorManager.manageSession(viewController: self) { result in
                        if result {
                            self.officeSuppliesCancelOrder(otpString: otpString)
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
         */
    }
    
    func resendOTPForOfficeSuppliesOrderCancel(){
        // HPM
        /*
        HPProgressHUD.show()
        PekoStoreHistoryViewModel().getOTPForCancelOTP { response, error in
            HPProgressHUD.hide()
            if error != nil {
                
#if DEBUG
                self.showAlert(title: "", message: error?.localizedDescription ?? "")
#else
                self.showAlert(title: "", message: "Something went wrong please try again")
#endif
                
            }else if let status = response?.status?.value, status == true {
                DispatchQueue.main.async {
                    self.showAlert(title: "", message: response?.message ?? "")
                    self.totalSecond = 121
                    self.updateResendLabel()
                    self.startTimer()
                }
            }else{
                if let code = response?.responseCode, code == "002"{
                    objErrorManager.manageSession(viewController: self) { result in
                        if result {
                            self.resendOTPForOfficeSuppliesOrderCancel()
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
         */
    }
    
    // MARK: -
    // MARK: - Hotel Booking Cancel
    func cancelHotelBooking(otp:String){
        // HPM
        /*
        HPProgressHUD.show()
        var bookingReferenceId = ""
        if objShareManager.selectedCountry == .UAE {
             bookingReferenceId = objHotelBookingManager?.bookingHistoryModel?.providerId ?? ""
        }else{
             bookingReferenceId = "\(objHotelBookingManager?.bookingHistoryModel?.id ?? 0)"
        }
        
        
        let conversationId = objHotelBookingManager?.bookingHistoryModel?.orderResponseModel?.meta?.conversationId ?? ""
        let selectedCorporateTxnId = objHotelBookingManager?.bookingHistoryModel?.corporateTxnId ?? ""

        HotelBookingViewModel().cancelBooking(bookingReferenceId: bookingReferenceId, conversationId: conversationId, corporateTxnId: selectedCorporateTxnId, otp: otp, response: { response, error in
            HPProgressHUD.hide()
            print(response)
            
            if error != nil {
#if DEBUG
                self.showAlert(title: "", message: error?.localizedDescription ?? "")
#else
                self.showAlert(title: "", message: "Something went wrong please try again")
#endif

            }else if let status = response?.status?.value, status == true {
                DispatchQueue.main.async {
                    self.showAlertWithCompletion(title: "", message: "Booking Cancelled") { action in
                        
                        self.dismiss(animated: false) {
                            if self.completionBlock != nil {
                                self.completionBlock!(true)
                            }
                        }
                    }
                }
            }else{
                let error = ErrorModel(code: response?.responseCode, message: response?.message, error: response?.error, errors: "")
              
                objErrorManager.manageFailResponse(error: error, viewController: self) { isReload in
                    if isReload {
                        self.cancelHotelBooking(otp: otp)
                    }
                }
            }
        })
         */
    }
    
    func resendOTPForHotelBooking(){
        /*
        HPProgressHUD.show()
        
      
        HotelBookingViewModel().getHotelBookingCancelOTP(){ response, error in
              HPProgressHUD.hide()
            if error != nil {
#if DEBUG
                self.showAlert(title: "", message: error?.localizedDescription ?? "")
#else
                self.showAlert(title: "", message: "Something went wrong please try again")
#endif
                
            }else if let status = response?.status?.value, status == true {
                DispatchQueue.main.async {
                    self.showAlert(title: "", message: response?.message ?? "")
                    self.totalSecond = 121
                    self.updateResendLabel()
                    self.startTimer()
                }
            }else{
                if let code = response?.responseCode, code == "002"{
                    objErrorManager.manageSession(viewController: self) { result in
                        if result {
                            self.resendOTPForHotelBooking()
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
         */
    }
    // MARK: -
    // MARK: - Add Address
    func addAddress(otpString:String) {
        /*
        HPProgressHUD.show()
        
        ProfileViewModel().addAddreess(request: self.addressRequest!, OTP: otpString) { response, error in
            HPProgressHUD.hide()
            if error != nil {
                #if DEBUG
                self.showAlert(title: "", message: error?.localizedDescription ?? "")
#else
                self.showAlert(title: "", message: "Something went wrong please try again")
#endif

            }else if let status = response?.status?.value, status == true {
                DispatchQueue.main.async {
                    
                    var msg = "Address added successfully"
                  
                    if self.addressRequest?.id != 0 {
                        msg = "Address updated successfully"
                    }
                    self.showAlertWithCompletion(title: "", message: msg) { action in
                        self.dismiss(animated: false) {
                            if self.completionBlock != nil {
                                self.completionBlock!(true)
                            }
                        }
                    }
                }
            }else{
                let error = ErrorModel(code: response?.responseCode, message: response?.message?.value, error: response?.error?.value, errors: response?.errors?.value)
              
                objErrorManager.manageFailResponse(error: error, viewController: self) { isReload in
                    if isReload {
                        self.addAddress(otpString: otpString)
                    }
                }
            }
        }
         */
    }
    func resendOTPForAddAddress() {
        /*
        HPProgressHUD.show()
        
        ProfileViewModel().sendOTP(request: self.addressRequest!) { response, error in
            HPProgressHUD.hide()
            if error != nil {
                #if DEBUG
                self.showAlert(title: "", message: error?.localizedDescription ?? "")
#else
                self.showAlert(title: "", message: "Something went wrong please try again")
#endif

            }else if let status = response.status?.value, status == true {
                DispatchQueue.main.async {
                    self.showAlert(title: "", message: response.message ?? "")
                    self.totalSecond = 121
                    self.updateResendLabel()
                    self.startTimer()
                }
            }else{
                var msg = ""
                if response.message != nil {
                    msg = response.message
                    ?? ""
                }else if response.error?.count != nil {
                    msg = response.error ?? ""
                }
                self.showAlert(title: "", message: msg)
            }
        }
         */
    }
    
    // MARK: -
    // MARK: - Air Ticket
    func airTicketCancekBookung(otpString:String) {
      /*
        HPProgressHUD.show()
        AirTicketViewModel().cancelBooking(otp: otpString) { response, error in
            HPProgressHUD.hide()
            if error != nil {
                #if DEBUG
                self.showAlert(title: "", message: error?.localizedDescription ?? "")
#else
                self.showAlert(title: "", message: "Something went wrong please try again")
#endif

            }else if let status = response?.status?.value, status == true {
                DispatchQueue.main.async {
                    
                   
                    self.showAlertWithCompletion(title: "", message: (response?.message ?? "").capitalized) { action in
                        
                        self.dismiss(animated: false) {
                            if self.completionBlock != nil {
                                self.completionBlock!(true)
                            }
                        }
                    }
                }
            }else{
                var msg = ""
                if response?.message != nil {
                    msg = response?.message
                    ?? ""
                }else if response?.error?.count != nil {
                    msg = response?.error ?? ""
                }
                self.showAlert(title: "", message: msg)
            }
        }
       */
    }
    func resendOTPForAirTicket() {
        /*
        HPProgressHUD.show()
        AirTicketViewModel().sendOTPForBookingCancellation(o_id: 0) { response, error in
            HPProgressHUD.hide()
            if error != nil {
                #if DEBUG
                self.showAlert(title: "", message: error?.localizedDescription ?? "")
#else
                self.showAlert(title: "", message: "Something went wrong please try again")
#endif

            }else if let status = response.status?.value, status == true {
                DispatchQueue.main.async {
                    self.showAlert(title: "", message: response.message ?? "")
                    self.totalSecond = 121
                    self.updateResendLabel()
                    self.startTimer()
                }
            }else{
                var msg = ""
                if response.message != nil {
                    msg = response.message
                    ?? ""
                }else if response.error?.count != nil {
                    msg = response.error ?? ""
                }
                self.showAlert(title: "", message: msg)
            }
        }
         */
    }
}
// HPM
/*
extension CommonOTPViewController: OTPFieldViewDelegate {
    func enteredOTP(otp otpString: String) {
     //   self.otpString = otpString
     //   self.verifyPinRequest(str:otpString)
        print("OTPString: \(otpString)")
      
    }
    
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
    //    hasEnteredOTP = hasEntered
       // self.errorLabel.isHidden = true
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
}
*/
