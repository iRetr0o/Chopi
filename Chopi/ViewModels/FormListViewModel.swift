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
    
    let databaseService: DatabaseServiceProtocol
    private let characterLimit: Int = 50
    
    init(_ databaseService: DatabaseServiceProtocol) {
        self.databaseService = databaseService
    }
    
    var isButtonDisabled: Bool {
        return !name.isEmpty
    }
    
    func validateName() {
        if name.count > characterLimit {
            name = String(name.prefix(characterLimit))
        }
    }
    
    func saveNewList(completion: @escaping () -> Void) {
        self.loading = true
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
