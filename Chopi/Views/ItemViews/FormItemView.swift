//
//  FormItemView.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 12/10/25.
//

import SwiftUI

struct FormItemView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: FormItemViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Nombre del producto")
                .font(.headline)
                .padding(.top)
                .accessibilityIdentifier("FormItemTitle")
            TextField(text: self.$viewModel.name) {
                Text("Obligatorio")
                    .italic()
            }
            .onChange(of: self.viewModel.name) {
                self.viewModel.validateName()
            }
            .accessibilityIdentifier("ItemNameTextField")
            Divider()
            HStack {
                Text("Cantidad:")
                Picker("Cantidad", selection: self.$viewModel.quantity) {
                    ForEach(1..<51, id: \.self) { number in
                        Text("\(number)")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            Toggle(isOn: self.$viewModel.isPurchased) {
                Text("Comprado:")
            }
            Spacer()
            Button {
                self.viewModel.saveNewItem {
                    dismiss()
                }
            } label: {
                Label("Guardar Producto", systemImage: "square.and.pencil")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(self.viewModel.isButtonDisabled ? .blue : .gray.opacity(0.2)))
            }
            .disabled(!self.viewModel.isButtonDisabled)
            .accessibilityIdentifier("SaveItemButton")
        }
        .padding()
        .navigationTitle(self.viewModel.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if viewModel.item != nil {
                    Button {
                        self.viewModel.showDeleteItemAlert()
                    } label: {
                        Label("Eliminar producto", systemImage: "trash")
                    }
                    .tint(.red)
                    .accessibilityIdentifier("DeleteItemButton")
                }
            }
        }
        .alert("Eliminar producto", isPresented: self.$viewModel.showDeleteConfirmation) {
            Button("Cancelar", role: .cancel) { }
            Button("Eliminar", role: .destructive) {
                self.viewModel.deleteItem {
                    dismiss()
                }
            }
        } message: {
            Text("¿Eliminar este producto? Esta acción no se puede deshacer.")
        }
    }
}

#Preview {
    NavigationStack {
        FormItemView(viewModel: FormItemViewModel(MockDatabaseService(), shoppingList: ShoppingList(id: "1", name: "Lista 1", createdAt: Date(), itemCount: 0), item: Item(id: "1", name: "Producto 1", quantity: 1, isPurchased: true, createdAt: Date(), listId: "1")))
    }
}
