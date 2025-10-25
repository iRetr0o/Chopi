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
            homeScreen
            .navigationTitle("Listas de compras")
            .navigationDestination(isPresented: self.$viewModel.showDetails, destination: {
                if let selectedList = self.viewModel.selectedList {
                    ListDetailView(viewModel: ListDetailViewModel(self.viewModel.databaseService, shoppingList: selectedList))
                }
            })
            .toolbar {
                Button {
                    self.viewModel.showSheet = true
                } label: {
                    Label("Agregar lista", systemImage: "plus")
                }
                .accessibilityIdentifier("AddListButton")
            }
        }
        .onAppear() {
            self.viewModel.getInitialData()
        }
        .sheet(isPresented: self.$viewModel.showSheet, onDismiss: {
            self.viewModel.getInitialData()
        }) {
            NavigationStack {
                FormListView(viewModel: FormListViewModel(self.viewModel.databaseService))
            }
            .presentationDetents([.fraction(0.4)])
            .presentationDragIndicator(.visible)
        }
    }
    
    @ViewBuilder
    private var homeScreen: some View {
        if self.viewModel.loading {
            LoadingView()
        } else if self.viewModel.shoppingLists.isEmpty {
            VStack {
                Image(systemName: "list.bullet.clipboard")
                    .resizable()
                    .frame(width: 100, height: 150)
                    .padding(.bottom)
                Text("Aun no tienes listas, inteta")
                Button {
                    self.viewModel.showSheet = true
                } label: {
                    Text("Crear una nueva lista")
                }
            }
            .padding(.bottom)
        } else {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(self.viewModel.shoppingLists) { list in
                        Button(action: {
                            self.viewModel.selectedList = list
                            self.viewModel.showDetails = true
                        }) {
                            ListCardView(name: list.name, totalItems: list.itemCount, date: list.createdAt)
                                .accessibilityIdentifier("List_\(list.id)")
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(MockDatabaseService()))
}
