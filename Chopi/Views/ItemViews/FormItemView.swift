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
                .accessibilityIdentifier("FormItemTitle")
            TextField(text: self.$viewModel.name) {
                Text("Obligatorio")
                    .italic()
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
                Label("Guardar", systemImage: "square.and.pencil")
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
    }
}

#Preview {
    FormItemView(viewModel: FormItemViewModel(MockDatabaseService(), shoppingList: ShoppingList(id: "1", name: "Lista 1", createdAt: Date(), itemCount: 0)))
}
