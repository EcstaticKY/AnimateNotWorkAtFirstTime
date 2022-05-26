//
//  UIControl+TestHelpers.swift
//  MeBoxiOSTests
//
//  Created by Kanyan Zheng on 2022/5/22.
//

import UIKit

extension UIControl {
    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
