//
//  UIColor+Extension.swift
//  MeBoxiOS
//
//  Created by Kanyan Zheng on 2022/3/1.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("0X") {
            hexFormatted = String(hexFormatted.dropFirst(2))
        }
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                     green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                     blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                     alpha: alpha)
    }
}
