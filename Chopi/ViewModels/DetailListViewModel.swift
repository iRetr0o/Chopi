//
//  DetailListViewModel.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 11/10/25.
//

import Foundation

class DetailListViewModel: ObservableObject {
    @Published var loading: Bool = false
    @Published var showDetails: Bool = false
    
    var items: [Item] = []
    var shoppingList: ShoppingList
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
    
    func updateItemStatus(for item: Item) {
        let updatedItem = Item(id: item.id, name: item.name, quantity: item.quantity, isPurchased: !item.isPurchased, createdAt: item.createdAt, listId: item.listId)
        
        if let index = self.items.firstIndex(where: { $0.id == item.id }) {
            items[index] = updatedItem
        }
        
        Task {
            let saved = await self.databaseService.updateItem(updatedItem)
            if saved {
                self.loading = false
            }
        }
    }
}
