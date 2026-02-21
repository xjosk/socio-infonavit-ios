//
//  AuthRepository.swift
//  socioinfonavit
//
//  Created by Andrei Carvajal on 20/02/26.
//

import Foundation

enum AuthError: Error, CustomStringConvertible {
    case invalidCredentials
    
    var description: String {
        switch self {
        case .invalidCredentials:
            return "Credenciales inválidas o usuario no encontrado"
        }
    }
}

protocol AuthRepository: AnyObject {
    func logIn(with email: String, password: String) async throws -> LoginResponse
    func getUserData() async throws -> AppUser
}

final class MockAuthRepository: AuthRepository {
    func logIn(with email: String, password: String) async throws -> LoginResponse {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        guard email == "61917612998" && password == "Contrasena01" else {
            throw AuthError.invalidCredentials
        }
        return LoginResponse(token: "ey3FJhf9H87N8hfHFHhffjs==")
    }
    
    func getUserData() async throws -> AppUser {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        return AppUser(name: "Test User", email: "test@email.com")
    }
}

final class AuthRepositoryImpl: AuthRepository {
    struct EmptyBody: Encodable {
        
    }
    
    func getUserData() async throws -> AppUser {
        let result: AppUser = try await apiManager.execute("/members/authentication", body: Optional<EmptyBody>.none)
        
        return result
    }
    
    private let apiManager = APIManager.shared
    private let encryptionManager = EncryptionManager.shared
    
    func logIn(with email: String, password: String) async throws -> LoginResponse {
        
        let secKey = try encryptionManager.publicKey()
        let encryptedCredentials = try encryptionManager.encrypt(string: "\(email):\(password)", with: secKey)
        
        let result: LoginResponse = try await apiManager.execute("/members/authentication", method: .POST,  body: LoginRequest(credentials: encryptedCredentials))
        
        return result
    }
}
