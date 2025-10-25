//
//  ListDetailView.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 29/09/25.
//

import SwiftUI

struct ListDetailView: View {
    @StateObject var viewModel: ListDetailViewModel
    
    var body: some View {
        List {
            ForEach(self.viewModel.items) { item in
                ItemCardView(isPurchased: item.isPurchased, name: item.name, quantity: item.quantity) {
                    self.viewModel.item = item
                    self.viewModel.updateItemStatus()
                }
            }
        }
        .onAppear {
            self.viewModel.getInitialData()
        }
        .navigationTitle(self.viewModel.shoppingList.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: self.$viewModel.showDetails, destination: {
            FormItemView(viewModel: FormItemViewModel(self.viewModel.databaseService, shoppingList: self.viewModel.shoppingList))
        })
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    self.viewModel.showDetails = true
                } label: {
                    Label("Agregar prodcuto", systemImage: "plus")
                }
                .accessibilityIdentifier("AddItemButton")
            }
        }
    }
}

#Preview {
    NavigationStack {
        ListDetailView(viewModel: ListDetailViewModel(MockDatabaseService(), shoppingList: ShoppingList(id: "1", name: "Lista 1", createdAt: Date(), itemCount: 0)))
    }
}
