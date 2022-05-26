//
//  UICollectionView+Dequeueing.swift
//  MeBoxiOS
//
//  Created by Kanyan Zheng on 2022/5/3.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
    }
}
