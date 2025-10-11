//
//  MockShoppingListService.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 28/09/25.
//

import Foundation

class MockDatabaseService: DatabaseServiceProtocol {
    var fetchListsResult: [ShoppingList] = [
        ShoppingList(id: "1", name: "Lista 1", createdAt: Date()),
        ShoppingList(id: "2", name: "Lista 2", createdAt: Date())
    ]
    
    var saveListResult: Bool = true
    var updateListResult: Bool = true
    var deleteListResult: Bool = true
    
    func fetchLists() async -> [ShoppingList] {
        return fetchListsResult
    }
    
    func saveList(_ list: ShoppingList) async -> Bool {
        fetchListsResult.append(list)
        return saveListResult
    }
    
    func updateList(_ list: ShoppingList) async -> Bool {
        return updateListResult
    }
    
    func deleteList(_ list: ShoppingList) async -> Bool {
        return deleteListResult
    }
    
    
}
