//
//  HomeView.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 28/09/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(self.viewModel.shoppingLists) { list in
                        ListCardView(name: list.name, totalItems: list.itemCount)
                        .onTapGesture {
                            self.viewModel.selectedList = list
                            self.viewModel.showDetails = true
                        }
                    }
                }
                .padding()
            }
            .onAppear() {
                self.viewModel.getInitialData()
            }
            .sheet(isPresented: self.$viewModel.showSheet, onDismiss: {
                self.viewModel.getInitialData()
            }) {
                NavigationStack {
                    CreateListView(viewModel: CreateListViewModel(self.viewModel.databaseService))
                }
                .presentationDetents([.fraction(0.4)])
                .presentationDragIndicator(.visible)
            }
            .navigationTitle("Listas de compras")
            .navigationDestination(isPresented: self.$viewModel.showDetails, destination: {
                if let selectedList = self.viewModel.selectedList {
                    DetailListView(viewModel: DetailListViewModel(self.viewModel.databaseService, shoppingList: selectedList))
                }
            })
            .toolbar {
                Button {
                    self.viewModel.showSheet = true
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
