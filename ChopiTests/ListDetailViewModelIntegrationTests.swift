//
//  ListDetailViewModelIntegrationTests.swift
//  ChopiTests
//
//  Created by Oscar Gutierrez on 08/11/25.
//

import XCTest
@testable import Chopi

final class ListDetailViewModelIntegrationTests: XCTestCase {
    var viewModel: ListDetailViewModel!
    var databaseService: SDDatabaseService!
    let list = ShoppingList(id: "1", name: "Test List", createdAt: Date(), itemCount: 0)
    
    override func setUp() {
        super.setUp()
        let expectation = XCTestExpectation(description: "Wait for database to load")
        Task { @MainActor in
            self.databaseService = SDDatabaseService()
            await self.clearDatabase()
            self.viewModel = ListDetailViewModel(databaseService, shoppingList: list)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.databaseService = nil
        super.tearDown()
    }
    
    func testGetItems() async {
        let expectation = XCTestExpectation(description: "Fetched items from database")
        
        Task {
            viewModel.getItems()
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 2.0)
        
        XCTAssertNotNil(viewModel.items, "Items should not be nil")
        XCTAssertEqual(viewModel.items.count, 0, "Items count should be 0")
    }
    
    func testUpdateItemStatus() async {
        let expectation = XCTestExpectation(description: "Update status from item")
        let item = Item(id: "1", name: "Purchased Item", quantity: 1, isPurchased: false, createdAt: Date(), listId: "1")
        
        viewModel.item = item
        viewModel.items = [item]
        
        _ = await databaseService.saveList(list)
        _ = await databaseService.saveItem(item)
        
        Task {
            viewModel.updateItemStatus()
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 2.0)
        
        viewModel.items = await databaseService.fetchItems(for: list.id)
        
        XCTAssertTrue(viewModel.items.first!.isPurchased, "Item status should be true")
        XCTAssertNil(viewModel.loadingItem)
    }
    
    private func clearDatabase() async {
        let allList = await databaseService.fetchLists()
        for list in allList {
            _ = await databaseService.deleteList(list)
        }
    }
}
