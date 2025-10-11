//
//  ListCardView.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 11/10/25.
//

import SwiftUI

struct ListCardView: View {
    let name: String
    let totalItems: Int
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            Text(name)
                .font(.headline)
            HStack {
                Spacer()
                Text(totalItems.description)
                    .font(.caption)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.blue.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    ListCardView(name: "Lista 1", totalItems: 5)
}
