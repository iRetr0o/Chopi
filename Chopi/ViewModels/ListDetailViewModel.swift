//
//  ListDetailViewModel.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 11/10/25.
//

import Foundation

enum ItemDetailSheet: Identifiable, Hashable {
    var id: String { String(describing: self) }
    case newItem(list: ShoppingList)
    case updateItem(list: ShoppingList, _ item: Item)
}

class ListDetailViewModel: ObservableObject {
    @Published var loading: Bool = false
    @Published var loadingItem: String?
    @Published var sheet: ItemDetailSheet?
    @Published var items: [Item] = []
    
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
            let fetchedItems = await self.databaseService.fetchItems(for: shoppingList.id)
            await MainActor.run {
                self.items = fetchedItems
                self.loading = false
            }
        }
    }
    
    func updateItemStatus() {
        guard
            let item,
            let index = self.items.firstIndex(where: { $0.id == item.id })
        else { return }
        self.loadingItem = item.id
        
        let updatedItem = Item(id: item.id, name: item.name, quantity: item.quantity, isPurchased: !item.isPurchased, createdAt: item.createdAt, listId: item.listId)

        Task {
            let saved = await self.databaseService.updateItem(updatedItem)
            if saved {
                await MainActor.run {
                    self.items[index] = updatedItem
                    self.loadingItem = nil
                }
            } else {
                // TODO: Mostrar un error
                print("Error al actualizar el estatus")
            }
        }
    }
    
    func newItem(shoppingList: ShoppingList) {
        self.sheet = .newItem(list: shoppingList)
    }
    
    func updateItem(shoppingList: ShoppingList, _ item: Item) {
        self.sheet = .updateItem(list: shoppingList, item)
    }
}
