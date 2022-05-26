//
//  MyFeedStubs.swift
//  MeBoxApp
//
//  Created by Kanyan Zheng on 2022/5/26.
//

import UIKit
import MeBoxiOS

class MyFeedLoaderStub: MyFeedLoader {
    var feed: [MyFeedItem] {
        (0..<20).map { uniqueMyFeedItem($0) }
    }
    
    let delayTime = 1.5
    
    func load(completion: @escaping (Result<[MyFeedItem], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
            completion(.success(self.feed))
        }
    }
}

class MyImageDataLoaderStub: MyImageDataLoader {
    private class MyImageDataLoaderStubTask: MyImageDataLoaderTask {
        func cancel() {
            
        }
    }
    
    let delayTime = 2.0
    
    func loadWithNum(_ imageNum: Int, completion: @escaping (Result<Data, Error>) -> Void) -> MyImageDataLoaderTask {
        
        var image: UIImage?
        
        switch imageNum % 10 {
        case 1:
            image = UIImage.make(withColor: .red)
        case 2:
            image = UIImage.make(withColor: .yellow)
        case 3:
            image = UIImage.make(withColor: .green)
        case 4:
            image = UIImage.make(withColor: .cyan)
        case 5:
            image = UIImage.make(withColor: .magenta)
        case 6:
            image = UIImage.make(withColor: .purple)
        case 7:
            image = UIImage.make(withColor: .gray)
        case 8:
            image = UIImage.make(withColor: .blue)
        case 9:
            image = UIImage.make(withColor: .brown)
        case 0:
            image = UIImage.make(withColor: .orange)
        default:
            image = UIImage.make(withColor: .black)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
            completion(.success((image?.pngData())!))
//            completion(.success(UIImage.make(withColor: .white).pngData()!))
        }
        
        return MyImageDataLoaderStubTask()
    }
}
