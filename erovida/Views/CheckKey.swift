import SwiftUI

struct CheckKey: View {
    @State private var pinValues: [String] = Array(repeating: "", count: 16)
    @State private var alertText: String = "Votre clé est invalide"
    @State private var showingConfirmation: Bool = false
    @State private var showingAlert: Bool = false
    var body: some View {
        ZStack {
            Color(hex: 0x001D38)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Vérifier la clé de sauvegarde")
                    .font(.system(size:30, weight: .bold))
                    .padding()
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                PinFieldView(pinValues: $pinValues)
                Button("Vérifier") {
                    let pinKey = pinValues.joined(separator: "")
                    let key = AESAlgo.generateSymmetricKey(fromPin: pinKey)
                    let key64 = AESAlgo.keyToString(key: key)
                    let hashedKey = AESAlgo.sha256Hash(from: key64)
                    if let memoKey = retrieveKeyFromKeychain(keyIdentifier: "key"){
                        let memoKey64 = AESAlgo.keyToString(key: memoKey)
                        let memoKeyHashed = AESAlgo.sha256Hash(from: memoKey64)
                        checkKey(hashedKey: hashedKey) { success in
                            if success {
                                if memoKeyHashed == hashedKey {
                                    alertText = "Votre clé est valide"
                                }
                            }
                            showingAlert = true
                        }
                    }
                }
                .alert(alertText, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
                .buttonStyle(LoginButtonStyle())
                .foregroundColor(.white)
                .frame(width: 340, height: 60)
                .background(Color(hex: 0x4485C4))
                .cornerRadius(50)
            }
        }
    }
}

struct CheckKey_Previews: PreviewProvider {
    static var previews: some View {
        CheckKey()
    }
}
