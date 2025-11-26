//
//  ServiceAccessManager.swift
//  Peko
//
//  Created by Hardik Makwana on 03/03/25.
//

import UIKit

//let objServiceAccessManager = ServiceAccessManager.sharedInstance

class PekoPaymentServiceModel:NSObject {
    let title:String
    let icon:String
    let access_key:String
    let serviceAccessKey:String
    let index:Int
    
    init(title: String, icon: String, access_key: String, serviceAccessKey: String, index: Int) {
        self.title = title
        self.icon = icon
        self.index = index
        self.access_key = access_key
        self.serviceAccessKey = serviceAccessKey
    }
}


@MainActor
public let objServiceAccessManager = ServiceAccessManager.sharedInstance


public class ServiceAccessManager: NSObject {

    @MainActor static let sharedInstance = ServiceAccessManager()
    
    var isHasAccessDashboard = false
    var isHasAccessHelpNeed = false
    var isHasAccessContactUs = false
    var isHasAccessTickets = false
   
    var isHasAccessSettings = false
    var isHasAccessSecurity = false
    var isHasAccessUserManagement = false
    var isHasAccessSavedCards = false
    
    
    var isHasAccessReports = false
    var isHasAccessTransaction = false
    var isHasAccessCashback = false
    var isHasAccessSchedulingReports = false
    var isHasAccessSubscriptionTransactions = false
  
    var serviceListArray = [UpgradeServiceAccessDataModel]()
    
    let servicesAccesskeyArray = ["ecommerce", "subscription_payments", "shipment_services", "travelApi_airline", "hotels_api", "youGotAGift", "peko_payroll", "document_attestation", "dubai_ded", "pekoCloud", "esim", "quick_links", "email_domain_service", "edocs", "marketplace", "signDesk_eSign", "tbo_airline"]
    
    let allPaymentServicesDictionary = [
        "Bill Payments":PekoPaymentServiceModel(title: "Bill Payments", icon: "icon_bills", access_key: "", serviceAccessKey: "", index: 0),
        "Office Supplies":PekoPaymentServiceModel(title: "Office Supplies", icon: "icon_office_supplies", access_key: "ecommerce", serviceAccessKey: "", index: 1),
        "Softwares":PekoPaymentServiceModel(title: "Softwares", icon: "icon_subscription_payments", access_key: "", serviceAccessKey: "subscription_payments", index: 2),
        "Logistics": PekoPaymentServiceModel(title: "Logistics", icon: "icon_logistics", access_key: "", serviceAccessKey: "", index: 3),
        "airline":PekoPaymentServiceModel(title: "Air Ticket", icon: "icon_air_tickets", access_key: "travelApi_airline", serviceAccessKey: "", index: 4),
        "hotels": PekoPaymentServiceModel(title: "Hotel Booking", icon: "icon_hotel_booking", access_key: "hotels_api", serviceAccessKey: "", index: 5),
        "Payroll":PekoPaymentServiceModel(title: "Payroll", icon: "icon_payroll", access_key: "payroll", serviceAccessKey: "peko_payroll", index: 6),
        "Invoicing": PekoPaymentServiceModel(title: "Invoicing", icon: "icon_invoicing", access_key: "the_collector", serviceAccessKey: "quick_links", index: 7),
        "Document Attestation": PekoPaymentServiceModel(title: "Document Attestation", icon: "icon_document_attestation", access_key: "document_attestation", serviceAccessKey: "", index: 8),
        "Gift Cards":PekoPaymentServiceModel(title: "Gift Cards", icon: "icon_gift_cards", access_key: "youGotAGift", serviceAccessKey: "", index: 9),
        "Business Docs":PekoPaymentServiceModel(title: "Business Docs", icon: "icon_business_docs", access_key: "edocs", serviceAccessKey: "", index: 10),
        "License Renewal":PekoPaymentServiceModel(title: "License Renewal", icon: "icon_license_renewal", access_key: "", serviceAccessKey: "", index: 11),
        "Marketplace":PekoPaymentServiceModel(title: "Marketplace", icon: "icon_connect", access_key: "", serviceAccessKey: "", index: 12),
        "eSIM": PekoPaymentServiceModel(title: "Travel eSIM", icon: "icon_eSIM", access_key: "esim", serviceAccessKey: "", index: 13),
        "Hub":PekoPaymentServiceModel(title: "Hub", icon: "icon_peko_cloud", access_key: "peko_cloud", serviceAccessKey: "pekoCloud", index: 14),
        "Business Emails":PekoPaymentServiceModel(title: "Business Emails", icon: "icon_business_emails", access_key: "email_domain_service", serviceAccessKey: "", index: 15),
        "eSign":PekoPaymentServiceModel(title: "eSign", icon: "icon_eSign", access_key: "eSign", serviceAccessKey: "signDesk_eSign", index: 16),
        
        "Mobile Recharge":PekoPaymentServiceModel(title: "Mobile Recharge", icon: "icon_mobile_recharge", access_key: "", serviceAccessKey: "", index: 17),
        
    ]
   
}
