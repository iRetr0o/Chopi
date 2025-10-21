//
//  LoadingView.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 21/10/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView()
                .tint(.primary)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    LoadingView()
}
