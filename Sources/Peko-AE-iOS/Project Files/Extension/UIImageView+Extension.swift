//
//  UIImageView+Extension.swift
//  Peko
//
//  Created by Hardik Makwana on 01/11/25.
//
import UIKit

extension UIImageView {
    func setFileExtensionIcon(fileType: String) {
        if fileType == "png" {
            self.image = UIImage(named: "icon_png_file")
        }else{
            self.image = UIImage(named: "icon_pdf_file")
        }
    }
}


