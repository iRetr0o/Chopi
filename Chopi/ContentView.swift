//
//  ContentView.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 28/09/25.
//

import SwiftUI

struct ContentView: View {
    private let databaseService: DatabaseServiceProtocol
    
    init() {
        if ProcessInfo.processInfo.arguments.contains("-UITests") {
            self.databaseService = MockDatabaseService()
        } else {
            self.databaseService = SDDatabaseService()
        }
    }
    
    var body: some View {
        HomeView(viewModel: HomeViewModel(databaseService))
    }
}

#Preview {
    ContentView()
}
