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
            TextField(text: self.$viewModel.name) {
                Text("Obligatorio")
                    .italic()
            }
            Divider()
            HStack {
                Text("Cantidad:")
                Spacer()
                Picker("Cantidad", selection: self.$viewModel.quantity) {
                    ForEach(1..<51, id: \.self) { number in
                        Text("\(number)")
                    }
                }
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
                Text("Guardar")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(self.viewModel.isButtonDisabled ? .blue : .gray.opacity(0.2)))
            }
            .disabled(!self.viewModel.isButtonDisabled)
        }
        .padding()
    }
}

#Preview {
    FormItemView(viewModel: FormItemViewModel(MockDatabaseService(), shoppingList: ShoppingList(id: "1", name: "Lista 1", createdAt: Date(), itemCount: 0)))
}
