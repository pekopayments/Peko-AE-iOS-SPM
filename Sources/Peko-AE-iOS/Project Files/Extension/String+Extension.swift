//
//  String+Extension.swift
//  Peko
//
//  Created by Hardik Makwana on 04/01/23.
//

import UIKit

extension String {
    public var isValidEmail: Bool {
       // let emailRegEx =         "^(?:(?:(?:(?:[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-])+(?:(?:\\.(?!\\.))?(?:[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-])+)*)|(?:\"(?:[^\"\\\\]|\\\\.)*\"))@(?:(?:[a-zA-Z0-9])+(?:\\.(?:[a-zA-Z0-9])+(?:[a-zA-Z0-9-])*(?:[a-zA-Z0-9]))+))$"
 // "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        /*
        let localPartRegex = "(?:(?:(?:[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-])+(?:(?:\\.(?!\\.))?(?:[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-])+)*)|(?:\"(?:[^\"\\\\]|\\\\.)*\"))"

        let domainPartRegex = "(?:(?:[a-zA-Z0-9])+(?:\\.(?:[a-zA-Z0-9])+(?:[a-zA-Z0-9-])*(?:[a-zA-Z0-9]))+)"

        let emailRegEx = "^(?:\(localPartRegex)@\(domainPartRegex))$"

        
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: self)
        */
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        var valid = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
        if valid {
            valid = !self.contains("Invalid email id")
        }
        return valid
    }
    
    public var isValidURL: Bool {
            let regex = "http[s]?://(([^/:.[:space:]]+(.[^/:.[:space:]]+)*)|([0-9](.[0-9]{3})))(:[0-9]+)?((/[^?#[:space:]]+)([^#[:space:]]+)?(#.+)?)?"
            let test = NSPredicate(format:"SELF MATCHES %@", regex)
            let result = test.evaluate(with: self)
            return result
     }
    public var isValidUAEMobileNumber: Bool {
        
        let cleaned = self.replacingOccurrences(of: "\\s|-", with: "", options: .regularExpression)
        let patterns = [
            "^\\+9715\\d{8}$",   // +9715XXXXXXXX
            "^05\\d{8}$",        // 05XXXXXXXX
            "^5\\d{8}$"          // 5XXXXXXXX (no leading 0 or +971)
            ]
        return patterns.contains {
            NSPredicate(format: "SELF MATCHES %@", $0).evaluate(with: cleaned)
        }
//
//        let regex = "^(?:00971|\\+971|0)?(?:50|51|52|55|56|58|2|3|4|6|7|9)\\d{7}$"
//        let test = NSPredicate(format:"SELF MATCHES %@", regex)
//        let result = test.evaluate(with: self)
//        return result
        
    }
    
    public var isValidIFSCNumber: Bool {
        
        let regex = "^[A-Z]{4}0[A-Z0-9]{6}$"
        let test = NSPredicate(format:"SELF MATCHES %@", regex)
        let result = test.evaluate(with: self)
        return result
        
    }
    
    
    public var isConsecutiveCharacters: Bool {
        let regex = "(.)\\1"
        if self.range(of: regex, options: .regularExpression) != nil {
            return true
        }
        return false
    }
    public var isNumeric: Bool {
        return !(self.isEmpty) && self.allSatisfy { $0.isNumber }
    }
    
    public func trim() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    public func separate(every: Int, with separator: String) -> String {
        return String(stride(from: 0, to: Array(self).count, by: every).map {
            Array(Array(self)[$0..<min($0 + every, Array(self).count)])
        }.joined(separator: separator))
    }
    public func dateFromISO8601()->Date? {
        
       // let strDate = self.replacingOccurrences(of: ".000Z", with: "Z")
       
        let array = self.components(separatedBy: ".")
        let strDate = array[0] + "Z"
        let localISOFormatter = ISO8601DateFormatter()
        localISOFormatter.timeZone = TimeZone.current

        return localISOFormatter.date(from: strDate)
        
        /*
        let df = DateFormatter()
        df.calendar = Calendar(identifier: .iso8601)
        df.timeZone = TimeZone.current
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        if self.count == 0 {
            return nil
        }
        return df.date(from:self)!
         */
    }
    public func convertToDate(format:String = "yyyy-MM-dd") -> Date {
        let df = DateFormatter()
        df.dateFormat = format
        return df.date(from: self) ?? Date()
    }
    
    
    // MARK: - String to Double
    public func toDouble() -> Double {
        return Double(self) ?? 0.0
    }
    
    public var html2AttributedString: String? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil).string
            
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
    
    public func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
    
    public func toDate(format:String = "yyyy-MM-dd'T'HH:mm:ss")->Date? {
        if self.count == 0 {
            return Date()
        }
        let df = DateFormatter()
//        df.calendar = Calendar(identifier: .iso8601)
//        df.timeZone = TimeZone.current
//        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = format
        return df.date(from:self)
    }
    
    public func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    public func convertToDictionary() -> [String:Any]? {
        if let data = self.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }

    // MARK: - 
    public func localizeString() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    public func convertTo12HourFormat() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm" // 24-hour format
        
        // Convert string to Date
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "h:mm a" // 12-hour format
            return dateFormatter.string(from: date)
        }
        return nil
    }
    public func convertTo24HourFormat() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a" // 12-hour format
        
        // Convert string to Date
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "HH:mm" // 24-hour format
            return dateFormatter.string(from: date)
        }
        return nil
    }
}

extension String {
    public func containsEmoji() -> Bool {
//        for scalar in unicodeScalars {
//            if !scalar.properties.isEmoji { continue }
//            return true
//        }
//        return false
        
        let isContainEmoji = self.unicodeScalars.filter({ $0.properties.isEmoji }).count > 0
        let numberCharacters = self.rangeOfCharacter(from: .decimalDigits)
        
        if isContainEmoji && numberCharacters == nil {
            return true
        }
        return false
    }
    public var isEmoji: Bool {
           guard let scalar = unicodeScalars.first else { return false }
           return scalar.properties.isEmoji && (scalar.value > 0x238C || unicodeScalars.count > 1)
    }
    
    public func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating public func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    public func getFileExtension() -> String {
        let fileType = NSString(format: "%@", (self).components(separatedBy: "?").first ?? "").pathExtension
        return fileType.lowercased()
    }
}


// regex
extension String {
    public func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
