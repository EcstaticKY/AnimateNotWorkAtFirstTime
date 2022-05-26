//
//  MyFeedLoader.swift
//  MeBoxiOS
//
//  Created by Kanyan Zheng on 2022/5/26.
//

import Foundation

public struct MyFeedItem {
    public init(uuid: UUID, imageNum: Int, medias: [MyMediaItem]) {
        self.uuid = uuid
        self.imageNum = imageNum
        self.medias = medias
    }
    
    public let uuid: UUID
    public let imageNum: Int
    public let medias: [MyMediaItem]
}

public struct MyMediaItem {
    public init(uuid: UUID, imageNum: Int) {
        self.uuid = uuid
        self.imageNum = imageNum
    }
    
    public let uuid: UUID
    public let imageNum: Int
}

public protocol MyFeedLoader {
    func load(completion: @escaping (Result<[MyFeedItem], Error>) -> Void)
}
