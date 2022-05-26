//
//  ViewController.swift
//  MeBoxApp
//
//  Created by Kanyan Zheng on 2022/4/26.
//

import UIKit
import MeBoxiOS

class RouterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        title = "Router"
        view.backgroundColor = .cyan
        
        view.addSubview(gotoMyFeedButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            gotoMyFeedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gotoMyFeedButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
        ])
    }
    
    @objc private func goto(sender: UIButton) {
        switch sender.tag {
        case 1:
            let feedLoader = MyFeedLoaderStub()
            let imageLoader = MyImageDataLoaderStub()
            let vc = MyFeedViewController(feedLoader: feedLoader, imageLoader: imageLoader)
            self.navigationController?.pushViewController(vc, animated: false)
        default:
            break
        }
    }
    
    private lazy var gotoMyFeedButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go to my feed view", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(goto), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}

