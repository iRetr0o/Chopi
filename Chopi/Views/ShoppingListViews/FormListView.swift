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
        
    var body: some View {
        VStack(alignment: .leading) {
            Text("Nombre de la lista")
                .font(.headline)
                .padding(.bottom)
                .accessibilityIdentifier("FormListTitle")
            TextField("Despensa", text: self.$viewModel.name)
                .onChange(of: self.viewModel.name) {
                    self.viewModel.validateName()
                }
                .accessibilityIdentifier("ListNameTextField")
            Spacer()
            Button {
                self.viewModel.saveNewList {
                    dismiss()
                }
            } label: {
                Label("Guardar Lista", systemImage: "square.and.pencil")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(self.viewModel.isButtonDisabled ?  Color.blue : Color.gray.opacity(0.2)))
            }
            .disabled(!self.viewModel.isButtonDisabled)
            .accessibilityIdentifier("SaveListButton")
        }
        .navigationTitle(self.viewModel.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}

#Preview {
    NavigationStack {
        FormListView(viewModel: FormListViewModel(MockDatabaseService()))
    }
}
