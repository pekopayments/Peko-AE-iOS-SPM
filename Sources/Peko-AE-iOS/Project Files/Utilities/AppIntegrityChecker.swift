//
//  AppIntegrityChecker.swift
//  YourApp
//
//  Created by Hardik Makwana on 03/11/2025.
//

import UIKit
import DeviceCheck

final class AppIntegrityChecker {
    
    let shared = AppIntegrityChecker()
    private init() {}
    
    private let expectedBundleID = ["com.app.peko.payment", "com.app.peko.payment.uat"]
    private let expectedTeamID = "3NW34YF2D9" // your real team ID
    
    // MARK: - Verify Bundle & Team
    func verifyAppIdentity() -> Bool {
//        guard let appPrefix = Bundle.main.infoDictionary?["AppIdentifierPrefix"] as? String,
//              let bundleID = Bundle.main.bundleIdentifier else {
//            return false
//        }
        guard let bundleID = Bundle.main.bundleIdentifier else { return false }
            
        return expectedBundleID.contains(bundleID) // && appPrefix.hasPrefix(expectedTeamID)
    }
    
    // MARK: - Jailbreak Detection
    func isDeviceJailbroken() -> Bool {
//        if objShareManager.appTarget == .PEKO_TEST {
//            return false
//        }
        #if targetEnvironment(simulator)
        return false
        #else
        let suspiciousPaths = [
            "/Applications/Cydia.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt"
        ]
        
        if suspiciousPaths.contains(where: { FileManager.default.fileExists(atPath: $0) }) {
            return true
        }
        
        let testPath = "/private/jailbreak.txt"
        do {
            try "test".write(toFile: testPath, atomically: true, encoding: .utf8)
            try FileManager.default.removeItem(atPath: testPath)
            return true
        } catch { }
        
        return false
        #endif
    }
    
    // MARK: - Screen Capture Detection
    func isScreenBeingCaptured() -> Bool {
        UIScreen.main.isCaptured
    }
    
    // MARK: - App Attest
    @available(iOS 14.0, *)
    func generateAppAttestKey() async throws -> String {
        let service = DCAppAttestService.shared
        guard service.isSupported else {
            throw NSError(domain: "AppAttest", code: -1,
                          userInfo: [NSLocalizedDescriptionKey: "App Attest not supported on this device"])
        }
        return try await service.generateKey()
    }
    
    // MARK: - Combined Result
    func performIntegrityCheck() -> AppIntegrityResult {
        let bundleOK = verifyAppIdentity()
        let jailbreak = isDeviceJailbroken()
        let captured = isScreenBeingCaptured()
        
        return AppIntegrityResult(
            isBundleValid: bundleOK,
            isDeviceJailbroken: jailbreak,
            isScreenCaptured: captured,
            passed: bundleOK && !jailbreak
        )
    }
}

struct AppIntegrityResult {
    let isBundleValid: Bool
    let isDeviceJailbroken: Bool
    let isScreenCaptured: Bool
    let passed: Bool
}
