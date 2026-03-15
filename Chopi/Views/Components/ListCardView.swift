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
    let date: Date
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            Text(name)
                .font(.headline)
            HStack(alignment: .center) {
                Text(totalItems.description)
                    .font(.callout)
                Spacer()
                Text(date.formatted(date: .abbreviated, time: .omitted))
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
    ListCardView(name: "Lista 1", totalItems: 5, date: Date())
}
