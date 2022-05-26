//
//  MyFeedTestHelpers.swift
//  MeBoxiOSTests
//
//  Created by Kanyan Zheng on 2022/5/26.
//

import Foundation
import MeBoxiOS

func uniqueMyFeedItem(_ num: Int) -> MyFeedItem {
    let media0 = MyMediaItem(uuid: UUID(), imageNum: 0)
    let media1 = MyMediaItem(uuid: UUID(), imageNum: 1)
    
    return MyFeedItem(uuid: UUID(), imageNum: num, medias: [media0, media1])
}
