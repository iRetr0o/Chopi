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
    
    func testDeleteList_RemovesList() async {
        let list = ShoppingList(id: "1", name: "Test List", createdAt: Date(), itemCount: 0)
        _ = await self.databaseService.saveList(list)
        
        let deletedList = await self.databaseService.deleteList(list)
        XCTAssertTrue(deletedList)
    }
    
    func testDeleteList_RemovesAssociatedItems() async {
        let list = ShoppingList(id: "1", name: "Test List with items", createdAt: Date(), itemCount: 0)
        _ = await self.databaseService.saveList(list)
        
        let item = Item(id: "1", name: "Test Item", quantity: 1, isPurchased: false, createdAt: Date(), listId: list.id)
        _ = await self.databaseService.saveItem(item)
        
        let deletedList = await self.databaseService.deleteList(list)
        XCTAssertTrue(deletedList)
        
        let remainingItems = await self.databaseService.fetchItems(for: list.id)
        XCTAssertTrue(remainingItems.isEmpty)
    }
    
    func testFetchItems() async {
        let list = ShoppingList(id: "1", name: "Test List", createdAt: Date(), itemCount: 0)
        _ = await self.databaseService.saveList(list)
        
        let item = Item(id: "1", name: "Test Item 1", quantity: 1, isPurchased: false, createdAt: Date(), listId: list.id)
        _ = await self.databaseService.saveItem(item)
        
        let fetchItems = await self.databaseService.fetchItems(for: list.id)
        XCTAssertGreaterThan(fetchItems.count, 0)
    }
    
    func testSaveItem() async {
        let list = ShoppingList(id: "1", name: "Test List", createdAt: Date(), itemCount: 0)
        _ = await self.databaseService.saveList(list)
        
        let item = Item(id: "1", name: "Test Item", quantity: 1, isPurchased: true, createdAt: Date(), listId: list.id)
        let success = await self.databaseService.saveItem(item)
        XCTAssertTrue(success)

        let fetchedItem = await databaseService.fetchItems(for: list.id)
        XCTAssertTrue(fetchedItem.contains { $0.id == item.id })
    }
    
    func testUpdateItem() async {
        let list = ShoppingList(id: "1", name: "Test List", createdAt: Date(), itemCount: 0)
        _ = await self.databaseService.saveList(list)
        
        let item = Item(id: "1", name: "Test Item", quantity: 1, isPurchased: false, createdAt: Date(), listId: list.id)
        _ = await self.databaseService.saveItem(item)
        
        let updatedItem = Item(id: item.id, name: "Updated Test Item", quantity: 2, isPurchased: true, createdAt: item.createdAt, listId: item.listId)
        let success = await self.databaseService.updateItem(updatedItem)
        XCTAssertTrue(success)
        
        let fetchedItem = await databaseService.fetchItems(for: list.id)
        XCTAssertTrue(fetchedItem.contains { $0.id == updatedItem.id && $0.name == updatedItem.name && $0.quantity == updatedItem.quantity && $0.isPurchased == updatedItem.isPurchased })
    }
    
    private func clearDatabase() async {
        let allList = await databaseService.fetchLists()
        for list in allList {
            _ = await self.databaseService.deleteList(list)
        }
    }
}
