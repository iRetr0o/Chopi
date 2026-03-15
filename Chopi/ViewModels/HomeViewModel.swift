//
//  HomeViewModel.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 28/09/25.
//

import Foundation

enum HomeSheet: Identifiable, Equatable {
    var id: String { String(describing: self) }
    case newList
    case updateList(_ list: ShoppingList)
}

enum HomeNavigationRoute: Hashable {
    case listDetail(_ list: ShoppingList)
}

class HomeViewModel: ObservableObject {
    @Published var path = [HomeNavigationRoute]()
    @Published var loading = false
    @Published var sheet: HomeSheet?
    
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
    
    func newList() {
        self.sheet = .newList
    }
    
    func updateList(_ list: ShoppingList) {
        self.sheet = .updateList(list)
    }
    
    func goToDetail(_ list: ShoppingList) {
        self.path.append(.listDetail(list))
    }
}
