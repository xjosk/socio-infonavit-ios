//
//  ContentSideMenuView.swift
//  socioinfonavit
//
//  Created by Andrei Carvajal on 20/02/26.
//


import SwiftUI

struct ContentSideMenuView: View {
    @Binding var isShowing: Bool
    @Binding var selectedTab: Int
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var selectedOption: SideMenuOptionModel?
    
    var body: some View {
        ZStack {
            if isShowing {
                Rectangle()
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Image(.appLogo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                            .foregroundStyle(.white)
                            .padding(.bottom, 22)
                        
                        ForEach(SideMenuOptionModel.allCases) { option in
                            Text(option.title)
                                .font(.title2)
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                                .onTapGesture {
                                    onOptionTapped(option)
                                }
                        }
                        
                        Spacer()
                        
                        Text("Cerrar Sesión")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                            .onTapGesture {
                                Task {
                                    try await authViewModel.logOut()
                                }
                            }
                    }
                    .padding()
                    .frame(width: 270, alignment: .leading)
                    .background(.appRed)
                    
                    Spacer()
                }
                .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut, value: isShowing)
    }
    
    private func onOptionTapped(_ option: SideMenuOptionModel) {
        selectedOption = option
        selectedTab = option.rawValue
        isShowing = false
    }
}

#Preview {
    ContentSideMenuView(isShowing: .constant(true), selectedTab: .constant(0))
}

enum SideMenuOptionModel: Int, CaseIterable, Identifiable {
    case home
    case benevits
    
    var title: String {
        switch self {
        case .home:
            return "Inicio"
        case .benevits:
            return "Mis Benevits"
        }
    }
    
    var id: Int { return self.rawValue}
}
