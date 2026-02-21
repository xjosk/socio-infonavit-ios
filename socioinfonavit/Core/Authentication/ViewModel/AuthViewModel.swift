//
//  AuthViewModel.swift
//  socioinfonavit
//
//  Created by Andrei Carvajal on 18/02/26.
//

import Foundation
import Combine

class AuthViewModel: ObservableObject {
    @Published var authState: AsyncDataState<String> = .loading
    
    init(
        authRepository: AuthRepository = AuthRepositoryImpl(),
        localDataRepository: LocalDataRepository = LocalDataRepositoryImpl()
    ) {
        self.authRepository = authRepository
        self.localDataRepository = localDataRepository
        
        Task {
            try await getUserSession()
        }
    }
    
    private let authRepository: AuthRepository
    private let localDataRepository: LocalDataRepository
    
    func signIn(withEmail email: String, password: String) async throws {
        authState = .loading
        do {
            let result = try await authRepository.logIn(with: email, password: password)
            localDataRepository.setUserSession(with: result.token)
            authState = .success(result.token)
        } catch {
            authState = .failure(String(describing: error))
        }
    }
    
    func logOut() async throws {
        localDataRepository.removeUserSession()
        authState = .idle
    }
    
    private func getUserSession() async throws {
        if let authToken = localDataRepository.getUserSession() {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            authState = .success(authToken)
        } else {
            authState = .idle
        }
    }
}
