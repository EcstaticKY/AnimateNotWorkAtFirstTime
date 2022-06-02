//
//  MyFeedUITests.swift
//  MeBoxiOSTests
//
//  Created by Kanyan Zheng on 2022/5/26.
//

import UIKit
import XCTest
import MeBoxiOS
import MeBox

class MyFeedUITests: XCTestCase {
    func test_userIniatedReload_loadFeedFromLoader() {
        let (sut, feedLoader, _) = makeSUT()
        XCTAssertEqual(feedLoader.loadCallCount, 0)
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(feedLoader.loadCallCount, 1)
        
        sut.simulateUserInitiatedFeedReload()
        XCTAssertEqual(feedLoader.loadCallCount, 2)
        
        sut.simulateUserInitiatedFeedReload()
        XCTAssertEqual(feedLoader.loadCallCount, 3)
    }
    
    func test_loadingIndicator_isVisibleWhileLoading() {
        let (sut, feedLoader, _) = makeSUT()
        
        sut.loadViewIfNeeded()
        XCTAssertTrue(sut.isShowingLoadingIndicator)
        
        feedLoader.completeLoadingWith([], at: 0)
        XCTAssertFalse(sut.isShowingLoadingIndicator)
        
        sut.simulateUserInitiatedFeedReload()
        XCTAssertTrue(sut.isShowingLoadingIndicator)
        
        feedLoader.completeLoadingWithError(anyNSError(), at: 0)
        XCTAssertFalse(sut.isShowingLoadingIndicator)
    }
    
    func test_loadingCompletion_rendersFeed() {
        let (sut, feedLoader, _) = makeSUT()
        let item0 = uniqueMyFeedItem(0)
        let item1 = uniqueMyFeedItem(1)
        
        sut.loadViewIfNeeded()
        feedLoader.completeLoadingWith([], at: 0)
        XCTAssertEqual(sut.numberOfRenderedFeedItemViews(), 0)
        
        sut.simulateUserInitiatedFeedReload()
        feedLoader.completeLoadingWith([item0, item1], at: 1)
        XCTAssertEqual(sut.numberOfRenderedFeedItemViews(), 2)
        
        sut.simulateUserInitiatedFeedReload()
        feedLoader.completeLoadingWithError(anyNSError(), at: 2)
        XCTAssertEqual(sut.numberOfRenderedFeedItemViews(), 2)
        
        sut.simulateUserInitiatedFeedReload()
        feedLoader.completeLoadingWith([], at: 2)
        XCTAssertEqual(sut.numberOfRenderedFeedItemViews(), 0)
    }
    
    func test_cellVisible_loadsImageData() {
        let (sut, feedLoader, imageLoader) = makeSUT()
        let item0 = uniqueMyFeedItem(0)
        let item1 = uniqueMyFeedItem(1)

        sut.loadViewIfNeeded()
        feedLoader.completeLoadingWith([item0, item1], at: 0)
        XCTAssertEqual(imageLoader.loadMessages, [])

        XCTAssertNotNil(sut.simulateItemCellVisible(at: 0))
        XCTAssertNotNil(sut.simulateItemCellVisible(at: 1))
        XCTAssertEqual(imageLoader.loadMessages, [item0.imageNum, item1.imageNum])
    }
    
    func test_loadingImageDataCompletion_showsDownloadedImage() {
        let (sut, feedLoader, imageLoader) = makeSUT()
        let item0 = uniqueMyFeedItem(0)
        let item1 = uniqueMyFeedItem(1)
        let image0 = UIImage.make(withColor: .red)
        let image1 = UIImage.make(withColor: .blue)

        sut.loadViewIfNeeded()
        feedLoader.completeLoadingWith([item0, item1], at: 0)

        let cell0 = sut.simulateItemCellVisible(at: 0)
        let cell1 = sut.simulateItemCellVisible(at: 1)
        
        imageLoader.completeLoadingWithImageData(image0.pngData()!, at: 0)
        XCTAssertEqual(cell0?.topImageView.image?.pngData(), image0.pngData())
        
        imageLoader.completeLoadingWithImageData(image1.pngData()!, at: 1)
        XCTAssertEqual(cell1?.topImageView.image?.pngData(), image1.pngData())
    }
    
    func test_loadsImageData_animatingShimmeringViewWhileLoading() {
        let (sut, feedLoader, imageLoader) = makeSUT()
        let item0 = uniqueMyFeedItem(0)
        let item1 = uniqueMyFeedItem(1)
        let image0 = UIImage.make(withColor: .red)
        let image1 = UIImage.make(withColor: .blue)

        sut.loadViewIfNeeded()
        feedLoader.completeLoadingWith([item0, item1], at: 0)

        let cell0 = sut.simulateItemCellVisible(at: 0)
        XCTAssertEqual(cell0?.isLoadingImageData, true)
        
        let cell1 = sut.simulateItemCellVisible(at: 1)
        XCTAssertEqual(cell0?.isLoadingImageData, true)
        XCTAssertEqual(cell1?.isLoadingImageData, true)
        
        imageLoader.completeLoadingWithImageData(image0.pngData()!, at: 0)
        XCTAssertEqual(cell0?.isLoadingImageData, false)
        XCTAssertEqual(cell1?.isLoadingImageData, true)
        
        imageLoader.completeLoadingWithImageData(image1.pngData()!, at: 1)
        XCTAssertEqual(cell0?.isLoadingImageData, false)
        XCTAssertEqual(cell1?.isLoadingImageData, false)
    }
    
    func test_getTableViewCell() {
        let (sut, feedLoader, _) = makeSUT()
        let item0 = uniqueMyFeedItem(0)
        let item1 = uniqueMyFeedItem(1)
        
        sut.loadViewIfNeeded()
        feedLoader.completeLoadingWith([item0, item1], at: 0)
        
//        sut.simulateItemCellVisible(at: 0)
        let cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        // Can get table cell even the cell is not visible before calling `cellForRow` method
        XCTAssertNotNil(cell)
    }
    
    func test_getCollectionCellInTableViewCell() throws {
        let (sut, feedLoader, _) = makeSUT()
        let item0 = uniqueMyFeedItem(0)
        let item1 = uniqueMyFeedItem(1)
        
        // set a frame that's enough to render the cells on screen
        sut.view.frame = CGRect(x: 0, y: 0, width: 475, height: 900)
        // also, since we're accessing the sut.view for the first time here, it'll also call viewDidLoad automatically so we don't need to call `loadViewIfNeeded()` in this test
        
        // complete the request with the models to render the cell on screen
        feedLoader.completeLoadingWith([item0, item1], at: 0)
        
        // force the view to layout itself (which should render the cells too)
        sut.view.layoutIfNeeded()
        
        // now that cells should be rendered, you can get the cells at index path directly through the tableview/collection view APIs (not through the data source)
        let itemCell = try XCTUnwrap(sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? MyFeedItemCell)
        
        let collectionCell = itemCell.collectionView.cellForItem(at: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(collectionCell, "Expected can get collection cell after making the collection cell visible")
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (MyFeedViewController, FeedLoaderSpy, ImageLoaderSpy) {
        let feedLoader = FeedLoaderSpy()
        let imageLoader = ImageLoaderSpy()
        let sut = MyFeedViewController(feedLoader: feedLoader, imageLoader: imageLoader)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(feedLoader, file: file, line: line)
        trackForMemoryLeaks(imageLoader, file: file, line: line)
        
        return (sut, feedLoader, imageLoader)
    }
    
    private class FeedLoaderSpy: MyFeedLoader {
        var loadCallCount: Int { messages.count }
        
        private var messages = [(Result<[MyFeedItem], Error>) -> Void]()
        
        func load(completion: @escaping (Result<[MyFeedItem], Error>) -> Void) {
            messages.append(completion)
        }
        
        func completeLoadingWith(_ feed: [MyFeedItem], at index: Int) {
            messages[index](.success(feed))
        }
        
        func completeLoadingWithError(_ error: Error, at index: Int) {
            messages[index](.failure(error))
        }
    }
    
    private class ImageLoaderSpy: MyImageDataLoader {
        var loadMessages = [Int]()
        var cancelMessages = [Int]()
        
        private var completions = [(Result<Data, Error>) -> Void]()
        
        private class TaskSpy: MyImageDataLoaderTask {
            private let cancelBlock: () -> Void
            
            init(cancelBlock: @escaping () -> Void) {
                self.cancelBlock = cancelBlock
            }
            
            func cancel() {
                cancelBlock()
            }
        }
        
        func loadWithNum(_ imageNum: Int, completion: @escaping (Result<Data, Error>) -> Void) -> MyImageDataLoaderTask {
            
            loadMessages.append(imageNum)
            completions.append(completion)
            let task = TaskSpy {
                self.cancelMessages.append(imageNum)
            }
            return task
        }
        
        func completeLoadingWithImageData(_ imageData: Data, at index: Int) {
            completions[index](.success(imageData))
        }
        
        func completeLoadingWithError(_ error: Error, at index: Int) {
            completions[index](.failure(error))
        }
    }
    
    private func anyNSError() -> NSError {
        NSError(domain: "test", code: 0)
    }
}

extension MyFeedViewController {
    func simulateUserInitiatedFeedReload() {
        refreshControl?.simulatePullToRefresh()
    }
    
    var isShowingLoadingIndicator: Bool {
        refreshControl?.isRefreshing == true
    }
    
    func numberOfRenderedFeedItemViews() -> Int {
        (tableView.dataSource?.numberOfSections?(in: tableView))!
    }
    
    @discardableResult
    func simulateItemCellVisible(at index: Int) -> MyFeedItemCell? {
        tableView.dataSource?.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: index)) as? MyFeedItemCell
    }
}

extension MyFeedItemCell {
    var isLoadingImageData: Bool {
        shimmeringView.isShimmering
    }
}
