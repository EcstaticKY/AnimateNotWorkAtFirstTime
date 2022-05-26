//
//  String+TextSize.swift
//  MeBoxiOS
//
//  Created by Kanyan Zheng on 2022/3/3.
//

import UIKit

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont, lineSpacing: CGFloat? = nil) -> CGFloat {
        var attributes: [NSAttributedString.Key : Any] = [.font: font]
        if lineSpacing != nil {
            let paragraphStyle = NSParagraphStyle()
            attributes[.paragraphStyle] = paragraphStyle
        }
        
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
    
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}
