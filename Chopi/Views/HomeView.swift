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
        NavigationStack(path: self.$viewModel.path) {
            homeScreen
            .navigationTitle("Listas de compras")
            .navigationDestination(for: HomeNavigationRoute.self, destination: { route in
                switch route {
                case .listDetail(let list):
                    ListDetailView(viewModel: ListDetailViewModel(self.viewModel.databaseService, shoppingList: list))
                }
            })
            .toolbar {
                Button {
                    self.viewModel.newList()
                } label: {
                    Label("Agregar lista", systemImage: "plus")
                }
                .accessibilityIdentifier("AddListButton")
            }
            .onAppear() {
                self.viewModel.getInitialData()
            }
            .sheet(item: self.$viewModel.sheet, onDismiss: {
                self.viewModel.getInitialData()
            }) { item in
                NavigationStack {
                    switch item {
                    case .newList:
                        FormListView(viewModel: FormListViewModel(self.viewModel.databaseService))
                    case .updateList(let list):
                        FormListView(viewModel: FormListViewModel(self.viewModel.databaseService, shoppingList: list))
                    }
                }
                .presentationDetents([.fraction(0.4)])
                .presentationDragIndicator(.visible)
            }
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
                Text("Aun no tienes listas, intenta")
                Button {
                    self.viewModel.newList()
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
                            self.viewModel.goToDetail(list)
                        }) {
                            ListCardView(name: list.name, totalItems: list.itemCount, date: list.createdAt)
                                .accessibilityIdentifier("List_\(list.id)")
                        }
                        .buttonStyle(.plain)
                        .contextMenu {
                            Button {
                                self.viewModel.updateList(list)
                            } label: {
                                Label("Editar", systemImage: "pencil")
                            }
                            .accessibilityIdentifier("EditListButton")
                        }
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
