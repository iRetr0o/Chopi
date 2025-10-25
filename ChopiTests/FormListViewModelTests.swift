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
    
    func testSaveNewList() async {
        viewModel = FormListViewModel(mockDatabaseService)
        viewModel.name = "Test List"
        let expectation = XCTestExpectation(description: "Save new list in database")
        
        Task {
            viewModel.saveNewList {
                expectation.fulfill()
            }
        }
        await fulfillment(of: [expectation], timeout: 1.0)
        XCTAssertFalse(viewModel.loading)
    }
}
