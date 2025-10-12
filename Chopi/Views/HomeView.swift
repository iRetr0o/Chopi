//
//  HomeView.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 28/09/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @State var showSheet = false
    @State var showDetails = false
    @State var selectedList: ShoppingList?
    
    var totalItems: Int {
        self.viewModel.shoppingLists.count
    }
    let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(self.viewModel.shoppingLists) { list in
                        ListCardView(name: list.name, totalItems: totalItems)
                        .onTapGesture {
                            selectedList = list
                            showDetails = true
                        }
                    }
                }
                .padding()
            }
            .onAppear() {
                self.viewModel.getInitialData()
            }
            .sheet(isPresented: $showSheet, onDismiss: {
                self.viewModel.getInitialData()
            }) {
                NavigationStack {
                    CreateListView(viewModel: CreateListViewModel(self.viewModel.databaseService))
                }
                .presentationDetents([.fraction(0.4)])
                .presentationDragIndicator(.visible)
            }
            .navigationTitle("Listas de compras")
            .navigationDestination(isPresented: $showDetails, destination: {
                if let selectedList {
                    DetailListView(title: selectedList.name)
                }
            })
            .toolbar {
                Button {
                    showSheet = true
                } label: {
                    Image(systemName: "plus")
                }

            }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(MockDatabaseService()))
}
