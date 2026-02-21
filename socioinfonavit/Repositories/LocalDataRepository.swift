//
//  LocalDataRepository.swift
//  socioinfonavit
//
//  Created by Andrei Carvajal on 20/02/26.
//

import Foundation

protocol LocalDataRepository: AnyObject {
    func getUserSession() -> String?
    func setUserSession(with token: String)
    func removeUserSession()
}

final class LocalDataRepositoryImpl: LocalDataRepository {
    private let defaults = UserDefaults.standard
    static private let AUTH_TOKEN_KEY = "AUTH_TOKEN_KEY"
    
    func getUserSession() -> String? {
        return defaults.string(forKey: Self.AUTH_TOKEN_KEY)
    }
    
    func setUserSession(with token: String) {
        defaults.set(token, forKey: Self.AUTH_TOKEN_KEY)
    }
    
    func removeUserSession() {
        defaults.removeObject(forKey: Self.AUTH_TOKEN_KEY)
    }
}
