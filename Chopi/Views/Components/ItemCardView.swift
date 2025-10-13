//
//  ItemCardView.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 12/10/25.
//

import SwiftUI

struct ItemCardView: View {
    let isPurchased: Bool
    let name: String
    let quantity: Int
    let actionOnTap: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: isPurchased ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 30, height: 30)
                .padding(.trailing)
                .foregroundStyle(isPurchased ? .green : .black)
                .onTapGesture {
                    actionOnTap()
                }
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                    .padding(.bottom)
                Text("Cantidad: \(quantity)")
                    .font(.subheadline)
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
    }
}

#Preview {
    ItemCardView(isPurchased: false, name: "Producto 1", quantity: 10, actionOnTap: { print("Tapped") })
}
