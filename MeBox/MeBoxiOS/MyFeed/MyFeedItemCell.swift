//
//  MyFeedItemCell.swift
//  MeBoxiOS
//
//  Created by Kanyan Zheng on 2022/5/26.
//

import UIKit

public class MyFeedItemCell: UITableViewCell {
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        contentView.addSubview(shimmeringView)
        shimmeringView.addSubview(topImageView)
        
        NSLayoutConstraint.activate([
            shimmeringView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shimmeringView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shimmeringView.topAnchor.constraint(equalTo: contentView.topAnchor),
            shimmeringView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            topImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public lazy var shimmeringView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
}
