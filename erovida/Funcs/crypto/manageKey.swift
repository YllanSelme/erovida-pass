import SwiftUI
import CryptoKit



func saveKeyToKeychain(key: SymmetricKey, keyIdentifier: String) {
    let keyData = key.withUnsafeBytes { Data($0) }

    let deleteQuery: [String: Any] = [
        kSecClass as String: kSecClassKey,
        kSecAttrApplicationTag as String: keyIdentifier
    ]

    let deleteStatus = SecItemDelete(deleteQuery as CFDictionary)

    if deleteStatus != errSecSuccess && deleteStatus != errSecItemNotFound {
        print("Erreur lors de la suppression de la clé existante. Code d'erreur: \(deleteStatus)")
        return
    }

    let addquery: [String: Any] = [
        kSecClass as String: kSecClassKey,
        kSecAttrApplicationTag as String: keyIdentifier,
        kSecValueData as String: keyData,
        kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlockedThisDeviceOnly
    ]

    let status = SecItemAdd(addquery as CFDictionary, nil)
    guard status == errSecSuccess else {
        print("Erreur lors de l'ajout de la clé dans le Keychain. Code d'erreur: \(status)")
        return
    }
}

func saveStringToKeychain(str: String, keyIdentifier: String) {
    guard let strData = str.data(using: .utf8) else {
        print("Erreur lors de la conversion du code PIN en données.")
        return
    }

    let deleteQuery: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: keyIdentifier
    ]

    let deleteStatus = SecItemDelete(deleteQuery as CFDictionary)

    if deleteStatus != errSecSuccess && deleteStatus != errSecItemNotFound {
        print("Erreur lors de la suppression de la clé existante. Code d'erreur: \(deleteStatus)")
        return
    }

    let addquery: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: keyIdentifier,
        kSecValueData as String: strData,
        kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlockedThisDeviceOnly
    ]

    let status = SecItemAdd(addquery as CFDictionary, nil)
    guard status == errSecSuccess else {
        print("Erreur lors de l'ajout de la clé dans le Keychain. Code d'erreur: \(status)")
        return
    }
}


func retrieveKeyFromKeychain(keyIdentifier: String) -> SymmetricKey? {
    let query: [String: Any] = [
        kSecClass as String: kSecClassKey,
        kSecAttrApplicationTag as String: keyIdentifier,
        kSecMatchLimit as String: kSecMatchLimitOne,
        kSecReturnData as String: kCFBooleanTrue!
    ]

    var dataTypeRef: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

    guard status == errSecSuccess, let keyData = dataTypeRef as? Data else {
        print("Erreur lors de la récupération de la clé depuis le Keychain. Code d'erreur: \(status)")
        return nil
    }

    return SymmetricKey(data: keyData)
}

func retrieveStringFromKeychain(keyIdentifier: String) -> String? {
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: keyIdentifier,
        kSecMatchLimit as String: kSecMatchLimitOne,
        kSecReturnData as String: kCFBooleanTrue!
    ]

    var dataTypeRef: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

    guard status == errSecSuccess, let keyData = dataTypeRef as? Data else {
        print("Erreur lors de la récupération de la clé depuis le Keychain. Code d'erreur: \(status)")
        return nil
    }

    guard let pin = String(data: keyData, encoding: .utf8) else {
        print("Erreur lors de la conversion des données en chaîne.")
        return nil
    }

    return pin
}

func retrieveBoolFromKeychain(keyIdentifier: String) -> Bool? {
    guard let stringValue = retrieveStringFromKeychain(keyIdentifier: keyIdentifier) else {
        return nil
    }

    return stringValue.lowercased() == "yes"
}


func deleteKey(keyIdentifier: String) {

    let deleteQuery: [String: Any] = [
        kSecClass as String: kSecClassKey,
        kSecAttrApplicationTag as String: keyIdentifier
    ]

    let deleteStatus = SecItemDelete(deleteQuery as CFDictionary)

    if deleteStatus != errSecSuccess && deleteStatus != errSecItemNotFound {
        print("Erreur lors de la suppression de la clé existante. Code d'erreur: \(deleteStatus)")
        return
    }
}
