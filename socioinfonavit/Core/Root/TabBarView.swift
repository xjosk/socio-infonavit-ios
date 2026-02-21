//
//  TabBarView.swift
//  socioinfonavit
//
//  Created by Andrei Carvajal on 20/02/26.
//

import SwiftUI

struct TabBarView: View {
    @State private var showMenu = false
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            NavigationStack {
                TabView(selection: $selectedTab) {
                    HomeView()
                        .tag(0)
                    
                    UnlockedBenevitsView()
                        .tag(1)
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar { toolbarContent }
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(.appRed, for: .navigationBar)
            }
            
            ContentSideMenuView(isShowing: $showMenu, selectedTab: $selectedTab)
                .zIndex(1)
        }
    }
    
    private var toolbarContent: some ToolbarContent {
        Group {
            ToolbarItem(placement: .principal) {
                Image(.appLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .foregroundStyle(.white)
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    showMenu.toggle()
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    TabBarView()
}
