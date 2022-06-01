//
//  MySmallMediaCell.swift
//  MeBoxiOS
//
//  Created by Kanyan Zheng on 2022/6/1.
//

import UIKit

public class MySmallMediaCell: UICollectionViewCell {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(shimmeringView)
        shimmeringView.addSubview(mediaImageView)
        
        NSLayoutConstraint.activate([
            shimmeringView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shimmeringView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shimmeringView.topAnchor.constraint(equalTo: contentView.topAnchor),
            shimmeringView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            mediaImageView.leadingAnchor.constraint(equalTo: shimmeringView.leadingAnchor),
            mediaImageView.trailingAnchor.constraint(equalTo: shimmeringView.trailingAnchor),
            mediaImageView.topAnchor.constraint(equalTo: shimmeringView.topAnchor),
            mediaImageView.bottomAnchor.constraint(equalTo: shimmeringView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var isCurrent: Bool = false
    
    public var isShimmering: Bool {
        set { shimmeringView.isShimmering = newValue }
        get { shimmeringView.isShimmering }
    }
    
    public var image: UIImage? {
        set { mediaImageView.image = newValue }
        get { mediaImageView.image }
    }
    
    private lazy var shimmeringView: ShimmeringView = {
        let view = ShimmeringView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mediaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
}
