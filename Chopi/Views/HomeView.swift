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
    let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(lists) { list in
                        VStack {
                            Text(list.name)
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Listas de compras")
            .toolbar {
                Button {
                    print("quiero agregar una lista")
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
