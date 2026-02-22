//
//  FormItemViewTests.swift
//  ChopiTests
//
//  Created by Oscar Gutierrez on 12/11/25.
//

import XCTest
@testable import Chopi

final class FormItemViewModelTests: XCTestCase {
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
    
    func testValidateName_truncatesNameWhenExceedsCharacterLimit() {
        let list = ShoppingList(id: "1", name: "Test List", createdAt: Date(), itemCount: 0)
        viewModel = FormItemViewModel(StubDatabaseService(),shoppingList: list)
        viewModel.name = String(repeating: "a", count: 40)
        viewModel.validateName()
        
        XCTAssertEqual(viewModel.name.count, 30)
    }
    
    func testValidateName_doesNotModifyNameWhenWithinCharacterLimit() {
        let list = ShoppingList(id: "1", name: "Test List", createdAt: Date(), itemCount: 0)
        let originalName = "Valid Name"
        viewModel = FormItemViewModel(StubDatabaseService(), shoppingList: list)
        viewModel.name = originalName
        viewModel.validateName()
        
        XCTAssertEqual(viewModel.name, originalName)
        XCTAssertEqual(viewModel.name.count, 10)
    }
    
    func testValidateName_handlesEmptyNamesCorrectly() {
        let list = ShoppingList(id: "1", name: "Test List", createdAt: Date(), itemCount: 0)
        viewModel = FormItemViewModel(StubDatabaseService(), shoppingList: list)
        viewModel.name = ""
        viewModel.validateName()
        
        XCTAssertEqual(viewModel.name, "")
        XCTAssertEqual(viewModel.name.count, 0)
    }
    
    func testSaveNewItem_NewItem() async {
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
    
    func testSaveNewItem_UpdateItem() async {
        let expectation = XCTestExpectation(description: "Update item in database")
        let list = ShoppingList(id: "1", name: "Test List", createdAt: Date(), itemCount: 0)
        let item = Item(id: "1", name: "Test Item", quantity: 1, isPurchased: false, createdAt: Date(), listId: list.id)
        viewModel = FormItemViewModel(MockDatabaseService(), shoppingList: list, item: item)
        
        Task {
            viewModel.saveNewItem {
                expectation.fulfill()
            }
        }
        await fulfillment(of: [expectation], timeout: 1.0)
        
        XCTAssertNotNil(viewModel.item)
        XCTAssertEqual(viewModel.name, item.name)
        XCTAssertFalse(viewModel.loading)
    }

}
