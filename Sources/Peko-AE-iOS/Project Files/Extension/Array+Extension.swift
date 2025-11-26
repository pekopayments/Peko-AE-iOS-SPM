//
//  Array+Extension.swift
//  Peko
//
//  Created by Hardik Makwana on 04/04/24.
//

import UIKit

public extension Array {
    public func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
    
    // MARK: -
    
    public func toJSON() -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return nil
        }
      //  print("\(json(from:array as Any))")
        return String(data: data, encoding: String.Encoding.utf8)
        
    }
}
