//
//  HomeViewModel.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 28/09/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var loading = false
    @Published var title: String = ""
    
    var shoppingLists: [ShoppingList] = []
    let shoppingList: ShoppingList?
    let databaseService: DatabaseServiceProtocol
    
    init(_ databaseService: DatabaseServiceProtocol, shoppingList: ShoppingList? = nil) {
        self.databaseService = databaseService
        self.shoppingList = shoppingList
    }
    
    func getInitialData() {
        self.getShoppingLists()
    }
    
    func getShoppingLists() {
        self.loading = true
        Task {
            self.shoppingLists = await self.databaseService.fetchLists()
            await MainActor.run {
                self.loading = false
            }
        }
    }
}
