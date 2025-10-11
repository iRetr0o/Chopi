//
//  ContentView.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 28/09/25.
//

import SwiftUI

struct ContentView: View {
    private let databaseService: DatabaseServiceProtocol = MockDatabaseService()
    
    var body: some View {
        TabView {
            HomeView(viewModel: HomeViewModel(databaseService))
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
