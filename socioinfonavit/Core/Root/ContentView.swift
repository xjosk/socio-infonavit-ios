//
//  ContentView.swift
//  socioinfonavit
//
//  Created by Andrei Carvajal on 18/02/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
        
        var body: some View {
            Group {
                switch authViewModel.authState {
                case .loading:
                    ZStack {
                        Color.appRed.ignoresSafeArea()
                        ProgressView()
                            .tint(.white)
                    }
                    
                case .success:
                    TabBarView()
                    
                case .idle, .failure:
                    LoginView()
                }
            }
            .animation(.easeInOut, value: authViewModel.authState)
        }
}

#Preview {
    ContentView()
}
