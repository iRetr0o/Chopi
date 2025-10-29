//
//  ListDetailViewModel.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 11/10/25.
//

import Foundation

class ListDetailViewModel: ObservableObject {
    @Published var loading: Bool = false
    @Published var showDetails: Bool = false
    
    var items: [Item] = []
    var item: Item?
    let shoppingList: ShoppingList
    let databaseService: DatabaseServiceProtocol
    
    init(_ databaseService: DatabaseServiceProtocol, shoppingList: ShoppingList) {
        self.databaseService = databaseService
        self.shoppingList = shoppingList
    }
    
    func getInitialData() {
        self.getItems()
    }
    
    func getItems() {
        self.loading = true
        Task {
            self.items = await self.databaseService.fetchItems(for: shoppingList.id)
            await MainActor.run {
                self.loading = false
            }
        }
    }
    
    func updateItemStatus() {
        guard
            let item,
            let index = self.items.firstIndex(where: { $0.id == item.id })
        else { return }
        self.loading = true
        
        let updatedItem = Item(id: item.id, name: item.name, quantity: item.quantity, isPurchased: !item.isPurchased, createdAt: item.createdAt, listId: item.listId)
    
        items[index] = updatedItem

        Task {
            let saved = await self.databaseService.updateItem(updatedItem)
            if saved {
                await MainActor.run {
                    self.loading = false
                }
            }
        }
    }
}
