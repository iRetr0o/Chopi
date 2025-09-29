//
//  HomeView.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 28/09/25.
//

import SwiftUI

struct HomeView: View {
    @State var lists: [ShoppingList] = [
        ShoppingList(id: "1", name: "Lista 1", createdAt: Date()),
        ShoppingList(id: "2", name: "Lista 2", createdAt: Date())
    ]
    @State var showSheet = false
    @State var showDetails = false
    @State var selectedList: ShoppingList?
    
    var totalItems: Int {
        lists.count
    }
    let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(lists) { list in
                        VStack(alignment: .leading, spacing: 25) {
                            Text(list.name)
                                .font(.headline)
                            HStack {
                                Spacer()
                                Text(totalItems.description)
                                    .font(.caption)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.blue.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .onTapGesture {
                            selectedList = list
                            showDetails = true
                        }
                    }
                }
                .padding()
            }
            .sheet(isPresented: $showSheet) {
                NavigationStack {
                    CreateListView()
                }
                .presentationDetents([.fraction(0.3)])
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
    HomeView()
}
