//
//  FormItemViewModel.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 19/10/25.
//

import Foundation

class FormItemViewModel: ObservableObject {
    @Published var loading: Bool = false
    @Published var name: String = ""
    @Published var quantity: Int = 1
    @Published var isPurchased: Bool = false
    
    let item: Item?
    let shoppingList: ShoppingList
    let databaseService: DatabaseServiceProtocol
    private let characterLimit: Int = 30

    init(_ databaseService: DatabaseServiceProtocol, shoppingList: ShoppingList, item: Item? = nil) {
        self.databaseService = databaseService
        self.shoppingList = shoppingList
        self.item = item
        self.setUpInfoIfNeeded()
    }
    
    var isButtonDisabled: Bool {
        return !name.isEmpty
    }
    
    func validateName() {
        if name.count > characterLimit {
            name = String(name.prefix(characterLimit))
        }
    }
    
    func saveNewItem(completion: @escaping () -> Void) {
        self.loading = true
        if let item {
            let itemToUpdate = Item(id: item.id, name: name, quantity: quantity, isPurchased: isPurchased, createdAt: item.createdAt, listId: item.listId)
            
            Task {
                let saved = await self.databaseService.updateItem(itemToUpdate)
                if saved {
                    await MainActor.run {
                        self.loading = false
                        completion()
                    }
                } else {
                    // TODO: Mostrar un error
                    print("Error al guardar")
                }
            }
        } else {
            let itemToSave = Item(id: UUID().uuidString, name: self.name, quantity: self.quantity, isPurchased: self.isPurchased, createdAt: Date(), listId: shoppingList.id)
            Task {
                let saved = await self.databaseService.saveItem(itemToSave)
                if saved {
                    await MainActor.run {
                        self.loading = false
                        completion()
                    }
                } else {
                    // TODO: Mostrar un error
                    print("Error al guardar")
                }
            }
        }
    }
    
    private func setUpInfoIfNeeded() {
        if let item {
            name = item.name
            quantity = item.quantity
            isPurchased = item.isPurchased
        }
    }
}
