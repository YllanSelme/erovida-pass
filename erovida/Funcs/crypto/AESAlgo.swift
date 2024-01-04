import CryptoKit
import Foundation

class AESAlgo {
    static func generateSymmetricKey(fromPin pin: String) -> SymmetricKey {
        let hashedData = SHA256.hash(data: pin.data(using: .utf8)!)
        let keyData = hashedData.prefix(32)
        
        return SymmetricKey(data: Data(keyData))
    }
    
    static func keyToString (key: SymmetricKey) -> String {
        let keyb64 = key.withUnsafeBytes {
            return Data(Array($0)).base64EncodedString()
        }
        return keyb64
    }
    
    static func encryption(message: String, key: SymmetricKey) -> AES.GCM.SealedBox {
        let messageToEncrypt = message.data(using: .utf8)!
        let sealedBox = try! AES.GCM.seal(messageToEncrypt, using: key)
        return sealedBox
    }
    
    static func decryption(sealedBox: AES.GCM.SealedBox, key: SymmetricKey) -> String {
        let decryptedData = try? AES.GCM.open(sealedBox, using: key)
        let decryptedText = String(data: decryptedData ?? Data(), encoding: .utf8) ?? "Déchiffrement échoué"
        return decryptedText
    }
    
    static func sha256Hash(from string: String) -> String {
        let data = Data(string.utf8)
        let digest = SHA256.hash(data: data)
        let hash = digest.compactMap { String(format: "%02x", $0) }.joined()
        return hash
    }
    
    static func createPinString() -> String {
        var keyString = ""

        for _ in 1...2 {
            let randomNumber = String(format: "%04d", Int.random(in: 0...9999))
            keyString.append(randomNumber)
        }

        return keyString
    }
}
