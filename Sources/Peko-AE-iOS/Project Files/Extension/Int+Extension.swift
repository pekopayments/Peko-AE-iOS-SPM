//
//  Int+Extension.swift
//  Peko
//
//  Created by Hardik Makwana on 06/12/23.
//

import UIKit

extension Int {
    func timeString() -> String {
        let hour = self / 3600
        let minute = self / 60 % 60
        let second = self % 60
        
        if hour == 0 {
            return String(format: "%02i:%02i", minute, second)
        }else{
            return String(format: "%02i:%02i:%02i", hour, minute, second)
        }
    }
    
    func airlineTimeString() -> String {
       
        let hour = self / 60
        let minute = self % 60
      //  let second = self % 60
        
        if hour == 0 {
            return String(format: "%im", minute)
        }else{
            return String(format: "%ih %im", hour, minute)
        }
    }
    
    // MARK
    func humanReadableByteCount() -> String {
        let bytes = Double(self)
       
        if bytes == 0.0 {
            return "0.00 KB"
        }
        
        /*
        if (bytes < 1000) { return "\(bytes) B" }
        let exp = Int(log2(Double(bytes)) / log2(1000.0))
        let unit = ["KB", "MB", "GB", "TB", "PB", "EB"][exp - 1]
        let number = Double(bytes) / pow(1000, Double(exp))
        if exp <= 1 || number >= 100 {
            return String(format: "%.0f %@", number, unit)
        } else {
            return String(format: "%.1f %@", number, unit)
                .replacingOccurrences(of: ".0", with: "")
        }
        */
        
        let multiplier: Int = 1024
        
        switch self {
        case 0..<multiplier:
            return "\(self) bytes"
        case multiplier..<(multiplier * multiplier):
            return String(format: "%.2f KB", Double(self) / Double(multiplier))
        case multiplier..<(multiplier * multiplier * multiplier):
            return String(format: "%.2f MB", Double(self) / Double(multiplier * multiplier))
        case (multiplier * multiplier * multiplier)...IntegerLiteralType.max:
            return String(format: "%.2f GB", Double(self) / Double(multiplier * multiplier * multiplier))
        default:
            return "\(self) bytes"
        }
    }
    
    func mbToGb() -> Int {
        let multiplier: Int = 1024
        
        return self / multiplier
    }
    
}
extension Int {
    var boolValue: Bool { return self != 0 }
}


extension Int64 {
    func getReadableStorageUnit() -> String {
        
        switch self {
        case 0..<1000:
            return "\(self) bytes"
        case 1_000..<(1_000 * 1_000):
            return "\(String(format: "%.2f", Double(self) / 1_000)) KB"
        case 1_000..<(1_000 * 1_000 * 1_000):
            return "\(String(format: "%.2f", (Double(self) / 1_000) / 1_000)) MB"
        case (1_000 * 1_000 * 1_000)...Int64.max:
            return "\(String(format: "%.2f", ((Double(self) / 1_000) / 1_000) / 1_000)) GB"
        default:
            return "\(self) bytes"
        }
    }
}
