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
    
    func testSaveNewList() async {
        viewModel.name = "Test List"
        let expectation = XCTestExpectation(description: "Save a new list to database")
        
        Task {
            viewModel.saveNewList {
                expectation.fulfill()
            }
        }
        await fulfillment(of: [expectation], timeout: 2.0)
        XCTAssertFalse(viewModel.loading)
    }
    
    private func clearDatabase() async {
        let allList = await databaseService.fetchLists()
        for list in allList {
            _ = await databaseService.deleteList(list)
        }
    }
}
