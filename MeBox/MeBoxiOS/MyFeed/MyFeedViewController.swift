//
//  MyFeedViewController.swift
//  MeBoxiOS
//
//  Created by Kanyan Zheng on 2022/5/26.
//

import UIKit

public class MyFeedViewController: UITableViewController {
    private var feedLoader: MyFeedLoader?
    private var imageLoader: MyImageDataLoader?
    private var tableModel = [MyFeedItem]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    convenience public init(feedLoader: MyFeedLoader, imageLoader: MyImageDataLoader) {
        self.init(style: .plain)
        self.feedLoader = feedLoader
        self.imageLoader = imageLoader
    }
    
    public override func viewDidLoad() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadFeed), for: .valueChanged)
        
        tableView.rowHeight = 100
        tableView.backgroundColor = .white
        tableView.register(MyFeedItemCell.self, forCellReuseIdentifier: String(describing: MyFeedItemCell.self))
        
        loadFeed()
    }
    
    @objc private func loadFeed() {
        refreshControl?.beginRefreshing()
        feedLoader?.load { [weak self] result in
            self?.refreshControl?.endRefreshing()
            if let feed = try? result.get() {
                self?.tableModel = feed
            }
        }
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        tableModel.count
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyFeedItemCell = tableView.dequeueReusableCell()
        cell.topImageView.image = nil
        
        let model = tableModel[indexPath.section]
        
        cell.shimmeringView.isShimmering = true
        let _ = imageLoader?.loadWithNum(model.imageNum) { result in
            cell.shimmeringView.isShimmering = false
            if let imageData = try? result.get() {
                cell.topImageView.image = UIImage(data: imageData)
            }
        }
        
        return cell
    }
}
