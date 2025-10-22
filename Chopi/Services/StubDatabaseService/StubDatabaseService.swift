//
//  StubDatabaseService.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 21/10/25.
//

import Foundation

class StubDatabaseService: DatabaseServiceProtocol {
    func fetchLists() async -> [ShoppingList] {
        return []
    }
    
    func saveList(_ list: ShoppingList) async -> Bool {
        return false
    }
    
    func updateList(_ list: ShoppingList) async -> Bool {
        return false
    }
    
    func deleteList(_ list: ShoppingList) async -> Bool {
        return false
    }
    
    func fetchItems(for listId: String) async -> [Item] {
        return []
    }
    
    func saveItem(for listId: String, item: Item) async -> Bool {
        return false
    }
    
    func updateItem(_ item: Item) async -> Bool {
        return false
    }
    
    func deleteItem(_ item: Item) async -> Bool {
        return false
    }
    
    
}
