//
//  CreateShoppingListView.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 28/09/25.
//

import SwiftUI

struct CreateListView: View {
    @State var name = ""

    var isFormValid: Bool {
        !name.isEmpty
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Nombre de la lista")
                .font(.headline)
                .padding(.bottom)
            TextField("Despensa", text: $name)
            Spacer()
            Button {
                // TODO: Agregar guardado de lista
                print("Guardar")
            } label: {
                Text("Guardar")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(isFormValid ?  Color.blue : Color.gray.opacity(0.2)))
            }
            .disabled(!isFormValid)
        }
        .navigationTitle("Crear nueva lista")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}

#Preview {
    CreateListView()
}
