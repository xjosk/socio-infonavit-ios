//
//  HomeView.swift
//  socioinfonavit
//
//  Created by Andrei Carvajal on 19/02/26.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(spacing: 12) {
                    switch homeViewModel.benevitsState {
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
                .padding(.top, 80)
                .padding(.bottom)
            }
            
            TextField("", text: $homeViewModel.query, prompt: Text("Buscar Benevit")
                .foregroundColor(.white))
            .font(.headline)
            .tint(.white)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .padding(.horizontal, 10)
            .background(.gray)
            .clipShape(Capsule())
            .padding()
        }
        .background(Color.appGray.opacity(0.25))
        .animation(.easeInOut, value: homeViewModel.benevitsState)
        .onAppear {
            if homeViewModel.benevitsState.value != nil {
                return
            }
            
            Task {
                try await homeViewModel.getRewards()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
