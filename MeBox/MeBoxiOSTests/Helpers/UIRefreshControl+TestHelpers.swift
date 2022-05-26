//
//  UIRefreshControl+TestHelpers.swift
//  MeBoxiOSTests
//
//  Created by Kanyan Zheng on 2022/5/22.
//

import UIKit

extension UIRefreshControl {
    func simulatePullToRefresh() {
        simulate(event: .valueChanged)
    }
}
