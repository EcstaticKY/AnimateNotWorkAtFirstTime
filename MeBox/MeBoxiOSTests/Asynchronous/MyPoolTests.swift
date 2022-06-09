//
//  MyPoolTests.swift
//  MeBoxiOSTests
//
//  Created by Kanyan Zheng on 2022/6/9.
//

import XCTest

struct MyTask {
    let uuid: UUID
}

class MyPool {
    private let serialQueue = DispatchQueue(label: "\(MyPool.self)Queue")
    
    var tasks = [MyTask]()
    
    func enqueue(task: MyTask) {
        serialQueue.async { [weak self] in
            guard let self = self else { return }
            
            self.tasks.append(task)
            
            // Simulate costly operation
            (0..<1000).forEach { print("kjdfkjdkfjdkfjkdf \(self) \($0)") }
        }
    }
    
    func dequeue() -> MyTask? {
        var task: MyTask?
        serialQueue.sync {
            task = tasks.popLast()
        }
        return task
    }
}

class MyPoolTests: XCTestCase {
    func test_enqueues() {
        let sut = MyPool()
        trackForMemoryLeaks(sut)
        let uuid = UUID()
        
        sut.enqueue(task: MyTask(uuid: uuid))
        let task = sut.dequeue()
        
        XCTAssertEqual(task!.uuid, uuid)
    }
}
