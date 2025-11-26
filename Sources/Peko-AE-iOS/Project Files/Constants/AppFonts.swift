//
//  AppFonts.swift
//  Peko-AE-iOS-Utility
//
//  Created by Hardik Makwana on 24/11/25.
//

import UIKit

enum AppFonts : String{
    
    case Light = "Roboto-Light"
    case Regular = "Roboto-Regular"
    case Medium = "Roboto-Medium"
    case SemiBold = "Inter-SemiBold"
    case Bold = "Roboto-Bold"
    case ExtraBold = "Inter-ExtraBold"
    
    func size(size:Float) -> UIFont {
        return UIFont(name: self.rawValue, size: CGFloat(size))!
    }
}

enum FontStyle: String {
    case Light // 300
    case Regular // 400
    case Medium // 500
    case SemiBold // 600
    case Bold // 700
    case ExtraBold // 800
}
