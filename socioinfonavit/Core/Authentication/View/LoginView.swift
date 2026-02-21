//
//  LoginView.swift
//  socioinfonavit
//
//  Created by Andrei Carvajal on 18/02/26.
//

import SwiftUI

struct LoginView: View {
    enum Field {
        case email
        case password
    }
    
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var presentAuthFailedAlert: Bool = false
    @FocusState private var focusedField: Field?
    
    var isEnabled: Bool {
        return !email.isEmpty && !password.isEmpty
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                ZStack {
                    LoginHeaderBackground()
                        .fill(.appRed)
                        .ignoresSafeArea()
                    Image(.appLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                        .foregroundStyle(.white)
                }.frame(
                    height: proxy.size.height * 1/3
                )
                Group {
                    VStack {
                        AppTextField {
                            TextField("Correo", text: $email)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                                .submitLabel(.next)
                                .focused($focusedField, equals: .email)
                                .onSubmit {
                                    focusedField = .password
                                }
                        }
                        
                        AppTextField {
                            SecureField("Contraseña", text: $password)
                                .submitLabel(.go)
                                .focused($focusedField, equals: .password)
                                .onSubmit {
                                    if isEnabled {
                                        Task {
                                            try await authViewModel.signIn(withEmail: email, password: password)
                                        }
                                    }
                                }
                        }
                        
                        Button {
                            
                        } label: {
                            Text("Olvidé mi contraseña")
                                .underline()
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundStyle(.black)
                        .padding()
                        
                        AppFilledButton(title: "Entrar", isEnabled: isEnabled, isBusy: authViewModel.authState == .loading) {
                            Task {
                                try await authViewModel.signIn(withEmail: email, password: password)
                            }
                        }
                        
                        Spacer()
                        
                        HStack {
                            Text("¿Aún no tienes una cuenta?")
                            Button {
                                
                            } label: {
                                Text("Regístrate")
                                    .underline()
                            }
                            .foregroundStyle(.black)
                        }
                    }
                    .padding(.all, 30)
                }
            }
        }
        .onReceive(authViewModel.$authState, perform: { authState in
            if authState.failureMessage != nil {
                presentAuthFailedAlert = true
            }
        })
        .alert("Error", isPresented: $presentAuthFailedAlert, presenting: authViewModel.authState, actions: { _ in
            Button("OK") { presentAuthFailedAlert = false }
        }, message: { authState in
            Text(authState.failureMessage ?? "")
        })
        .keyboardAwarePadding()
    }
}

#Preview {
    LoginView()
}
