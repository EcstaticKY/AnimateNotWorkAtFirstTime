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
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            shimmeringView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shimmeringView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shimmeringView.topAnchor.constraint(equalTo: contentView.topAnchor),
            shimmeringView.heightAnchor.constraint(equalToConstant: 100),
            
            topImageView.leadingAnchor.constraint(equalTo: shimmeringView.leadingAnchor),
            topImageView.trailingAnchor.constraint(equalTo: shimmeringView.trailingAnchor),
            topImageView.topAnchor.constraint(equalTo: shimmeringView.topAnchor),
            topImageView.bottomAnchor.constraint(equalTo: shimmeringView.bottomAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: shimmeringView.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public lazy var shimmeringView: ShimmeringView = {
        let view = ShimmeringView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 100)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(MySmallMediaCell.self, forCellWithReuseIdentifier: String(describing: MySmallMediaCell.self))
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
}

extension MyFeedItemCell: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: MySmallMediaCell = collectionView.dequeueReusableCell(for: indexPath)
        switch indexPath.row {
        case 0:
            cell.backgroundColor = .blue
        case 1:
            cell.backgroundColor = .brown
        default:
            cell.backgroundColor = .cyan
        }
        return cell
    }
}
