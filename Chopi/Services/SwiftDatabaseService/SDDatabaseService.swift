//
//  SDDatabaseService.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 19/10/25.
//

import Foundation
import SwiftData

@MainActor
class SDDatabaseService: DatabaseServiceProtocol {
    private let container: ModelContainer
    private let context: ModelContext
    
    init() {
        self.container = try! ModelContainer(
            for: SDShoppingList.self, SDItem.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: false)
        )
        self.context = ModelContext(container)
    }
    
    func fetchLists() async -> [ShoppingList] {
        let descriptor = FetchDescriptor<SDShoppingList>()
        do {
            let sdLists = try context.fetch(descriptor)
            return sdLists.map { $0.toShoppingList() }
        } catch {
            return []
        }
    }
    
    func saveList(_ list: ShoppingList) async -> Bool {
        let sdList = SDShoppingList(id: list.id, name: list.name, createdAt: list.createdAt)
        do {
            context.insert(sdList)
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    func updateList(_ list: ShoppingList) async -> Bool {
        let id = list.id
        let predicate = #Predicate<SDShoppingList> { $0.id == id }
        let descriptor = FetchDescriptor<SDShoppingList>(predicate: predicate)
        do {
            guard let existingList = try context.fetch(descriptor).first else {
                return false
            }
            existingList.name = list.name
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    func deleteList(_ list: ShoppingList) async -> Bool {
        let id = list.id
        let predicate = #Predicate<SDShoppingList> { $0.id == id }
        let descriptor = FetchDescriptor<SDShoppingList>(predicate: predicate)
        do {
            guard let existingList = try context.fetch(descriptor).first else {
                return false
            }
            context.delete(existingList)
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    func fetchItems() async -> [Item] {
        return []
    }
    
    func saveItem(_ item: Item) async -> Bool {
        return false
    }
    
    func updateItem(_ item: Item) async -> Bool {
        return false
    }
    
    func deleteItem(_ item: Item) async -> Bool {
        return false
    }
    
}
