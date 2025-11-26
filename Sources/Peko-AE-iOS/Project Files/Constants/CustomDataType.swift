//
//  CustomDataType.swift
//  Peko
//
//  Created by Hardik Makwana on 18/03/23.
//

import UIKit

public struct CustomBool: Codable, Sendable {
    public var value:Bool
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self.value = x == 1 ? true : false  // "\(x)" //.double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self.value = x == "1" ? true : false
            return
        }
        if let x = try? container.decode(Bool.self) {
            self.value = x // == "1" ? true : false
            return
        }
        throw DecodingError.typeMismatch(CustomBool.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for TransactionID"))
    }
}
public struct CustomInt: Codable, Sendable {
    public var value:Int
    
    internal init(value: Int) {
        self.value = value
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self.value = x // == 1 ? true : false  // "\(x)" //.double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self.value = Int(x) ?? 0 //== "1" ? true : false
            return
        }
        if let x = try? container.decode(Double.self) {
            self.value = Int(x) // == "1" ? true : false
            return
        }
        if let x = try? container.decode(Bool.self) {
            self.value = x == true ? 1 : 0
            return
        }
        throw DecodingError.typeMismatch(CustomInt.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for TransactionID"))
    }
}
public struct CustomDouble: Codable, Sendable {
    public var value:Double
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self.value = Double(x) // == 1 ? true : false  // "\(x)" //.double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self.value = Double(x) ?? 0.0 //== "1" ? true : false
            return
        }
        if let x = try? container.decode(Double.self) {
            self.value = x // == "1" ? true : false
            return
        }
        throw DecodingError.typeMismatch(CustomInt.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for TransactionID"))
    }
}

public struct CustomString: Codable, Sendable {
    public var value:String
    
    internal init(value: String) {
        self.value = value
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self.value = String(format: "%d", x) // "\(x)" //.double(x)
            return
        }
        if let x = try? container.decode(Double.self) {
            self.value = "\(x)" // "\(x)" //.double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self.value = x //Int(x) ?? 0//.string(x)
            return
        }
        if let x = try? container.decode([Int].self) {
            if x.count != 0 {
                self.value = "\(x[0])"
                return
            }
             //Int(x) ?? 0//.string(x)
            
        }
        if let x = try? container.decode([String].self) {
            if x.count != 0 {
                self.value = x.joined(separator: ", ")
                return
            }
        }
        throw DecodingError.typeMismatch(CustomString.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for TransactionID"))
    }
}
