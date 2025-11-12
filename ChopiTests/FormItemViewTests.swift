//
//  FormItemViewTests.swift
//  ChopiTests
//
//  Created by Oscar Gutierrez on 12/11/25.
//

import XCTest
@testable import Chopi

final class FormItemViewTests: XCTestCase {
    var viewModel: FormItemViewModel!
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
    
    func testSaveNewItem() async {
        let expectation = XCTestExpectation(description: "Save new item in database")
        let list = ShoppingList(id: "1", name: "Test List", createdAt: Date(), itemCount: 0)
        viewModel = FormItemViewModel(MockDatabaseService(), shoppingList: list)
        viewModel.name = "Test Item"
        viewModel.quantity = 1
        viewModel.isPurchased = false
        
        Task {
            viewModel.saveNewItem {
                expectation.fulfill()
            }
        }
        await fulfillment(of: [expectation], timeout: 1.0)
        
        XCTAssertNil(viewModel.item)
        XCTAssertFalse(viewModel.loading)
    }

}
