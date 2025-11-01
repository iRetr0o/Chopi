//
//  SDDatabaseServiceTests.swift
//  ChopiTests
//
//  Created by Oscar Gutierrez on 21/10/25.
//

import XCTest
@testable import Chopi

final class SDDatabaseServiceTests: XCTestCase {
    var databaseService: SDDatabaseService!
    
    override func setUp() {
        super.setUp()
        let expectation = XCTestExpectation(description: "Wait for database to load")
        
        Task { @MainActor in
            self.databaseService = SDDatabaseService()
            await self.clearDatabase()
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    override func tearDown() {
        self.databaseService = nil
        super.tearDown()
    }
    
    func testFetchLists() async {
        let list = ShoppingList(id: UUID().uuidString, name: "Fetch List", createdAt: Date(), itemCount: 0)
        _ = await self.databaseService.saveList(list)
        
        let fetchedList = await self.databaseService.fetchLists()
        XCTAssertGreaterThan(fetchedList.count, 0, "There should be at least one shopping list fetched")
    }
    
    func testSaveList() async {
        let list = ShoppingList(id: UUID().uuidString, name: "Test List", createdAt: Date(), itemCount: 0)
        let success = await self.databaseService.saveList(list)
        XCTAssertTrue(success)
        
        let fetchedList = await databaseService.fetchLists()
        XCTAssertTrue(fetchedList.contains { $0.id == list.id })
    }
    
    func testUpdateList() async {
        let list = ShoppingList(id: UUID().uuidString, name: "Test List", createdAt: Date(), itemCount: 0)
        _ = await self.databaseService.saveList(list)
        
        let updatedList = ShoppingList(id: list.id, name: "Updated Test List", createdAt: list.createdAt, itemCount: list.itemCount)
        let updateSuccess = await self.databaseService.saveList(updatedList)
        XCTAssertTrue(updateSuccess)
        
        let fetchedList = await databaseService.fetchLists()
        XCTAssertTrue(fetchedList.contains { $0.id == updatedList.id && $0.name == updatedList.name })
    }
    
    private func clearDatabase() async {
        let allList = await databaseService.fetchLists()
        for list in allList {
            _ = await self.databaseService.deleteList(list)
        }
    }
}
