//
//  AddShoppingListViewModel.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 29/09/25.
//

import Foundation

class FormListViewModel: ObservableObject {
    @Published var loading = false
    @Published var name: String = ""
    @Published var showDeleteConfirmation = false
    
    var shoppingList : ShoppingList?
    let databaseService: DatabaseServiceProtocol
    private let characterLimit: Int = 50
    
    init(_ databaseService: DatabaseServiceProtocol, shoppingList: ShoppingList? = nil) {
        self.databaseService = databaseService
        self.shoppingList = shoppingList
        self.setUpInfoIfNeeded()
    }
    
    var isButtonEnabled: Bool {
        return !name.isEmpty
    }
    
    var navigationTitle: String {
        self.shoppingList == nil ? "Crear nueva lista" : "Actualizar lista"
    }
    
    func validateName() {
        if name.count > characterLimit {
            name = String(name.prefix(characterLimit))
        }
    }
    
    func saveNewList(completion: @escaping () -> Void) {
        self.loading = true
        if let shoppingList {
            let listToUpdate = ShoppingList(id: shoppingList.id, name: name, createdAt: shoppingList.createdAt, itemCount: shoppingList.itemCount)
            
            Task {
                let saved = await self.databaseService.updateList(listToUpdate)
                if saved {
                    await MainActor.run {
                        self.loading = false
                        completion()
                    }
                }
                else {
                    // TODO: Mostrar un error
                    print("Error al guardar")
                }
            }
        } else {
            let listToSave = ShoppingList(id: UUID().uuidString, name: name, createdAt: Date(), itemCount: 0)
            Task {
                let saved = await self.databaseService.saveList(listToSave)
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
    
    func deleteList(completion: @escaping () -> Void) {
        guard let shoppingList else { return }
        self.loading = true
        
        Task {
            let deleted = await self.databaseService.deleteList(shoppingList)
            if deleted {
                await MainActor.run {
                    self.loading = false
                    completion()
                }
            }
        }
    }
    
    func showDeleteListAlert() {
        self.showDeleteConfirmation = true
    }
    
    private func setUpInfoIfNeeded() {
        if let shoppingList {
            name = shoppingList.name
        }
    }
    
}
