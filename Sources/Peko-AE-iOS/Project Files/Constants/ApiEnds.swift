//
//  ApiEnds.swift
//  SMAT
//
//  Created by Hardik Makwana on 06/10/22.
//

import UIKit

@MainActor
class ApiEnd {
    
    //  static let BASE_URL =  "https://uatae.peko.one/" // stagging
    
    var BASE_URL:String {
        
        if objShareManager.appTarget == .PEKO_LIVE {
            return "https://aeapi.peko.one/"
        }else if objShareManager.appTarget == .PEKO_TEST {
             // "https://sitae.peko.one/"
            if objShareManager.selectedCountry == .UAE {
                return "https://api-gateway.orangeocean-fa607906.uaenorth.azurecontainerapps.io/"
            }else if objShareManager.selectedCountry == .INDIA {
                return "https://api-gateway-t6c4hufy5a-el.a.run.app/"
            }
        //    public static final String INDIA_PROD_BASEURL = ;
            
        }
//        else if objShareManager.appTarget == .PekoIndia {
//            return "https://in.peko.one/"
//            //            if is_live {
//            //                return "https://in.peko.one/"
//            //            }else{
//            //                return "https://api-gateway.greencliff-35dd2bc5.centralindia.azurecontainerapps.io/" //"https://in.peko.one/"
//            //            }
//        }
        return ""
    }
    var WEB_URL:String {
        if objShareManager.appTarget == .PEKO_LIVE {
            return "https://uae.peko.one"
        }else if objShareManager.appTarget == .PEKO_TEST {
            return "https://uatae.pekoapp.com"
        }
//        else if objShareManager.appTarget == .PekoIndia {
//            return ""
//        }
        return ""
    }
    
    
    //    static let BASE_URL =  "https://uae.peko.one/"
    
    var LOGIN_URL:String {
        get{
            return "api/v1/user/login"
        }
    }
    var REFRESH_TOKEN_URL:String {
        get{
            return "api/v1/user/refresh-token"
        }
    }
    
    var LOGOUT_URL:String {
        get{
            return "api/v1/user/logout"
        }
    }
    var REGISTER_VALIDATE_USER_URL:String {
        get{
            return "api/v1/user/validate"
        }
    }
    var REGISTER_URL:String {
        get{
            return "api/v1/user/signUp"
            //            if objShareManager.appTarget == .PEKO_LIVE {
            //                return "api/v1/user/signUp"
            //            }else{
            //                return "api/v1/signUp"
            //            }
        }
    }// =  ""
    
    var FORGOT_PASSWORD_URL:String {
        get{
            return "api/v1/user/forgotPassword"
            //            if objShareManager.appTarget == .PEKO_LIVE {
            //                return "api/v1/user/forgotPassword"
            //            }else{
            //                return "api/v1/forgotPassword"
            //            }
        }
    }
    var REGISTER_OTP_URL:String {
        get{
            return "api/v1/user/otp"
            //            if objShareManager.appTarget == .PEKO_LIVE {
            //                return "api/v1/user/otp"
            //            }else{
            //                return "api/v1/otp"
            //            }
        }
    }
    var VERIFY_EMAIL_OTP_URL:String {
        get{
            return "api/v1/user/verify-emailOtp"
            //            if objShareManager.appTarget == .PEKO_LIVE {
            //                return "api/v1/user/verify-emailOtp"
            //            }else{
            //                return "api/v1/otp"
            //            }
        }
    }
    
    
    var BENEFICIARY_OTP_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/beneficiary/otp"
        }
    } // "api/v1/beneficiary/get-otp"
    
    var UPDATE_OTP_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/profile/get-otp-update"
        }
    }
    var BANK_DETAILS_OTP_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/profile/otp-bank-details"
        }
    }
    
    // "api/v1/beneficiary/get-otp"
    
    
    // MARK: - Phone Bills
    // MARK: - DU PREPAID & POSTPAID
    
    var DU_PREPAID_LIMIT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/duTopUp/limits"
        }
    } // "api/v1/duTopUp/limits"
    var DU_PREPAID_BALANCE_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/duTopUp/balance"
        }
    } // "api/v1/duTopUp/balance"
    var DU_PREPAID_PAYMENT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/duTopUp/payment"
        }
    } // "api/v1/duTopUp/payment"
    
    var DU_POSTPAID_LIMIT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/duBill/limits"
        }
    } // "api/v1/duBill/limits"
    var DU_POSTPAID_BALANCE_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/duBill/balance"
        }
    } // "api/v1/duBill/balance"
    var DU_POSTPAID_PAYMENT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/duBill/payment"
        }
    } // "api/v1/duBill/payment"
    
    // MARK: - ETISALAT PREPAID & POSTPAID
    
    var ETISALAT_PREPAID_LIMIT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/etisalatTu/limits"
        }
    }// "api/v1/etisalatTu/limits"
    var ETISALAT_PREPAID_BALANCE_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/etisalatTu/balance"
        }
    }// "api/v1/etisalatTu/balance"
    var ETISALAT_PREPAID_PAYMENT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/etisalatTu/payment"
        }
    }// "api/v1/etisalatTu/payment"
    
    var ETISALAT_POSTPAID_LIMIT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/etisalatBill/limits"
        }
    }// "api/v1/etisalatBill/limits"
    var ETISALAT_POSTPAID_BALANCE_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/etisalatBill/balance"
        }
    }// "api/v1/etisalatBill/balance"
    var ETISALAT_POSTPAID_PAYMENT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/etisalatBill/payment"
        }
    }// "api/v1/etisalatBill/payment"
    
    var GET_BENEFICIARY:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/beneficiary/fetchBeneficiary"
        }
    }// "api/v1/beneficiary/fetchBeneficiary"
    var ADD_BENEFICIARY:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/beneficiary/"
        }
    }// "api/v1/beneficiary/"
    var DELETE_BENEFICIARY:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/beneficiary/"
        }
    }// "api/v1/beneficiary/delete/"
    
    var UPDATE_BENEFICIARY_STATUS_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/beneficiary/updateStatus/"
        }
    }
    
    var INDIA_BILL_PAYMENT_HISTORY_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/bbps/transactionsHistory"
        }
    }
    
    var INDIA_BILL_COMPLAINT_HISTORY_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/bbps/disputes"
        }
    }
    
    var INDIA_BILL_RAISE_COMPLAINT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/bbps/disputes"
        }
    }
    
    
    
    
    var BILL_BULK_PAYMENT_BALANCE_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/bulk-payment/balance/bulk"
        }
    }
    var BILL_BULK_PAYMENT_PAYMENT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/bulk-payment/payment"
        }
    }
    
    // MARK: - Utility Payments
    // MARK: - DU PREPAID & POSTPAID
    
    var FEWA_LIMIT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/fewa/limits"
        }
    }// "api/v1/fewa/limits"
    var FEWA_BALANCE_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/fewa/balance"
        }
    }// "api/v1/fewa/balance"
    var FEWA_PAYMENT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/fewa/payment"
        }
    }// "api/v1/fewa/payment"
    
    var AADC_LIMIT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/aadc/limits"
        }
    }// "api/v1/aadc/limits"
    var AADC_BALANCE_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/aadc/balance"
        }
    }// "api/v1/aadc/balance"
    var AADC_PAYMENT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/aadc/payment"
        }
    }// "api/v1/aadc/payment"
    
    var ADDC_LIMIT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/addc/limits"
        }
    }// "api/v1/addc/limits"
    var ADDC_BALANCE_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/addc/balance"
        }
    }// "api/v1/addc/balance"
    var ADDC_PAYMENT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/addc/payment"
        }
    }// "api/v1/addc/payment"
    
    var AJMAN_SEWERANGE_LIMIT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/ajman/limits"
        }
    }// "api/v1/ajman/limits"
    var AJMAN_SEWERANGE_BALANCE_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/ajman/balance"
        }
    }// "api/v1/ajman/balance"
    var AJMAN_SEWERANGE_PAYMENT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/ajman/payment"
        }
    }// "api/v1/ajman/payment"
    
    var LOOTAH_GAS_LIMIT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/lootah/limits"
        }
    }// "api/v1/lootah/limits"
    var LOOTAH_GAS_BALANCE_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/lootah/balance"
        }
    }// "api/v1/lootah/balance"
    var LOOTAH_GAS_PAYMENT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/lootah/payment"
        }
    }// "api/v1/lootah/payment"
    
    //    static let MAWAQiF_LIMIT_URL = "api/v1/duBill/limits"
    //    static let MAWAQiF_BALANCE_URL = "api/v1/duBill/balance"
    //    static let MAWAQiF_PAYMENT_URL = "api/v1/duBill/payment"
    
    var SALIK_LIMIT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/salik/limits"
        }
    }// "api/v1/salik/limits"
    var SALIK_BALANCE_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/salik/balance"
        }
    }// "api/v1/salik/balance"
    var SALIK_PAYMENT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/salik/payment"
        }
    }// "api/v1/salik/payment"
    
    var NOL_CARD_LIMIT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/nol/limits"
        }
    }// "api/v1/nol/limits"
    var NOL_CARD_BALANCE_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/nol/balance"
        }
    }// "api/v1/nol/balance"
    var NOL_CARD_PAYMENT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/nol/payment"
        }
    }// "api/v1/nol/payment"
    
    var SEWA_LIMIT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/sewa/limits"
        }
    }
    var SEWA_BALANCE_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/sewa/balance"
        }
    }// "api/v1/sewa/balance"
    var SEWA_PAYMENT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/sewa/payment"
        }
    }
    
    var DUBAI_POLICE_LIMIT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/dubaipolice/limits"
        }
    }
    var DUBAI_POLICE_BALANCE_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/dubaipolice/balance"
        }
    }// "api/v1/sewa/balance"
    
    var DUBAI_POLICE_MAPPING_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/dubaipolice/mappings"
        }
    }
    
    var DUBAI_POLICE_PAYMENT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/dubaipolice/payment"
        }
    }
    
    var DARB_LIMIT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/darb/limits"
        }
    }
    var DARB_BALANCE_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/darb/balance"
        }
    }// "api/v1/sewa/balance"
    var DARB_PAYMENT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/darb/payment"
        }
    }
    var HAFILAT_LIMIT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/hafilat/limits"
        }
    }
    var HAFILAT_BALANCE_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/hafilat/balance"
        }
    }// "api/v1/sewa/balance"
    var HAFILAT_PAYMENT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/hafilat/payment"
        }
    }
    
    
    // MARK: -
    // MARK: - License Renewal
    var LICENSE_RENEWAL_LIMIT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/licenseRenewal/limits"
        }
    }
    var LICENSE_RENEWAL_BALANCE_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/licenseRenewal/balance"
        }
    }
    
    
    
    // licenseRenewal/balance?accountNo=20554148&flexiKey=BP49&typeKey=1
    //= "api/v1/licenseRenewal/balance"
    var LICENSE_RENEWAL_PAYMENT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/licenseRenewal/payment"
        }
    }
    var LICENSE_RENEWAL_ORDER_HISTORY_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/licenseRenewal/order-history"
        }
    }
    
    // MARK: - Gift Card
    static let GIFT_CARD_CATEGORIES_URL = "api/v1/giftCards/categories"
    var GIFT_CARD_PRODUCTS_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/giftcards/all"
            //            if objShareManager.appTarget == .PEKO_LIVE {
            //                return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/giftcards/all"
            //            }else{
            //                return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/giftcards/"
            //
            //            }
            //
        }
    }// = "api/v1/giftCards/"
    //  static let GIFT_CARD_PRODUCTS_DETAILS_URL = "api/v1/giftCards/product/"
    var GIFT_CARD_ORDER_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/giftcards/payment"
        }
    }// = "api/v1/giftCards/payment"
    
    var GIFT_CARD_HISTORY_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/giftcards/transactions"
            
        }
    }
    
    
    // MARK: - PEKO STORE
    var PEKO_STORE_CATEGORIES_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/ecommerce/categories"
        }
    }
    var PEKO_STORE_PRODUCTS_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/ecommerce/products"
        }
    }
    var PEKO_STORE_PRODUCTS_DETAILS_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/ecommerce/product/details"
        }
    }
    var PEKO_STORE_GET_CART_DETAILS_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/ecommerce/cartDetails"
        }
    }
    var PEKO_STORE_ADD_TO_CART_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/ecommerce/addToCart"
        }
    }
    var PEKO_STORE_UPDATE_CART_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/ecommerce/"
        }
    }
    
    var PEKO_STORE_DELETE_FROM_CART_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/ecommerce"
        }
    }
    var PEKO_STORE_PAYMENT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/ecommerce/payment"
        }
    }
    
    var PEKO_STORE_HISTORY_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/ecommerce/latestTransactions"
        }
    }
    var PEKO_STORE_HISTORY_DETAIL_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/ecommerce/orderDetails/"
        }
    }
    var PEKO_STORE_CANCEL_ORDER_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/ecommerce/cancelOrder"
        }
    }
    var PEKO_STORE_RETURN_ORDER_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/ecommerce/returnOrder"
        }
    }
    var PEKO_STORE_CANCEL_ORDER_OTP_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/ecommerce/cancelOrder/get-otp"
        }
    }
    
    var PEKO_STORE_DOWNLOAD_PDF_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/ecommerce/download-invoice/"
        }
    }
    // MARK: -
    var PEKO_CONNECT_GET_ALL_URL:String {
        get{
            // if objShareManager.appTarget == .PEKO_LIVE {
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/pekoConnect/providers"
            //            }else{
            //                return "api/v1/subscriptionPayments/getAll"
            //            }
        }
    } // "api/v1/pekoConnect/getAll"
    var PEKO_CONNECT_DETAIL_URL:String {
        get{
            //  if objShareManager.appTarget == .PEKO_LIVE {
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/pekoConnect/details/"
            //            }else{
            //                return "api/v1/subscriptionPayments/getAll"
            //            }
        }
    }
    
    var PEKO_CONNECT_URL:String {
        get{
            //  if objShareManager.appTarget == .PEKO_LIVE {
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/pekoConnect"
            //            }else{
            //                return "api/v1/subscriptionPayments/getAll"
            //            }
        }
    } // "api/v1/pekoConnect"
    
    // MARK: -
    // MARK: - AIR TICKET
    
    var AIR_TICKET_SEARCH_TICKET_URL :String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/flight/searchTicket"
        }
    } // "api/v1/airline/searchTicket"
    
    var AIR_TICKET_BOOK_TICKET_URL :String {
        get{
          //  if objShareManager.selectedCountry == .UAE {
                return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/flight/payment"
//            }else{
//                return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/flight/payment"
//            }
        }
    }
    
    var AIR_TICKET_FARE_RULE_URL :String {
        get{
            if objShareManager.selectedCountry == .UAE {
                return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/flight/fareRules"
            }else{
                return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/flight/fetch_fareRules"
            }
        }
    }
    
    var AIR_TICKET_PROVISIONAL_BOOK_URL :String {
        get{
            // if objShareManager.appTarget == .PEKO_LIVE {
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/flight/provBook"
            //            }else{
            //                return "api/v1/airline/provisionalBook"
            //            }
        }
    }
    var AIR_TICKET_HISTORY_BOOK_URL :String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/flight/list-all-bookings"
        }
    }
    var AIR_TICKET_BOOKING_DETAILS_URL :String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/flight/booking-details"
        }
    }
    var AIR_TICKET_DOWNLOAD_TICKET_URL :String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/flight/download-bookingTicket"
        }
    }
    var AIR_TICKET_CANCEL_TICKET_URL :String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/flight/cancellation-charge"
        }
    }
   
    var AIR_TICKET_ANC_SEARCH_URL :String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/flight/ancSearch"
        }
    }
    
    var AIR_TICKET_ANC_PRO_BOOK_URL :String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/flight/ancProBook"
        }
    }
    
    var AIR_TICKET_CANCEL_BOOKING_OTP_URL :String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/flight/cancel/get-otp"
        }
    }
    var AIR_TICKET_CANCEL_BOOKING_URL :String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/flight/cancel"
        }
    }
    
    
    var AIR_TICKET_AIRPORTS_URL :String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/flight/airports"
        }
    }
    var AIR_TICKET_INDIA_ANC_SEARCH_URL :String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/flight/SSR"
        }
    }
    
    
    // MARK: -
    // MARK: - Invoice Generator
    var INVOICING_DASHBOARD_INFO:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/invoices/dashboard"
        }
    }
    var CORPORATE_DETAILS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/softwares/corporateDetails"
        }
    }
    
    var INVOICING_GET_CUSTOMERS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/invoice-customer"
        }
    }
    
    
    var INVOICING_UPLOAD_INVOICE:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/invoices/upload-invoice"
        }
    }
    
    var CREATE_INVOICE:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/invoices"
        }
    } // = "api/v1/invoices"
    var GET_ALL_INVOICE:String {
        get{
            //            if objShareManager.appTarget == .PEKO_LIVE {
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/invoices/all"
            //            }else{
            //                return "api/v1/invoices/allInvoices"
            //            }
        }
    } // "api/v1/invoices/allInvoices"
    
    var GET_INVOICE_STATUS_UPDATE:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/invoices/"
        }
    }
    
    var GET_INVOICE_GUIDELINES:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/invoice-guideline"
        }
    }
    var GET_INVOICE_TEMPLETE:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/invoice-templete"
        }
    }
    
    var GET_INVOICE_SEND_MAIL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/invoices/sendEmail?invoiceOnly=true"
        }
    }
    
    
    
    var GET_INVOICE_UPDATE_GUIDELINES:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/invoice-guideline/update-guideline"
        }
    }
    
    
    
    var GET_INVOICE_DOWNLOAD:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/invoices/downloadInvoice"
        }
    }
    
    
    // MARK: - Payment Link
    var PAYMENT_LINK_CREATE_LINK_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/payment-links/create-link"
        }
    }
    var PAYMENT_LINK_HISTORY_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/payment-links/all"
        }
    }
    var PAYMENT_LINK_RESEND_LINK_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/payment-links/resend-link"
        }
    }
    
    var KYB_BANK_LIST_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/payment-links/bank-list"
        }
    }
    var KYB_UPLOADED_DOCUMENTS_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/payment-links/uploaded-documents"
        }
    }
    var KYB_CREATE_SUPPLIER_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/payment-links/create-supplier"
        }
    }
    var KYB_UPLOAD_SUPPLIER_DOCUMENT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/payment-links/upload-supplier-documents"
        }
    }
    
    var KYB_GET_AGREEMENT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/payment-links/get-agreement"
        }
    }
    var KYB_SEND_AGREEMENT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/payment-links/send-agreement"
        }
    }
    
    
    
    
    // MARK: - Workspace
    var WORKSPACE_GET_ALL_PLAN:String {
        get{
            // if objShareManager.appTarget == .PEKO_LIVE {
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/workspaces/allPlans"
            //            }else{
            //                return "api/v1/subscriptionPayments/getAll"
            //            }
        }
    } // = "api/v1/workspaces/allPlans"
    var WORKSPACE_GET_ALL_WORKSPACES:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/workspaces/allWorkspaces"
        }
    }
    var WORKSPACE_PAYMENT :String {
        get{
            // if objShareManager.appTarget == .PEKO_LIVE {
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/workspaces/payment"
            //            }else{
            //                return  "api/v1/workspaces/allWorkspaces"
            //            }
        }
    }
    var WORKSPACE_UPLOAD_FILE :String {
        return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/workspaces/fileUpload"
    }
    var WORKSPACE_GET_HISTORY :String {
        return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/workspaces/workspaceHistory"
    }
    
    
    // MARK: - SUBSCRIPTION
    var SUBSCRIPTION_GET_ALL_PRODUCT:String {
        get{
            //            if objShareManager.appTarget == .PEKO_LIVE {
            //                return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/subscriptionPayments/subscriptions"
            //            }else{
            //                return  "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/softwares/subscriptions"
            //            }
            return  "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/softwares/subscriptions"
        }
    }
    var SUBSCRIPTION_GET_ALL_CATEGORIES:String {
        get{
            return  "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/softwares/fetchAllCategories"
        }
    }
    var SUBSCRIPTION_GET_ALL_PLAN:String {
        get{
            //            if objShareManager.appTarget == .PEKO_LIVE {
            //
            //                return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/subscriptionPayments/plans"
            //            }else{
            return  "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/softwares/plans"
            //  }
        }
    }
    var SUBSCRIPTION_GET_PRODUCT_DETAIL:String {
        get{
            //            if objShareManager.appTarget == .PEKO_LIVE {
            //                return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/subscriptionPayments/details"
            //            }else{
            return  "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/softwares/details"
            // }
        }
    }
    var SUBSCRIPTION_GET_ORDER_HISTORY:String {
        get{
            //            if objShareManager.appTarget == .PEKO_LIVE {
            //                return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/subscriptionPayments/allSubscriptions"
            //            }else{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/softwares/allSubscriptions"
            //  }
        }
    }
    var SUBSCRIPTION_PAYMENT:String {
        get{
            //            if objShareManager.appTarget == .PEKO_LIVE {
            //                return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/subscriptionPayments/payment"
            //            }else{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/softwares/payment"
            // }
        }
    }
    
    // MARK: - Logistics
    var LOGISTICS_GET_ALL_COUNTRY:String {
        get{
            //  if objShareManager.appTarget == .PEKO_LIVE {
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/logistics_V3/fetchCountries"
            //            }else{
            //                return "api/v1/logistics/fetchCountry"
            //            }
        }
    } // = "api/v1/logistics/fetchCountry"
    var LOGISTICS_GET_CITIES  :String {
        get{
            //   if objShareManager.appTarget == .PEKO_LIVE {
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/logistics_V3/fetchCities"
            //            }else{
            //                return "api/v1/logistics/fetchCities"
            //            }
        }
    } //= "api/v1/logistics/fetchCities"
    
    var LOGISTICS_GET_SAVED_ADDRESS :String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/logistics_V3/fetchAddresses"
        }
    } // = "api/v1/logistics/fetchAddresses"
    var LOGISTICS_ADD_ADDRESS :String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/logistics_V3/addAddress"
        }
    } // "api/v1/logistics/addAddress"
    
    var LOGISTICS_DELIVERY_FEE:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/logistics_V3/check-delivery-fee"
        }
    }
    
    var LOGISTICS_CALCULATE_RATE:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/logistics/calculateRate"
        }
    } // = "api/v1/logistics/calculateRate"
    
    var LOGISTICS_SERVICE_TYPE:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/logistics/fetch-service-type"
        }
    }
    
    var LOGISTICS_CREATE_SHIPMENT:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/logistics_V3/payment"
          
//            travel/logistics/payment"
        }
    } // = "api/v1/logistics/payment"
    
    var LOGISTICS_HISTORY:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/logistics_V3/orders"
        }
    }
    var LOGISTICS_TRACK_SHIPMENTS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/logistics_V3/track-shipment"
        }
    }
    
    var LOGISTICS_DOWNLOAD_INVOICE:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/logistics_V3/download-invoice"
        }
    }
    var LOGISTICS_CANCEL_ORDER:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/logistics_V3/cancel-shipment"
        }
    }
    
    
    
    var LOGISTICS_CHECK_PINCODE:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/logistics/checkPincode"
        }
    }
    var LOGISTICS_CREATE_MERCHANT:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/logistics/createMerchant"
        }
    }
    
    
    
    
    
    // MARK: - Business Docs
    var BUSINESS_GET_CATEGORIES:String {
        get{
            //  if objShareManager.appTarget == .PEKO_LIVE {
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/edocs/categories"
            //            }else{
            //                return "api/v1/profile/profileDetails/\(objUserSession.user_id)"
            //            }
        }
    } //  "api/v1/docs/categories"
    var BUSINESS_GET_DOCUMENT:String {
        get{
            // if objShareManager.appTarget == .PEKO_LIVE {
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/edocs/documents"
            //            }else{
            //                return "api/v1/profile/profileDetails/\(objUserSession.user_id)"
            //            }
        }
    } //  "api/v1/docs/documents"
    
    
    // MARK: - Hotel Booking
    var HOTEL_BOOKING_SEARCH_UAE_CITIES:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/hotels/cityName"
        }
    }
    var HOTEL_BOOKING_SEARCH_INDIA_CITIES:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/hotels/cities"
        }
    }
    var HOTEL_BOOKING_SEARCH_INDIA_COUNTRY:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/hotels/countries"
        }
    }
    
    
    
    var HOTEL_BOOKING_SEARCH_UAE_HOTELS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/hotels/searchHotels"
        }
    }
    var HOTEL_BOOKING_SEARCH_INDIA_HOTELS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/hotels/hotelSearch"
        }
    }
    
    
    
    var HOTEL_BOOKING_HOTEL_ROOMS_DETAILS:String {
        get{
            // if objShareManager.appTarget == .PEKO_LIVE {
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/hotels/hotelAndRoomDetails"
            //            }else{
            //                return "api/v1/hotels/hotelAndRoomDetails"
            //            }
        }
    }//  = "api/v1/hotels/hotelAndRoomDetails"
    
    var HOTEL_BOOKING_HOTEL_PRE_BOOK:String {
        get{
            // if objShareManager.appTarget == .PEKO_LIVE {
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/hotels/preBook"
            //            }else{
            //                return "api/v1/hotels/preBook"
            //            }
        }
    }
    
    var HOTEL_BOOKING_HOTEL_BOOK:String {
        get{
            if objShareManager.selectedCountry == .UAE {
                return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/hotels/book"
            }else{
                return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment-gateway/wallet-payments/payment"
            }
        }
    }
    
    var HOTEL_BOOKING_HISTORY:String {
        get{
            // if objShareManager.appTarget == .PEKO_LIVE {
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/hotels/list-all-bookings"
            //            }else{
            //                return "api/v1/hotels/list-all-bookings"
            //            }
        }
    }
    var HOTEL_BOOKING_CANCEL_BOOKING_CHANRGES:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/hotels/cancellation-charge"
            //
        }
    }
    var HOTEL_BOOKING_CANCEL_BOOKING_OTP:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/hotels/hotel-cancel/get-otp"
            //
        }
    }
    var HOTEL_BOOKING_CANCEL_BOOKING:String {
        get{
            if objShareManager.selectedCountry == .UAE {
                return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/hotels/hotel-cancel"
            }else{
                return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/hotels/cancelRequest"
            }
        }
    }
    
    var HOTEL_BOOKING_DOWNLOAD_TICKET:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/hotels/download-bookingTicket"
        }
    }
    var HOTEL_BOOKING_UPDATE_STATUS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/hotels/update-status"
        }
    }
    
    static let HOTEL_BOOKING_HOTEL_CANCELLATION_POLICY = "api/v1/hotels/cancellationPolicy"
    
    var INSURANCE_IFRAME_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/insurance/journey-integration-url"
        }
    }
    var INSURANCE_HISTORY_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/insurance/find-all"
        }
    }
    
    var CONNECT_GET_TOKEN_URL:String {
        get{
            return "api/v1/user/chat"
        }
    }
    var CONNECT_GET_REQUEST_URL:String {
        get{
            return "api/v1/user/chat/request"
        }
    }
    
    var CONNECT_GET_ALL_USER_URL:String {
        get{
            return "api/v1/user/chat/corporates"
        }
    }
    var CONNECT_CHAT_UPLOAD_PHOTO_URL:String {
        get{
            return "api/v1/user/chat/upload"
        }
    }
    
    // MARK: - PEKO CLOUD
    
    var PEKO_CLOUD_DASHBOARD_DATA_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/dashboard"
        }
    }
    
    var PEKO_CLOUD_DASHBOARD_STORAGE_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/storage"
        }
    }
    var PEKO_CLOUD_DASHBOARD_TASK_TO_DO_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/task-to-do"
        }
    }
    var PEKO_CLOUD_COMPANY_DOCS_INFO_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/company-docs/info"
        }
    }
    var PEKO_CLOUD_COMPANY_DOCS_LIST_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/company-docs" //all"
        }
    }
    var PEKO_CLOUD_COMPANY_DOCS_ADD_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/company-docs"
        }
    }
    
    
    var PEKO_CLOUD_OWNERS_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/owners"
        }
    }
    var PEKO_CLOUD_OWNERS_DOCUMENT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/document"
        }
    }
    var PEKO_CLOUD_FINANCIAL_INFO_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/financial-docs/info"
        }
    }
    var PEKO_CLOUD_FINANCIAL_ALL_CHEQUE_LEAVES_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/cheque-leaves"
        }
    }
    var PEKO_CLOUD_FINANCIAL_FINANCIAL_DOCS_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/financial-docs"
        }
    }
    
    var PEKO_CLOUD_CHEQUE_BOOKS_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/cheque-books"
        }
    }
    
    var PEKO_CLOUD_EMPLOYEE_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/employees"
        }
    }
    
    var PEKO_CLOUD_SUBSCRIPTIONS_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/subscriptions"
        }
    }
    var PEKO_CLOUD_ALL_SUBSCRIPTIONS_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/softwares/all"
        }
    }
    var PEKO_CLOUD_ALL_EMPLOYEE_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/employees/list"
        }
    }
    
    var PEKO_CLOUD_ASSIGN_SOFTWARE_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/subscriptions/assign"
        }
    }
    
    var PEKO_CLOUD_ASSETS_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/assets"
        }
    }
    var PEKO_CLOUD_ASSIGN_ASSETS_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/assets/assign"
        }
    }
    var PEKO_CLOUD_ASSIGN_ASSETS_USAGE_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/asset-details/usage-history/latest"
        }
    }
    
    var PEKO_CLOUD_ASSETS_USAGE_HISTORY_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/asset-details/usage-history"
        }
    }
    var PEKO_CLOUD_ASSETS_DOCUMENTS_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/asset-details/docs"
        }
    }
    
    
    
    
    
    var PEKO_CLOUD_FLEET_MANAGEMENT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/fleets"
        }
    }
    var PEKO_CLOUD_FLEET_ASSIGN_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/fleets/assign"
        }
    }
    var PEKO_CLOUD_FLEET_ASSIGN_USAGE_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/fleet-details/usage-history/latest"
        }
    }
    var PEKO_CLOUD_FLEET_USAGE_HISTORY_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/fleet-details/usage-history"
        }
    }
    
    var PEKO_CLOUD_FLEET_DOCUMENTS_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/fleet-details/docs"
        }
    }
    
    var PEKO_CLOUD_FLEET_MAINTENANCES_LIST_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/peko-cloud/fleet-details/maintenances"
        }
    }
    
    var PEKO_CLOUD_SUBSCRIPTION_URL:String {
        get{
            return "api/v1/user/subscription/history?accessCode=peko_cloud"
        }
    }
    var PEKO_CLOUD_ADD_ONS_URL:String {
        get{
            return "api/v1/user/subscription/add-ons?accessKey=pekoCloud"
        }
    }
    
    
    var BUSINESS_EMAILS_SOFTWARE_SUBSCRIPTIONS_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/software-subscriptions"
        }
    }
    
    var BUSINESS_EMAILS_HISTORY_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/software-subscriptions/transactions"
        }
    }
    var BUSINESS_EMAILS_MANAGE_SUBSCRIPTION_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/software-subscriptions/manage-subscription"
        }
    }
    
    var BUSINESS_EMAILS_PAYMENT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/software-subscriptions/payment"
        }
    }
    
    var ESIGN_COUNT_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/e-sign/count"
        }
    }
    
    var ESIGN_ADD_ONS_URL:String {
        get{
            return "api/v1/user/subscription/add-ons"
        }
    }
    var ESIGN_HISTORY_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/e-sign/find-all"
        }
    }
    var ESIGN_HISTORY_DETAILS_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/e-sign/find"
        }
    }
    
    var ESIGN_SUBSCrIPTION_HISTORY_URL:String {
        get{
            return "api/v1/user/subscription/history"
        }
    }
    
    
    var ESIGN_SEND_REQUEST_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/e-sign/sign-request"
        }
    }
    
    var ESIGN_RESEND_REQUEST_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/e-sign/resend-invitation"
        }
    }
  
  
    // MARK: - UPGRADE
    var UPGRADE_SERVICE_ACCESS:String {
        get{
            return "api/v1/user/services/serviceAccess"
        }
    }
    var UPGRADE_LIST_PACKAGE:String {
        get{
            return "api/v1/user/subscription/list-packages"
        }
    }
    
    var SUBSCRIPTION_INDIVIDUAL_DETAILS:String {
        get{
            return "api/v1/user/subscription/individual-details"
        }
    }
    var NOTIFY_ADMIN_DETAILS:String {
        get{
            return "api/v1/user/sub-corporate/send-notification"
        }
    }
 
    
    // MARK: - PROFILE
    var GET_PROFILE_DETAILS:String {
        get{
            //  if objShareManager.appTarget == .PEKO_LIVE {
            //  return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/profile/profileDetails"
            //}else{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/profile/profileDetails"
            
            //w"api/v1/profile/profileDetails/\(objUserSession.user_id)"
            //            }
        }
    }
    var GET_SUB_CORPORATE_PROFILE_DETAILS:String {
        get{
            return "api/v1/user/sub-corporate/profile"
        }
    }
    var GET_SUB_CORPORATE_USER_LIST:String {
        get{
            return "api/v1/user/sub-corporate/list"
        }
    }
    var GET_SUB_CORPORATE_RESEND_INVITATION:String {
        get{
            return "api/v1/user/sub-corporate/resend/"
        }
    }
    var GET_SUB_CORPORATE_DELETE:String {
        get{
            return "api/v1/user/sub-corporate/"
        }
    }
    
    var GET_SUB_CORPORATE_INITIAL_SERVICES = "/api/v1/user/sub-corporate/initial-services"
    
    
    var GET_PROFILE_BASIC_DETAILS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/profile/basic"
        }
    }
    
    var GET_PROFILE_ADVANCE_DETAILS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/profile/advance"
        }
    }
    var GET_COMPANY_DETAILS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/profile/company"
        }
    }
    
    var GET_PROFILE_WALLET_DETAILS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/profile/walletDetails"
            
        }
    }
    var GET_PROFILE_PROGRESS_DETAILS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/profile/progress"
            
        }
    }
    
    
    var UPDATE_PROFILE_DETAILS:String {
        get{
            // if objShareManager.appTarget == .PEKO_LIVE {
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/profile"
            //            }else{
            //                return "api/v1/profile/\(objUserSession.user_id)"
            //            }
        }
    }
    
    var DELETE_ACCOUNT:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/profile/deactivate-account"
            // return "api/v1/profile/deleteAccount/\(objUserSession.user_id)"
        }
    }
    var REFER_MAIL_URL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/profile/refer"
            // return "api/v1/profile/deleteAccount/\(objUserSession.user_id)"
        }
    }
    
    var GET_INDIAN_STATES_URL:String {
        get{
            return "api/v1/user/general/indian-states"
        }
    }
    
    
    var CHANGE_PASSWORD:String {
        get{
            //   if objShareManager.appTarget == .PEKO_LIVE {
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/profile/changePassword"
            //            }else{
            //                return "api/v1/profile/changePassword/change"
            //            }
        }
    }
    var PASSWORD_POLICY:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/password-policy"
        }
    }
    
    
    // MARK: -
    // static let ADD_SUPPORT = "api/v1/support/"
    
    static let GET_FAQ_SUPPORT = "api/v1/user/general/support/faq"
    var GET_TICKETS_LIST:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/support/tickets"
        }
    }
    
    
    var GET_TICKETS_DETAIL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/support/ticketDetials/"
        }
    }
    static let GET_ISSUE_TYPE = "api/v1/user/general/support/issueType"
    static let GET_MODULES = "api/v1/user/general/support/modules"
    
    var ADD_SUPPORT:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/support"
        }
    }
    var SEND_SUPPORT_MSG:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/support/create"
        }
    }
    
    var GET_SUPPORT_CHATS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/support/chats/"
        }
    }
    
    var GET_LATEST_BENEFICIARY:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/beneficiary/latestBeneficiaries"
        }
    }
    
    // MARK: - Saved Cards
    
    var GET_ALL_SAVED_CARDS:String {
        get{
            return "api/v1/user/subscription/all-cards"
        }
    }
    var GET_DELETE_SAVED_CARD:String {
        get{
            return "api/v1/user/subscription/card/"
        }
    }
    
    var CHANGE_DEFAULT_CARD:String {
        get{
            return "api/v1/user/subscription/change-default-card/"
        }
    }
    
    // MARK: - Get Address
    var GET_ADDRESS_LIST:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/profile/addressDetails"
        }
    }
    var SEND_ADDRESS_OTP:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/profile/address-otp"
        }
    }
    
    var ADD_ADDRESS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/profile/address"
        }
    }
    
    var GET_BANKS_LIST:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/profile/bank"
        }
    }
    var ADD_BANK:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/profile/bank"
        }
    }
    var BANK_ACCOUNT_TYPE:String {
        get{
            return "api/v1/user/general/bank/accountType"
        }
    }
    
    
    
    var UPDATE_MFA_Setting:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/profile/mfaSetting"
        }
    }
    
    
    var GET_MERCHANT_BALANCE:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/payoll"
        }
    }
    // MARK: - Dashboard
    
    var GET_DASHBOARD_DETAILS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/dashboard/details"
        }
    }
    // MARK: - Analytcis
    var GET_CHART_DETAILS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/dashboard/chart"
        }
    }
    // MARK: - Analytcis
    
    var GET_TOTAL_DETAILS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/dashboard/total"
        }
    }
    var GET_PEKO_CREDITS_ALL_COUPON_CODES:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/subscription/all-coupon-codes"
        }
    }
    
    
    
    
    var GET_CHART_OPTIONS:String {
        get{
            return "api/v1/user/general/dashboard/chartOptions"
        }
    }
    
    var GET_TRANSACTION:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/transactions/orders"
        }
    }
    var GET_CASHBACK:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/transactions/cashback"
        }
    }
    
    var GET_SUBSCRIPTION_HISTORY:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/transactions/subscriptionOrders"
        }
    }
   
    var GET_SUBSCRIPTION_TRANSACTION_DOWNLOAD:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/transactions/subscriptionOrdersDownload/"
        }
    }
    
    
    var GET_TRANSACTION_CATEGORY:String {
        get{
            return "api/v1/user/general/report/categories"
        }
    }
    
    var GET_SUBSCRIPTION_CATEGORY:String {
        get{
            return "api/v1/user/general/report/subscription"
        }
    }
    
    var GET_TRANSACTION_DOWNLOAD_INVOICE:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/transactions/download/"
        }
    }
    
    var GET_SUBSCRIPTION_EMAILS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/scheduler/reportSetting/getEmails"
        }
    }
    var GET_UPDATE_SUBSCRIPTION_EMAILS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/scheduler/reportSetting/"
        }
    }
  
    
    
    
    //MARK: - Zero Carbon
    
    var GET_CARBON_QUESTIONS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/carbonFootprint/questions"
        }
    }
    var GET_CARBON_DASHBOARD_DETAILS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/carbonFootprint/dashboard"
        }
    }
    var GET_CARBON_ALL_PROJECTS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/carbonFootprint/projects"
        }
    }
    var GET_CARBON_NEUTRALIZE_DETAILS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/carbonFootprint/neutralize/"
        }
    }
    var CARBON_PAYMENT:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/carbonFootprint/payment"
        }
    }
    var CARBON_TRANSACTION_HISTORY:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/carbonFootprint/latestTransactions"
        }
    }
    
    //    var CARBON_CALCULATE:String {
    //        get{
    //            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/carbonFootprint/questions"
    //        }
    //    }
    // MARK: - Payroll
    var GET_PAYROLL_DASHBOARD_PROGRESS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/dashBoard/progress"
        }
    }
    var GET_PAYROLL_HR_SETTING:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/hr-settings/payroll-settings"
        }
    }
    var GET_PAYROLL_HR_SETTING_LEAVE:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/hr-settings/leave-settings"
        }
    }
    var GET_PAYROLL_WPS_SETTINGS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/hr-settings/wps-settings"
        }
    }
    
    
    
    
    var GET_PAYROLL_ALL_EMPLOYEE:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/employee"
        }
    }
    
    var GET_PAYROLL_EMPLOYEES:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/employee/current-employees"
        }
    }
    var GET_PAYROLL_ADD_EMPLOYEES:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/employee/alldata"
        }
    }
    
    
    var GET_PAYROLL_ALL_DEPARTMENT:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/department"
        }
    }
    
    var GET_PAYROLL_DASHBOARD_DETAILS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/dashBoard"
        }
    }
    
    var GET_PAYROLL_DASHBOARD_CHART:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/dashBoard/chart"
        }
    }
    
    var GET_PAYROLL_ALL_LEAVES:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/leave-application/all-leaves"
        }
    }
    var GET_PAYROLL_LEAVES_APPLICATION:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/leave-application"
        }
    }
    
    var GET_PAYROLL_AVAILABLE_LEAVES:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/leave-application/available-leaves/"
        }
    }
    
    var GET_PAYROLL_SALARY_STATEMENT:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/salary/statement"
        }
    }
    var GET_PAYROLL_SALARY_PROFILE:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/salary/profile"
        }
    }
    var GET_PAYROLL_SALARY_SLIPES:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/salary/all-payroll-slips/"
        }
    }
    
    var GET_PAYROLL_CALENDAR_UPCOMING_ACTIVITIES:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/calendarActivities/upcoming"
        }
    }
    
    var GET_PAYROLL_ADD_ANNOUNCEMENT:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/announcement"
        }
    }
    
    var GET_PAYROLL_INCENTIVES:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/incentives/"
        }
    }
    
    var GET_PAYROLL_OVERTIME:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/overtime/"
        }
    }
    var GET_PAYROLL_CALCULATE_OVERTIME_AMOUNT:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/overtime/overtime-amount/"
        }
    }
    
    
    var GET_PAYROLL_BONUS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/bonus/"
        }
    }
    var GET_PAYROLL_CALCULATE_BONUS_AMOUNT:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/bonus/calculation/"
        }
    }
    
    var GET_PAYROLL_LEAVE_TAKEN:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/leave-application/leaves-taken/"
        }
    }
    
    var GET_PAYROLL_REIMBURSEMENT:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/reimbursement/"
        }
    }
    var GET_PAYROLL_DEDUCTION:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/deductions/"
        }
    }
    var GET_PAYROLL_INCREMENT:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/increment/"
        }
    }
    var GET_PAYROLL_INCREMENT_CURRENT_SALARY:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/increment/calculate-basic-salary/"
        }
    }
    
    
    var PAYROLL_CALCULATE_GRATUITY:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/gratuity"
        }
    }
    
    
    
    
    //    var GET_PAYROLL_CALENDAR_UPCOMING_ACTIVITIES:String {
    //        get{
    //            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payroll/calendarActivities/upcoming"
    //        }
    //    }
    
    
    
    //MARK: - NOTIFICATIONS
    
    var GET_ALL_NOTIFICATION:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/notification/all-notifications"
        }
    }
    var GET_NOTIFICATION_COUNT:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/others/notification"
        }
    }
    
    //MARK: - SURCHARGE
    var GET_SURCHARGE:String {
        get{
            
            if objShareManager.selectedCountry == .UAE {
                return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/paymentGateway/surcharge"
            }else{
                return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment-gateway/surcharge"
            }
        }
    }
    
    var APPLY_COUPON:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/coupons"
        }
    }
    
    var GET_PAYMENT_METHOD:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/paymentGateway/payment-methods"
            
        }
    }
    //MARK: - SURCHARGE
    var GET_CREATE_NI_ORDER:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/paymentGateway/ni-payments/create-order-mobile"
        }
    }
    var GET_CREATE_CASHFREE_ORDER:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment-gateway/cashfree-gateway/create-order"
        }
    }
    var GET_CASHFREE_ORDER_DETAILS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment-gateway/cashfree-gateway/complete"
        }
    }
    
    //MARK: - SURCHARGE
    var GET_NI_ORDER_DETAILS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/paymentGateway/ni-payments/create-payment/"
        }
    }
    
    // MARK: - Travel eSIM
    
    var GET_ESIM_COUNTRIES:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/eSIM/countries"
        }
    }
    var GET_ESIM_PLANS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/eSIM/plans"
        }
    }
    var GET_ESIM_PLANS_DETAILS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/eSIM/planDetails"
        }
    }
    var GET_ESIM_CREATE_PAYMENT:String {
        get{
            if objShareManager.selectedCountry == .UAE {
                return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/paymentGateway/wallet-payments/create"
            }else{
                return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment-gateway/wallet-payments/create"
            }
        }
    }
    var GET_ESIM_BULK_PAYMENT_DETAILS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/bulk-payment/bulkPaymentData/"
        }
    }
    
    
    var GET_ESIM_ORDER_HISTORY:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/eSIM/orderPackageList"
        }
    }
    var GET_ESIM_ORDER_HISTORY_DETAILS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/eSIM/getEsimDetails"
        }
    }
    var GET_ESIM_TOP_UP_HISTORY:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/eSIM/topupList"
        }
    }
    var GET_ESIM_QR_CODE:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/eSIM/getQrCode/"
        }
    }
    var GET_ESIM_PLAN_TOPUP:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/purchase/eSIM/planTopUp/"
        }
    }
    
    
    
    // MARK: - eSIM
    //MARK: - SURCHARGE
    var GET_ESIM_COMPATIBLE_DEVICE:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/eSIM/compatibleDevice"
        }
    }
    var GET_ESIM_PACKAGE:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/eSIM/packages"
        }
    }
    var GET_ESIM_PAYMENT:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/eSIM/payment"
        }
    }
    var GET_ESIM_HISTORY:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/eSIM/packageList"
        }
    }
    var GET_ESIM_HISTORY_ORDER_DETAIL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/eSIM/packages/details"
        }
    }
    
    var GET_ESIM_TOPUP_PLAN_DETAIL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/travel/eSIM/topup/plans/"
        }
    }
    
    // MARK: -
    var GET_DOCUMENT_ATTESTATION_COUNTRIES:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/attestation/countries"
        }
    }
    // MARK: -
    var GET_DOCUMENT_ATTESTATION_HISTORY:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/attestation/reports"
        }
    }
    var GET_DOCUMENT_ATTESTATION_CATEGORY_TYPE:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/attestation/categoryType"
        }
    }
    var GET_DOCUMENT_ATTESTATION_FILESAVE:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/attestation/fileSave"
        }
    }
    var GET_DOCUMENT_ATTESTATION_CHECK_PRICE:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/attestation/checkPrice"
        }
    }
    var GET_DOCUMENT_ATTESTATION_PAYMENT:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/officeAndBusiness/attestation/payment"
        }
    }
    
    
    
    // MARK: - Mobile Recharge
    
    //    static let GET_MOBILE_PREPAID_PLANS = "api/v1/prepaid/plans"
    
    static let GET_STATES = "api/v1/user/general/states"
    
    var GET_MOBILE_PREPAID_PLANS:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/prepaid/plans"
        }
    }
    var MOBILE_PREPAID_PAYMENT:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/prepaid/payment"
        }
    }
    
    // static let  = "api/v1/postpaid/fetchBill"
    
    //    static let MOBILE_POSTPAID_PAYMENT = "api/v1/postpaid/payment"
    
    var GET_BBPS_BILLERS_LIST:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/bbps/billers"
        }
    }
    var GET_MOBILE_POSTPAID_BILL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/postpaid/fetchBill"
        }
    }
    var MOBILE_POSTPAID_PAYMENT:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/postpaid/payment"
        }
    }
    
    var GET_UTILITY_BILL:String {
        get{
            return "api/v1/\(objUserSession.role)/\(objUserSession.user_id)/payment/electricity/fetchBill"
        }
    }
    
    
    // MARK: - UTILITY
    //  static let GET_UTILITY_BILL = "api/v1/electricity/fetchBill"
    
    
    
    //    static let GET_ELECTRICITY_BILL = "api/v1/electricity/fetchBill"
    
    
}

