//
//  MyImageDataLoader.swift
//  MeBoxiOS
//
//  Created by Kanyan Zheng on 2022/5/26.
//

import Foundation

public protocol MyImageDataLoaderTask {
    func cancel()
}

public protocol MyImageDataLoader {
    func loadWithNum(_ imageNum: Int, completion: @escaping (Result<Data, Error>) -> Void) -> MyImageDataLoaderTask
}
