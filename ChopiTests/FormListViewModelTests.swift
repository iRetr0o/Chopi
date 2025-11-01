//
//  FormListViewModelTests.swift
//  ChopiTests
//
//  Created by Oscar Gutierrez on 22/10/25.
//

import XCTest
@testable import Chopi

final class FormListViewModelTests: XCTestCase {
    var viewModel: FormListViewModel!
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
        viewModel = FormListViewModel(StubDatabaseService())
        viewModel.name = String(repeating: "a", count: 60)
        viewModel.validateName()
        
        XCTAssertEqual(viewModel.name.count, 50)
    }
    
    func testValidateName_doesNotModifyNameWhenWithinCharacterLimit() {
        viewModel = FormListViewModel(StubDatabaseService())
        let originalName = "Valid Name"
        viewModel.name = originalName
        viewModel.validateName()
        
        XCTAssertEqual(viewModel.name, originalName)
        XCTAssertEqual(viewModel.name.count, 10)
    }
    
    func testValidateName_handlesEmptyNamesCorrectly() {
        viewModel = FormListViewModel(StubDatabaseService())
        viewModel.name = ""
        viewModel.validateName()
        
        XCTAssertEqual(viewModel.name, "")
        XCTAssertEqual(viewModel.name.count, 0)
    }
    
    func testSaveNewList_NewList() async {
        let expectation = XCTestExpectation(description: "Save new list in database")
        viewModel = FormListViewModel(mockDatabaseService)
        viewModel.name = "Test List"
        
        Task {
            viewModel.saveNewList {
                expectation.fulfill()
            }
        }
        await fulfillment(of: [expectation], timeout: 1.0)
        
        XCTAssertNil(viewModel.shoppingList)
        XCTAssertFalse(viewModel.loading)
    }
    
    func testSaveNewList_UpdateList() async {
        let expectation = XCTestExpectation(description: "Update list in database")
        let list = ShoppingList(id: "1", name: "Test List", createdAt: Date(), itemCount: 2)
        viewModel = FormListViewModel(mockDatabaseService, shoppingList: list)
        
        Task {
            viewModel.saveNewList {
                expectation.fulfill()
            }
        }
        await fulfillment(of: [expectation], timeout: 1.0)
        
        XCTAssertNotNil(viewModel.shoppingList)
        XCTAssertEqual(viewModel.name, list.name)
        XCTAssertFalse(viewModel.loading)
    }
}
