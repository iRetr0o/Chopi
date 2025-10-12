//
//  DetailListView.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 29/09/25.
//

import SwiftUI

struct DetailListView: View {
    @StateObject var viewModel: DetailListViewModel
    
    var body: some View {
        List {
            ForEach(self.viewModel.items) { item in
                HStack {
                    Image(systemName: item.isPurchased ? "checkmark.circle.fill" : "circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.trailing)
                        .foregroundStyle(item.isPurchased ? .green : .black)
                        .onTapGesture {
                            self.viewModel.updateItemStatus(for: item)
                        }
                    VStack(alignment: .leading) {
                        Text("Nombre del prodcuto")
                            .font(.headline)
                            .padding(.bottom)
                        Text("Cantidad: 10")
                            .font(.subheadline)
                    }
                }
            }
        }
        .navigationTitle(self.viewModel.shoppingList.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            self.viewModel.getInitialData()
        }
    }
}

#Preview {
    DetailListView(viewModel: DetailListViewModel(MockDatabaseService(), shoppingList: ShoppingList(id: "1", name: "Lista 1", createdAt: Date(), itemCount: 0)))
}
