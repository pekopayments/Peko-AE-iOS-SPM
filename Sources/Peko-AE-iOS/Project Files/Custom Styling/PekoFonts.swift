//
//  PekoFonts.swift
//  Peko
//
//  Created by Hardik Makwana on 17/02/24.
//

import UIKit


public extension UIFont {
    public class func regular(size:CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Regular", size: size)!
    }
    public class func medium(size:CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Medium", size: size)!
    }
    public class func bold(size:CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Bold", size: size)!
    }
    public class func light(size:CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Light", size: size)!
    }
    public class func italic(size:CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Italic", size: size)!
    }
}
