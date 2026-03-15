//
//  FormListViewModelIntegrationTests.swift
//  ChopiTests
//
//  Created by Oscar Gutierrez on 25/10/25.
//

import XCTest
@testable import Chopi

final class FormListViewModelIntegrationTests: XCTestCase {
    var viewModel: FormListViewModel!
    var databaseService: SDDatabaseService!

    override func setUp() {
        super.setUp()
        let expectation = XCTestExpectation(description: "Wait for database to load")
        Task { @MainActor in
            self.databaseService = SDDatabaseService()
            await self.clearDatabase()
            self.viewModel = FormListViewModel(self.databaseService)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    override func tearDown() {
        viewModel = nil
        databaseService = nil
        super.tearDown()
    }
    
    func testSaveNewList_NewList() async {
        let expectation = XCTestExpectation(description: "Save a new list to database")
        viewModel.name = "Test List"
        
        Task {
            viewModel.saveNewList {
                expectation.fulfill()
            }
        }
        await fulfillment(of: [expectation], timeout: 2.0)
        
        XCTAssertNil(viewModel.shoppingList)
        XCTAssertFalse(viewModel.loading)
    }
    
    func testSaveNewList_UpdateList() async {
        let saveExpectation = XCTestExpectation(description: "Save a new list in database")
        let updateExpectation = XCTestExpectation(description: "Update existing list in database")
        viewModel.name = "Test List"
        
        Task {
            viewModel.saveNewList {
                saveExpectation.fulfill()
            }
        }
        await fulfillment(of: [saveExpectation], timeout: 2.0)
        
        viewModel.name = "Updated Test List"
        viewModel.shoppingList = await databaseService.fetchLists().first
        
        Task {
            viewModel.saveNewList {
                updateExpectation.fulfill()
            }
        }
        await fulfillment(of: [updateExpectation], timeout: 2.0)
        viewModel.shoppingList = await databaseService.fetchLists().first
        
        XCTAssertNotNil(viewModel.shoppingList)
        XCTAssertEqual(viewModel.shoppingList!.name, "Updated Test List")
        XCTAssertFalse(viewModel.loading)
    }
    
    func testDeleteList() async {
        let saveExpectation = XCTestExpectation(description: "Save a new list in database")
        let deleteExpectation = XCTestExpectation(description: "Delete list from database")
        viewModel.name = "Test List"
        
        Task {
            viewModel.saveNewList {
                saveExpectation.fulfill()
            }
        }
        await fulfillment(of: [saveExpectation], timeout: 2.0)
        viewModel.shoppingList = await databaseService.fetchLists().first
        
        Task {
            viewModel.deleteList {
                deleteExpectation.fulfill()
            }
        }
        await fulfillment(of: [deleteExpectation], timeout: 2.0)
        viewModel.shoppingList = await databaseService.fetchLists().first
        
        XCTAssertNil(viewModel.shoppingList)
        XCTAssertFalse(viewModel.loading)
    }
    
    private func clearDatabase() async {
        let allList = await databaseService.fetchLists()
        for list in allList {
            _ = await databaseService.deleteList(list)
        }
    }
}
