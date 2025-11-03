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
    
    func fetchItems(for listId: String) async -> [Item] {
        let predicate = #Predicate<SDShoppingList> { $0.id == listId }
        let descriptor = FetchDescriptor<SDShoppingList>(predicate: predicate)
        do {
            let sdLists = try context.fetch(descriptor)
            guard let sdList = sdLists.first else { return [] }
            return sdList.items.map { $0.toItem() }
        } catch {
            return []
        }
    }
    
    func saveItem(for listId: String, item: Item) async -> Bool {
        let predicate = #Predicate<SDShoppingList> { $0.id == listId }
        let descriptor = FetchDescriptor<SDShoppingList>(predicate: predicate)
        
        do {
            let sdLists = try context.fetch(descriptor)
            guard let sdList = sdLists.first else { return false }
            let sdItem = SDItem(id: item.id, name: item.name, quantity: item.quantity, isPurchased: item.isPurchased, createdAt: item.createdAt, list: sdList)
            context.insert(sdItem)
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    func updateItem(_ item: Item) async -> Bool {
        let id = item.id
        let predicate = #Predicate<SDItem> { $0.id == id }
        let descriptor = FetchDescriptor<SDItem>(predicate: predicate)
        do {
            guard let existingItem = try context.fetch(descriptor).first else {
                return false
            }
            existingItem.name = item.name
            existingItem.quantity = item.quantity
            existingItem.isPurchased = item.isPurchased
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    func deleteItem(_ item: Item) async -> Bool {
        let id = item.id
        let predicate = #Predicate<SDItem> { $0.id == id }
        let descriptor = FetchDescriptor<SDItem>(predicate: predicate)
        do {
            guard let existingItem = try context.fetch(descriptor).first else { return false }
            context.delete(existingItem)
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
}
