//
//  UnlockedBenevitsView.swift
//  socioinfonavit
//
//  Created by Andrei Carvajal on 20/02/26.
//

import SwiftUI

struct UnlockedBenevitsView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    @StateObject private var unlockedBenevitsViewModel = UnlockedBenevitsViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                switch unlockedBenevitsViewModel.benevitsState {
                case .idle, .loading:
                    ForEach(0...3, id: \.self) { item in
                        RewardSection()
                    }
                case .success(let benevits):
                    ForEach(benevits, id: \.self) { item in
                        RewardSection(benevitSection: item)
                    }
                case .failure(let error):
                    Text(error)
                }
            }
            .padding(.vertical)
        }
        .background(Color.appGray.opacity(0.25))
        .animation(.easeInOut, value: unlockedBenevitsViewModel.benevitsState)
        .onAppear {
            if unlockedBenevitsViewModel.benevitsState.value != nil {
                return
            }
            
            Task {
                try await unlockedBenevitsViewModel.getUnlockedRewards()
            }
        }
    }
}

#Preview {
    UnlockedBenevitsView()
}
