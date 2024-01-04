import SwiftUI


struct SignInView: View {
    enum FocusPin: CaseIterable {
        case pinOne, pinTwo, pinThree, pinFour, pinFive, pinSix, pinSeven, pinEight, pinOneBis, pinTwoBis, pinThreeBis, pinFourBis, pinFiveBis, pinSixBis, pinSevenBis, pinEightBis
    }

    @FocusState private var pinFocusState: FocusPin?
    @Binding var isKeySaved: Bool
    @State private var pinValues: [String] = Array(repeating: "", count: 16)

    var body: some View {
        ZStack {
            Color(hex: 0x001D38)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Connectez vous simplement")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .multilineTextAlignment(.center)

                Text("Entrez le code fourni lors de la création de votre compte")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.gray)
                    .padding()
                    .multilineTextAlignment(.center)

                PinFieldView(pinValues: $pinValues)

                Button("Se connecter") {
                    let pin = pinValues.joined()
                    let key = AESAlgo.generateSymmetricKey(fromPin: pin)
                    saveKeyToKeychain(key: key, keyIdentifier: "key")
                    isKeySaved = true
                }
                .disabled(checkFields())
                .buttonStyle(LoginButtonStyle())
                .foregroundColor(.black)
                .frame(width: 340, height: 60)
                .background(checkFields() ? Color(hex: 0x2F70AF) : Color(hex: 0x4485C4))
                .cornerRadius(50)
            }
        }
    }

    private func checkFields() -> Bool {
        pinValues.allSatisfy { $0.isEmpty }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(isKeySaved: .constant(false))
    }
}
