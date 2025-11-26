import UIKit
import ReplayKit

public class ScreenProtectionManager {
    
    // HPM
    /*
    let shared = ScreenProtectionManager()
    private var blurOverlay: UIVisualEffectView?

    func startProtection(for window: UIWindow?) {
        guard let window = window else { return }

        NotificationCenter.default.addObserver(
            forName: UIScreen.capturedDidChangeNotification,
            object: nil,
            queue: .main
        ) { _ in
            self.updateProtection(on: window)
        }

        NotificationCenter.default.addObserver(
            forName: UIApplication.userDidTakeScreenshotNotification,
            object: nil,
            queue: .main
        ) { _ in
            print("Screenshot detected")
            self.updateProtection(on: window)
        }

        
    }

    private func updateProtection(on window: UIWindow) {
        let isCaptured = UIScreen.main.isCaptured || RPScreenRecorder.shared().isRecording

        if isCaptured {
            if blurOverlay == nil {
                let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
                let blurView = UIVisualEffectView(effect: blurEffect)
                blurView.frame = window.bounds
                blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                window.addSubview(blurView)
                blurOverlay = blurView
            }
        } else {
            blurOverlay?.removeFromSuperview()
            blurOverlay = nil
        }
    }
    */
}
