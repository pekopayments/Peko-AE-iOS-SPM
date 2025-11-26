//
//  AppValidationResult.swift
//  Peko
//
//  Created by Hardik Makwana on 04/01/23.
//

import UIKit

public struct AppValidationResult
{
    public let success: Bool
    public let error : String?
    public init(success: Bool, error: String?) {
        self.success = success
        self.error = error
    }
}
