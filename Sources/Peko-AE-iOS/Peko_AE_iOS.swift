// The Swift Programming Language
// https://docs.swift.org/swift-book
//import 
import PekoSDK
import UIKit

public class PekoManager {
    public init(){
    
    }
    @MainActor public func userLogin(userName:String, password:String, viewController: UIViewController) {
       
        let userName = "100000001"
        let password = "Admin@123"
       
        let obj = PekoSDKManager()
        obj.userLogin(username: userName, password: password, viewController: viewController)
    }
}
