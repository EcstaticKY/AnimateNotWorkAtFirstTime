//
//  ShimmeringView.swift
//  MeBoxiOS
//
//  Created by Kanyan Zheng on 2022/6/1.
//

import UIKit

public class ShimmeringView: UIView {
    public var isShimmering: Bool {
        set {
            if newValue {
                startShimmering()
            } else {
                stopShimmering()
            }
        }
     
        get {
            return layer.mask?.animation(forKey: shimmerAnimationKey) != nil
        }
    }

    private var shimmerAnimationKey: String {
        return "shimmer"
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        if isShimmering {
            stopShimmering()
            startShimmering()
        }
    }

    private func startShimmering() {
        
        let white = UIColor.white.cgColor
        let alpha = UIColor.white.withAlphaComponent(0.75).cgColor
        let width = bounds.width
        let height = bounds.height
        
        let gradient = CAGradientLayer()
        gradient.colors = [alpha, white, alpha]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.4)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.6)
        gradient.locations = [0.4, 0.5, 0.6]
        gradient.frame = CGRect(x: -width, y: 0, width: width*3, height: height)
        layer.mask = gradient
        
        let animation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.locations))
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = 1.25
        animation.repeatCount = .infinity
        gradient.add(animation, forKey: shimmerAnimationKey)
    }
    
    private func stopShimmering() {
        layer.mask = nil
    }
}
