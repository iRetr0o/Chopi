//
//  MockShoppingListService.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 28/09/25.
//

import Foundation

class MockDatabaseService: DatabaseServiceProtocol {
    var fetchListsResult: [ShoppingList] = [
        ShoppingList(id: "1", name: "Lista 1", createdAt: Date(), itemCount: 2),
        ShoppingList(id: "2", name: "Lista 2", createdAt: Date(), itemCount: 1)
    ]
    
    var fetchItemsResult: [Item] = [
        Item(id: "1", name: "Producto 1", quantity: 5, isPurchased: false, createdAt: Date(), listId: "1"),
        Item(id: "2", name: "Producto 2", quantity: 1, isPurchased: true, createdAt: Date(), listId: "1"),
        Item(id: "2", name: "Producto 2", quantity: 1, isPurchased: true, createdAt: Date(), listId: "2")
    ]
    
    var saveListResult: Bool = true
    var updateListResult: Bool = true
    var deleteListResult: Bool = true
    var saveItemResult: Bool = true
    var updateItemResult: Bool = true
    var deleteItemResult: Bool = true
    
    func fetchLists() async -> [ShoppingList] {
        return fetchListsResult
    }
    
    func saveList(_ list: ShoppingList) async -> Bool {
        return saveListResult
    }
    
    func updateList(_ list: ShoppingList) async -> Bool {
        return updateListResult
    }
    
    func deleteList(_ list: ShoppingList) async -> Bool {
        return deleteListResult
    }
    
    func fetchItems(for listId: String) async -> [Item] {
        return fetchItemsResult.filter { $0.listId == listId }
    }
    
    func saveItem(_ item: Item) async -> Bool {
        return saveItemResult
    }
    
    func updateItem(_ item: Item) async -> Bool {
        return updateItemResult
    }
    
    func deleteItem(_ item: Item) async -> Bool {
        return deleteItemResult
    }
}
