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
        .sheet(item: self.$viewModel.sheet, onDismiss: {
            self.viewModel.getInitialData()
        }, content: { item in
            switch item {
            case .newItem(list: let shoppingList):
                FormItemView(viewModel: FormItemViewModel(self.viewModel.databaseService, shoppingList: shoppingList))
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            case .updateItem(list: let shoppingList, let item):
                FormItemView(viewModel: FormItemViewModel(self.viewModel.databaseService, shoppingList: shoppingList, item: item))
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            }
        })
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    self.viewModel.newItem(shoppingList: self.viewModel.shoppingList)
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
                    self.viewModel.newItem(shoppingList: self.viewModel.shoppingList)
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
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button {
                            self.viewModel.updateItem(shoppingList: self.viewModel.shoppingList, item)
                        } label: {
                            Label("Editar", systemImage: "pencil")
                        }
                        .tint(.blue)
                    }
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
