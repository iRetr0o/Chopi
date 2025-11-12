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
        itemsScreen
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
    
    @ViewBuilder
    private var itemsScreen: some View {
        if self.viewModel.loading {
            LoadingView()
        } else if self.viewModel.items.isEmpty {
            VStack {
                Image(systemName: "checklist")
                    .font(.system(size: 80))
                    .padding(.bottom)
                Text("Aun no tienes productos, intenta")
                Button {
                    self.viewModel.showDetails = true
                } label: {
                    Text("Agregar uno")
                }
            }
            .padding(.bottom)
        } else {
            List {
                ForEach(self.viewModel.items) { item in
                    ItemCardView(item: item, isUpdating: self.viewModel.loadingItem == item.id) {
                        self.viewModel.item = item
                        self.viewModel.updateItemStatus()
                    }
                    .accessibilityIdentifier("Item_\(item.id)")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ListDetailView(viewModel: ListDetailViewModel(MockDatabaseService(), shoppingList: ShoppingList(id: "1", name: "Lista 1", createdAt: Date(), itemCount: 0)))
    }
}
