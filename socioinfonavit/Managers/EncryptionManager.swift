//
//  Encryption.swift
//  socioinfonavit
//
//  Created by Andrei Carvajal on 19/02/26.
//

import Foundation
import Security

final class EncryptionManager {
    static let shared = EncryptionManager()
    
    private init () {}
    
    static let encryptionKey = """
    MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuIGVY6DVBZ/X4rWIOC5B
    kwXupvlRDZibogBmdkoER0Z3WX8PtyWcpf09fcvjaBw6Xwcw73E6uQMWMbSYR/Q8
    /6lk7TjQ7bDBnJ5M2ZI3cXhVEth2sGPfdrTWwiDjmyTOCtUUrs7DkC1vwV/uWQNo
    /Ed2wTdY6VKk8Dnkg4yZwqfzwFzJ82dh8zh0l08UHP+35B5SqDkbi4x/xCf7Qgp4
    g7omgBLfxqsTAllWAs2Ra+1jn3xzr4gOdbNZpXuoCRfrcrE/EcXbTxaPqArXSzff
    VZqjR5ulv5o5dRPT4vu7f2RKAhheXfWjQ3fzmlrckBfQf2EC3aBUu4mZmnzMIYJt
    MQIDAQAB
    """
    
    func publicKey(from pemString: String = encryptionKey) throws -> SecKey {
        
        let cleanedKey = pemString.replacingOccurrences(of: "\n", with: "")
        
        guard let keyData = Data(base64Encoded: cleanedKey) else {
            throw NSError(domain: "InvalidKey", code: -1)
        }
        
        let options: [String: Any] = [
            kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
            kSecAttrKeyClass as String: kSecAttrKeyClassPublic,
            kSecAttrKeySizeInBits as String: 2048,
            kSecReturnPersistentRef as String: true
        ]
        
        guard let secKey = SecKeyCreateWithData(keyData as CFData,
                                                options as CFDictionary,
                                                nil) else {
            throw NSError(domain: "KeyCreationFailed", code: -1)
        }
        
        return secKey
    }
    
    func encrypt(
        string: String,
        with publicKey: SecKey
    ) throws -> String {
        
        guard let data = string.data(using: .utf8) else {
            throw NSError(domain: "EncodingError", code: -1)
        }
        
        var error: Unmanaged<CFError>?
        
        guard let encryptedData = SecKeyCreateEncryptedData(
            publicKey,
            .rsaEncryptionPKCS1,
            data as CFData,
            &error
        ) as Data? else {
            throw error!.takeRetainedValue() as Error
        }
        
        return encryptedData.base64EncodedString()
    }
}
