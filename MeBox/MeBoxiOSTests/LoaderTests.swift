//
//  LoaderTests.swift
//  MeBoxiOSTests
//
//  Created by Kanyan Zheng on 2022/8/27.
//

import Foundation
import XCTest

class LoaderWithBlock {
    private let block: (Int, @escaping (Int) -> Void) -> Void
    
    init(block: @escaping (Int, @escaping (Int) -> Void) -> Void) {
        self.block = block
    }
    
    func load(_ number: Int, completion: @escaping (Int) -> Void) {
        block(number, completion)
    }
}

class LoaderTests: XCTestCase {
    
    func test_shouldNotGetMultipleCallWhenRequestLoadingTwice() {
        let (sut, client) = makeSUT()
        expect(sut, loadWithNumber: 1, completeWithNumber: 1) {
            <#code#>
        }
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> (sut: LoaderWithBlock, client: ClientSpy) {
        let client = ClientSpy()
        let sut = LoaderWithBlock(block: client.getSomething)
        
        return (sut, client)
    }
    
    private func expect(_ sut: LoaderWithBlock,
                        loadWithNumber number: Int,
                        completeWithNumber expectedNumber: Int,
                        when action: () -> Void) {
        let exp = expectation(description: "Wait for load completion")
        sut.load(number) { receivedNumber in
            XCTAssertEqual(receivedNumber, expectedNumber)
            exp.fulfill()
        }
        
        action()
        wait(for: [exp], timeout: 1.0)
    }
    
    private class ClientSpy {
        
        private var messages = [(number: Int, completion: (Int) -> Void)]()
        
        func getSomething(_ number: Int, completion: @escaping (Int) -> Void) {
            messages.append((number, completion))
        }
        
        func completeWith(_ number: Int, at index: Int = 0) {
            messages[index].completion(number)
        }
    }
}
