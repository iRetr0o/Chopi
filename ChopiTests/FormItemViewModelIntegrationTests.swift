//
//  FormItemViewModelIntegrationTests.swift
//  ChopiTests
//
//  Created by Oscar Gutierrez on 12/11/25.
//

import XCTest
@testable import Chopi

final class FormItemViewModelIntegrationTests: XCTestCase {
    var viewModel: FormItemViewModel!
    var databaseService: SDDatabaseService!
    let list = ShoppingList(id: "1", name: "Test List", createdAt: Date(), itemCount: 0)

    override func setUp() {
        super.setUp()
        let expectation = XCTestExpectation(description: "Wait for database to load")
        Task { @MainActor in
            self.databaseService = SDDatabaseService()
            await self.clearDatabase()
            self.viewModel = FormItemViewModel(self.databaseService, shoppingList: list)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    override func tearDown() {
        viewModel = nil
        databaseService = nil
        super.tearDown()
    }
    
    func testSaveNewItem_NewItem() async {
        let expectation = XCTestExpectation(description: "Save new item on database")
        let listExpectation = XCTestExpectation(description: "Save the list on database")
        viewModel.name = "Test Item"
        viewModel.quantity = 1
        viewModel.isPurchased = false
        
        Task {
            _ = await self.databaseService.saveList(list)
            listExpectation.fulfill()
        }
        await fulfillment(of: [listExpectation], timeout: 2.0)
        
        Task {
            viewModel.saveNewItem {
                expectation.fulfill()
            }
        }
        await fulfillment(of: [expectation], timeout: 2.0)
        
        XCTAssertNil(viewModel.item)
        XCTAssertFalse(viewModel.loading)
    }
    
    func testSaveNewItem_UpdateItem() async {
        let saveExpectation = XCTestExpectation(description: "Save new item on database")
        let updateExpectation = XCTestExpectation(description: "Update item on database")
        let listExpectation = XCTestExpectation(description: "Save the list on database")
        viewModel.name = "Test Item"
        viewModel.quantity = 1
        viewModel.isPurchased = false
        
        Task {
            _ = await self.databaseService.saveList(list)
            listExpectation.fulfill()
        }
        await fulfillment(of: [listExpectation], timeout: 2.0)
        
        Task {
            viewModel.saveNewItem {
                saveExpectation.fulfill()
            }
        }
        await fulfillment(of: [saveExpectation], timeout: 2.0)
        
        viewModel.name = "Updated Test Item"
        viewModel.item = await databaseService.fetchItems(for: list.id).first
        
        Task {
            viewModel.saveNewItem {
                updateExpectation.fulfill()
            }
        }
        await fulfillment(of: [updateExpectation], timeout: 2.0)
        viewModel.item = await databaseService.fetchItems(for: list.id).first
        
        XCTAssertNotNil(viewModel.item)
        XCTAssertEqual(viewModel.item!.name, "Updated Test Item")
        XCTAssertFalse(viewModel.loading)
    }
    
    private func clearDatabase() async {
        let allList = await databaseService.fetchLists()
        for list in allList {
            _ = await databaseService.deleteList(list)
        }
    }

}
