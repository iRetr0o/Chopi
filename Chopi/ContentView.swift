//
//  ContentView.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 28/09/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
