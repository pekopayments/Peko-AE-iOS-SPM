//
//  Data+Extension.swift
//  Peko
//
//  Created by Hardik Makwana on 16/11/24.
//

import UIKit

extension Data {

    var bytes: Int64 {
        .init(self.count)
    }

    public var kilobytes: Double {
        return Double(bytes) / 1_024
    }

    public var megabytes: Double {
        return kilobytes / 1_024
    }

    public var gigabytes: Double {
        return megabytes / 1_024
    }

    public func getReadableUnit() -> String {

        switch bytes {
            case 0..<1_024:
                return "\(bytes) bytes"
            case 1_024..<(1_024 * 1_024):
                return "\(String(format: "%.2f", kilobytes)) KB"
            case 1_024..<(1_024 * 1_024 * 1_024):
                return "\(String(format: "%.2f", megabytes)) MB"
            case (1_024 * 1_024 * 1_024)...Int64.max:
                return "\(String(format: "%.2f", gigabytes)) GB"
            default:
                return "\(bytes) bytes"
        }
    }
}

extension Int64 {
    
}
