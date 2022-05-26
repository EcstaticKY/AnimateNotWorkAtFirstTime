//
//  UITableView+Dequeueing.swift
//  MeBoxiOS
//
//  Created by Kanyan Zheng on 2022/3/1.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
