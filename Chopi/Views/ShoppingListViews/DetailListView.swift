//
//  DetailListView.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 29/09/25.
//

import SwiftUI

struct DetailListView: View {
    @State private var isChecked = false
    let title: String
    
    var body: some View {
        List {
            HStack {
                Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.trailing)
                    .foregroundStyle(isChecked ? .green : .black)
                    .onTapGesture {
                        isChecked.toggle()
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
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailListView(title: "Lista 1")
}
