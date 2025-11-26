//
//  HPProgressHUD.swift
//  ProgressHUD
//
//  Created by Hardik Makwana on 19/10/19.
//  Copyright © 2019 Hardik Makwana. All rights reserved.
//

import UIKit

@MainActor
let objHPProgressHUD = HPProgressHUD.sharedInstance

public class HPProgressHUD: UIViewController {

    @IBOutlet weak var dotContainerView: UIView!
   // @IBOutlet weak var animationView: LottieAnimationView!
   
 //   @IBOutlet weak var hudImgView: UIImageView!
    
    static let sharedInstance = HPProgressHUD()
   
    
//    func initialize() {
//         
//         
////        objHPProgressHUD =  HPProgressHUD(nibName: "HPProgressHUD", bundle: .module)
////        objHPProgressHUD.modalPresentationStyle = .fullScreen
////      
//       // objHPProgressHUD.view
//    }
       
    
    public static func show() {
        DispatchQueue.main.async {
            objHPProgressHUD.view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
            
            let window = UIApplication.shared.keyWindow!
            window.addSubview(objHPProgressHUD.view)
            ProgressHUD.animate()
            
          //  objHPProgressHUD.rotate1()
           
        }
    }
    public static func hide() {
      //  objHPProgressHUD.dismiss(animated: false, completion: nil)
        DispatchQueue.main.async {
            ProgressHUD.remove()
            objHPProgressHUD.removeDots()
            objHPProgressHUD.view.removeFromSuperview()
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isOpaque = false
        self.view.backgroundColor = UIColor.init(white: 0, alpha: 0.7)
       
        ProgressHUD.colorHUD = .clear
        ProgressHUD.colorBackground = .clear
        ProgressHUD.colorAnimation = .white
        ProgressHUD.colorProgress = .white
        ProgressHUD.animationType = .horizontalDotScaling      //  animationView.loopMode = .loop
       // ProgressHUD.viewBackground?.backgroundColor = .clear
        // Do any additional setup after loading the view.
    }
    
    public override func viewDidAppear(_ animated: Bool) {
      // self.hudImgView.rotate360Degrees(duration: 1.0)
        
    }
    func rotate1() { //CABasicAnimation
     //   self.animationView.play()
        
      //  self.animationHorizontalDotScaling()
        
//
//            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
//            rotationAnimation.fromValue = 0.0
//            rotationAnimation.toValue = Double.pi * 2 //Minus can be Direction
//        rotationAnimation.duration = 1.0
//            rotationAnimation.repeatCount = .infinity
//        self.hudImgView.layer.add(rotationAnimation, forKey: nil)
    }
    func animationHorizontalDotScaling() {
        let width = self.dotContainerView.frame.size.width
        let height = self.dotContainerView.frame.size.height

        let spacing = 3.0
        let radius = (width - spacing * 2) / 3
        let center = CGPoint(x: radius / 2, y: radius / 2)
        let positionY = (height - radius) / 2

        let beginTime = CACurrentMediaTime()
        let beginTimes = [0.36, 0.24, 0.12]
        let timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.68, 0.18, 1.08)

        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.keyTimes = [0, 0.5, 1]
        animation.timingFunctions = [timingFunction, timingFunction]
        animation.values = [1, 0.3, 1]
        animation.duration = 1
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false

        let path = UIBezierPath(arcCenter: center, radius: radius / 2, startAngle: 0, endAngle: 2 * .pi, clockwise: false)

        for i in 0..<3 {
            let layer = CAShapeLayer()
            layer.frame = CGRect(x: (radius + spacing) * CGFloat(i), y: positionY, width: radius, height: radius)
            layer.path = path.cgPath
            layer.fillColor = UIColor.white.cgColor

            animation.beginTime = beginTime - beginTimes[i]

            layer.add(animation, forKey: "animation")
            self.dotContainerView.layer.addSublayer(layer)
        }
    }
    func removeDots(){
//        viewAnimation.subviews.forEach {
//            $0.removeFromSuperview()
//        }

        if self.dotContainerView != nil {
            self.dotContainerView.layer.sublayers?.forEach {
                $0.removeFromSuperlayer()
            }
            
            self.dotContainerView.subviews.forEach {
                $0.removeFromSuperview()
            }
        }
        
    }
//    func rotateView(targetView: UIView, duration: Double = 1.0) {
//        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
//            targetView.transform = targetView.transform.rotated(by: CGFloat(Double.pi))
//        }) { finished in
//            self.rotateView(targetView: self.hudImgView, duration: 0.8)
//        }
//    }
//    
}

