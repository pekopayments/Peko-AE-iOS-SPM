//
//  PekoColors.swift
//  Peko
//
//  Created by Hardik Makwana on 08/02/24.
//

import UIKit

extension UIColor {
     public static var redButtonColor: UIColor {
        return UIColor(red: 255/255.0, green: 79/255.0, blue: 79/255.0, alpha: 1.0) // rgb(255, 79, 79) //UIColor(named: "RedButtonColor") ?? .clear
    }
    static var grayTextColor: UIColor {
        return UIColor(named: "GrayTextColor") ?? .clear
    }
    static var textFieldBorderColor: UIColor {
        return UIColor(named: "TextFieldBorderColor") ?? .clear
    }
}
