//
//  UITextField+Extension.swift
//  Peko
//
//  Created by Hardik Makwana on 28/01/23.
//

import UIKit

public extension UITextField {
    public func decimalNumberValidation(number: String) -> Bool
    {
        let countdots = (self.text!.components(separatedBy: ".").count) - 1
        if countdots > 0 && number == "."
        {
            return false
        }
        
        let dotString = "."
        if self.text!.contains(dotString) {
            if self.text!.components(separatedBy: dotString)[1].count == 2 {
                return false
            }
        }
        
        let countComma = (self.text!.components(separatedBy: ",").count) - 1
        if countComma > 0 && number == ","
        {
            return false
        }
        
        let allowedCharacters = CharacterSet(charactersIn:",.0123456789")
        let characterSet = CharacterSet(charactersIn: number)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    public func numberValidation(number: String) -> Bool
    {
        let allowedCharacters = CharacterSet(charactersIn:"0123456789")
        let characterSet = CharacterSet(charactersIn: number)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    public func alphaValidation(string: String) -> Bool
    {
        let alphaNumericRegEx = "[a-zA-Z ]"
        let predicate = NSPredicate(format:"SELF MATCHES %@", alphaNumericRegEx)
        return predicate.evaluate(with: string)
    }
    public func alphaDotValidation(string: String) -> Bool
    {
        let alphaNumericRegEx = "[a-zA-Z .]"
        let predicate = NSPredicate(format:"SELF MATCHES %@", alphaNumericRegEx)
        return predicate.evaluate(with: string)
    }
    public func alphaNumericValidation(string: String) -> Bool
    {
        let alphaNumericRegEx = "[a-zA-Z0-9 ]"
        let predicate = NSPredicate(format:"SELF MATCHES %@", alphaNumericRegEx)
        return predicate.evaluate(with: string)
    }
    
    public func emailValidation(string: String) -> Bool
    {
        let alphaNumericRegEx = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.@-&"
       
        let allowedCharacters = CharacterSet(charactersIn:alphaNumericRegEx)
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    public func alphaNumberSymbolValidation(string: String) -> Bool
    {
        let alphaNumericRegEx = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.& "
       
        let allowedCharacters = CharacterSet(charactersIn:alphaNumericRegEx)
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    public func alphaNumberSymbol_2Validation(string: String) -> Bool
    {
        let alphaNumericRegEx = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.&-_.,/:'@ "
        
        let allowedCharacters = CharacterSet(charactersIn:alphaNumericRegEx)
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    public func uppercaseNumber(string: String) -> Bool
    {
        let alphaNumericRegEx = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
       
        let allowedCharacters = CharacterSet(charactersIn:alphaNumericRegEx)
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    
    public func customRegexValidation(string: String, customRegex:String) -> Bool
    {
      //  let alphaNumericRegEx = "[a-zA-Z0-9 ]"
        let predicate = NSPredicate(format:"SELF MATCHES %@", customRegex)
        return predicate.evaluate(with: string)
    }
    public func customCharacterValidation(string: String, customRegex:String) -> Bool
    {
      //  let alphaNumericRegEx = "[a-zA-Z0-9 ]"
        let allowedCharacters = CharacterSet(charactersIn:customRegex)
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
