//
//  CreateShoppingListView.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 28/09/25.
//

import SwiftUI

struct FormListView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: FormListViewModel
    private let characterLimit = 50
        
    var body: some View {
        VStack(alignment: .leading) {
            Text("Nombre de la lista")
                .font(.headline)
                .padding(.bottom)
            TextField("Despensa", text: self.$viewModel.name)
                .onChange(of: self.viewModel.name) {
                    if self.viewModel.name.count > characterLimit {
                        self.viewModel.name = String(self.viewModel.name.prefix(characterLimit))
                    }
                }
            Spacer()
            Button {
                self.viewModel.saveNewList {
                    dismiss()
                }
            } label: {
                Text("Guardar")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(self.viewModel.isButtonDisabled ?  Color.blue : Color.gray.opacity(0.2)))
            }
            .disabled(!self.viewModel.isButtonDisabled)
        }
        .navigationTitle("Crear nueva lista")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}

#Preview {
    FormListView(viewModel: FormListViewModel(MockDatabaseService()))
}
