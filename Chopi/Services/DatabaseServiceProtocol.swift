//
//  DatabaseServiceProtocol.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 28/09/25.
//

import Foundation

protocol DatabaseServiceProtocol {
    // MARK: - Shopping Lists
    func fetchLists() async -> [ShoppingList]
    func saveList(_ list: ShoppingList) async -> Bool
    func updateList(_ list: ShoppingList) async -> Bool
    func deleteList(_ list: ShoppingList) async -> Bool
    
    // MARK: - Items
    func fetchItems(for listId: String) async -> [Item]
    func saveItem(for listId: String, item: Item) async -> Bool
    func updateItem(_ item: Item) async -> Bool
    func deleteItem(_ item: Item) async -> Bool
}
