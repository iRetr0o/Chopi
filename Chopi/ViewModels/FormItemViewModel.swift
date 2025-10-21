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
    
    init(_ databaseService: DatabaseServiceProtocol, shoppingList: ShoppingList, item: Item? = nil) {
        self.databaseService = databaseService
        self.shoppingList = shoppingList
        self.item = item
    }
    
    var isButtonDisabled: Bool {
        return !name.isEmpty
    }
    
    func saveNewItem(completion: @escaping () -> Void) {
        self.loading = true
        let itemToSave = Item(id: UUID().uuidString, name: self.name, quantity: self.quantity, isPurchased: self.isPurchased, createdAt: Date(), listId: shoppingList.id)
        Task {
            let saved = await self.databaseService.saveItem(for: shoppingList.id, item: itemToSave)
            if saved {
                await MainActor.run {
                    self.loading = false
                    completion()
                }
            }
        }
    }
}
