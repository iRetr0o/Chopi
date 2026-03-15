//
//  HomeViewModelIntegrationTests.swift
//  ChopiTests
//
//  Created by Oscar Gutierrez on 21/10/25.
//

import XCTest
@testable import Chopi

final class HomeViewModelIntegrationTests: XCTestCase {
    var viewModel: HomeViewModel!
    var databaseService: SDDatabaseService!
    
    override func setUp() {
        super.setUp()
        let expectation = XCTestExpectation(description: "Wait for database to load")
        Task { @MainActor in
            self.databaseService = SDDatabaseService()
            await self.clearDatabase()
            self.viewModel = HomeViewModel(self.databaseService)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.databaseService = nil
        super.tearDown()
    }
    
    func testGetList() async {
        let expectation = XCTestExpectation(description: "Fetch list from database")
        Task {
            viewModel.getShoppingLists()
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 2.0)
        XCTAssertNotNil(viewModel.shoppingLists, "Shopping lists should not be nil")
    }
    
    private func clearDatabase() async {
        let allList = await databaseService.fetchLists()
        for list in allList {
            _ = await databaseService.deleteList(list)
        }
    }

}
