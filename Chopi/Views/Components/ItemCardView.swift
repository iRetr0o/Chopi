//
//  ItemCardView.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 12/10/25.
//

import SwiftUI

struct ItemCardView: View {
    let item: Item
    let isUpdating: Bool
    let onToggle: () -> Void
    
    var body: some View {
        HStack {
            Button {
                onToggle()
            } label: {
                if isUpdating {
                    ProgressView()
                        .frame(width: 30, height: 30)
                        .padding(.trailing)
                } else {
                    Image(systemName: item.isPurchased ? "checkmark.circle.fill" : "circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.trailing)
                        .foregroundStyle(item.isPurchased ? .green : .gray)
                }
            }
            .buttonStyle(.plain)
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                    .padding(.bottom)
                Text("Cantidad: \(item.quantity)")
                    .font(.subheadline)
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
        .opacity(isUpdating ? 0.6 : 1.0)
    }
}

#Preview {
    ItemCardView(item: Item(id: "1", name: "Producto 1", quantity: 1, isPurchased: false, createdAt: Date(), listId: "1"), isUpdating: false, onToggle: { print("Tapped") })
}
