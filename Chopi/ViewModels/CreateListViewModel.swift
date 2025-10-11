//
//  AddShoppingListViewModel.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 29/09/25.
//

import Foundation

class CreateListViewModel: ObservableObject {
    @Published var loading = false
    @Published var name: String = ""
    
    let databaseService: DatabaseServiceProtocol
    
    init(_ databaseService: DatabaseServiceProtocol) {
        self.databaseService = databaseService
    }
    
    var isButtonDisabled: Bool {
        return !name.isEmpty
    }
    
    func saveNewList(completion: @escaping (ShoppingList?) -> Void) {
        self.loading = true
        let listToSave = ShoppingList(id: UUID().uuidString, name: name, createdAt: Date())
        Task {
            let saved = await self.databaseService.saveList(listToSave)
            if saved {
                await MainActor.run {
                    self.loading = false
                    completion(nil)
                }
            } else {
                // TODO: Mostrar un error
                print("Error al guardar")
            }
        }
    }
}
