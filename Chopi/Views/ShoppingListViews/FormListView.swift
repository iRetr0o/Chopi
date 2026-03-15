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
                    .background(RoundedRectangle(cornerRadius: 10).fill(self.viewModel.isButtonEnabled ?  Color.blue : Color.gray.opacity(0.2)))
            }
            .disabled(!self.viewModel.isButtonEnabled)
            .accessibilityIdentifier("SaveListButton")
        }
        .navigationTitle(self.viewModel.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if viewModel.shoppingList != nil {
                    Button {
                        self.viewModel.showDeleteListAlert()
                    } label: {
                        Label("Eliminar lista", systemImage: "trash")
                    }
                    .tint(.red)
                    .accessibilityIdentifier("DeleteListButton")
                }
            }
        }
        .alert("Eliminar lista", isPresented: self.$viewModel.showDeleteConfirmation) {
            Button("Cancelar", role: .cancel) { }
            Button("Eliminar", role: .destructive) {
                self.viewModel.deleteList {
                    dismiss()
                }
            }
        } message: {
            Text("¿Eliminar esta lista? Se borrarán todos los productos y no podrás deshacer esta acción.")
        }
    }
}

#Preview {
    NavigationStack {
        FormListView(viewModel: FormListViewModel(MockDatabaseService()))
    }
}
