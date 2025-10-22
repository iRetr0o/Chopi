//
//  HomeViewModelTests.swift
//  ChopiTests
//
//  Created by Oscar Gutierrez on 21/10/25.
//

import XCTest
@testable import Chopi

final class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
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
    
    func testGetLists() async {
        viewModel = HomeViewModel(mockDatabaseService)
        let expectation = XCTestExpectation(description: "Fetch lists from database")
        Task {
            viewModel.getShoppingLists()
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 1.0)
        XCTAssert(viewModel.shoppingLists.count == 2)
    }
}
