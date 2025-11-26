//
//  Double+Extension.swift
//  Peko
//
//  Created by Hardik Makwana on 24/02/23.
//

import UIKit

public extension Double {
    public func withCommas(decimalPoint:Int = 2) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = decimalPoint
        numberFormatter.minimumFractionDigits = decimalPoint
        numberFormatter.groupingSize = 3
        numberFormatter.secondaryGroupingSize = 3
        return numberFormatter.string(from: NSNumber(value:self))!
    }
    public func decimalPoints(point:Int = 2) -> String {
        return String(format: "%.\(point)f", self)
    }
    
    public func formatPoints() ->String{
        let num = self
        var thousandNum = num/1000
        var millionNum = num/1000000
        if num >= 1000 && num < 1000000{
            if(floor(thousandNum) == thousandNum){
                return("\(Int(thousandNum))k")
            }
            return("\(thousandNum.roundToPlaces(places: 1))k")
        }
        if num > 1000000{
            if(floor(millionNum) == millionNum){
                return("\(Int(thousandNum))k")
            }
            return ("\(millionNum.roundToPlaces(places: 1))M")
        }
        else{
            if(floor(num) == num){
                return ("\(Int(num))")
            }
            return ("\(num)")
        }

    }
    /// Rounds the double to decimal places value
    mutating public func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Darwin.round(self * divisor) / divisor
    }
    
}
