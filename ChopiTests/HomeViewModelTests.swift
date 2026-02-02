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
    
    func testNewList() {
        viewModel = HomeViewModel(stubDatabaseService)
        
        viewModel.newList()
        
        XCTAssertNotNil(viewModel.sheet, "Sheet should not be nil")
        XCTAssertEqual(viewModel.sheet, .newList)
    }
    
    func testUpdateList() {
        viewModel = HomeViewModel(stubDatabaseService)
        let list = ShoppingList(id: "1", name: "Test List", createdAt: Date(), itemCount: 0)
        
        viewModel.updateList(list)
        
        XCTAssertNotNil(viewModel.sheet, "Sheet should not be nil")
        XCTAssertEqual(viewModel.sheet, .updateList(list))
    }
    
    func testGoToDetail() {
        viewModel = HomeViewModel(stubDatabaseService)
        let list = ShoppingList(id: "1", name: "Test List", createdAt: Date(), itemCount: 0)
        
        viewModel.goToDetail(list)
        
        XCTAssertEqual(viewModel.path.count, 1, "Navigation path should have one entry")
        XCTAssertEqual(viewModel.path.first, .listDetail(list), "Path should contain the correct list detail route")
    }
}
