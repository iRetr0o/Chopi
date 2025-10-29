//
//  ListDetailViewModelTests.swift
//  ChopiTests
//
//  Created by Oscar Gutierrez on 25/10/25.
//

import XCTest
@testable import Chopi

final class ListDetailViewModelTests: XCTestCase {
    var viewModel: ListDetailViewModel!
    var mockDatabaseService: MockDatabaseService!
    var stubDatabaseService: StubDatabaseService!
    
    override func setUp() {
        super.setUp()
        mockDatabaseService = MockDatabaseService()
        stubDatabaseService = StubDatabaseService()
    }
    
    override func tearDown() {
        viewModel = nil
        mockDatabaseService = nil
        stubDatabaseService = nil
        super.tearDown()
    }
    
    func testGetItems() async {
        let list = ShoppingList(id: "1", name: "Test List", createdAt: Date(), itemCount: 2)
        viewModel = ListDetailViewModel(mockDatabaseService, shoppingList: list)
        let expectation = XCTestExpectation(description: "Fetched Items from database")
        
        Task {
            viewModel.getItems()
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 1.0)
        
        XCTAssertEqual(viewModel.items.count, 2)
        XCTAssertFalse(viewModel.loading)
    }
    
    func testUpdateItemStatus() async {
        let expectation = XCTestExpectation(description: "Updated Item in database")
        let list = ShoppingList(id: "1", name: "Test List", createdAt: Date(), itemCount: 2)
        let item = Item(id: "1", name: "Test Item", quantity: 1, isPurchased: false, createdAt: Date(), listId: list.id)
        let items = [item]
        viewModel = ListDetailViewModel(mockDatabaseService, shoppingList: list)
        viewModel.items = items
        viewModel.item = item
        
        Task {
            viewModel.updateItemStatus()
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 1.0)
        
        XCTAssertNotNil(viewModel.item)
        XCTAssertNotNil(viewModel.items.first)
        XCTAssertTrue(viewModel.items.first!.isPurchased)
        XCTAssertFalse(viewModel.loading)
    }
}
