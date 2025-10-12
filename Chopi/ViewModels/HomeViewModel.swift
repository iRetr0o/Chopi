//
//  HomeViewModel.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 28/09/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var loading = false
    @Published var showSheet = false
    @Published var showDetails = false
    
    var selectedList: ShoppingList?
    var shoppingLists: [ShoppingList] = []
    let databaseService: DatabaseServiceProtocol
    
    init(_ databaseService: DatabaseServiceProtocol) {
        self.databaseService = databaseService
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
