//
//  UIImage+Named.swift
//  MeBoxiOS
//
//  Created by Kanyan Zheng on 2022/3/3.
//

import UIKit

extension UIView {
    func image(named name: String) -> UIImage? {
        let bundle = Bundle(for: Self.self)
        let image = UIImage(named: name, in: bundle, compatibleWith: nil)
        return image
    }
}
