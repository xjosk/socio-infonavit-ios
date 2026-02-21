//
//  socioinfonavitApp.swift
//  socioinfonavit
//
//  Created by Andrei Carvajal on 18/02/26.
//

import SwiftUI

@main
struct socioinfonavitApp: App {
    
    @StateObject var viewModel = AuthViewModel(authRepository: MockAuthRepository())
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
