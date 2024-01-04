import SwiftUI

struct CheckKey: View {
    @Binding var isKeySavedByUserBoolPerma: Bool
    @Binding var checkKey: Bool
    @State private var pinValues: [String] = Array(repeating: "", count: 16)
    @State private var showingConfirmation: Bool = false
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
                Button("J'ai oublié ma clé") {
                    showingConfirmation = true
                }
                .buttonStyle(LoginButtonStyle())
                .foregroundColor(.white)
                .frame(width: 340, height: 60)
                .background(Color(hex: 0x4485C4))
                .cornerRadius(50)
                .confirmationDialog("", isPresented: $showingConfirmation) {
                    Button("Générer une nouvelle clé"){
                        let keyChain = AESAlgo.createPinString()
                        saveStringToKeychain(str: keyChain, keyIdentifier: "pin")
                        isKeySavedByUserBoolPerma = false
                        saveStringToKeychain(str: "no", keyIdentifier: "isKeySavedByUser")
                        checkKey = false
                    }
                    .foregroundColor(.green)
                    Button("Annuler", role: .cancel){
                    }
                    .foregroundColor(.red)
                } message: {
                    VStack{
                        Text("Si vous cliquez sur le bouton ci-dessous, votre clé précedente sera supprimée et vous ne pourrez jamais la récuperer")
                    }
                }
            }
        }
    }
}

struct CheckKey_Previews: PreviewProvider {
    static var previews: some View {
        CheckKey(isKeySavedByUserBoolPerma : .constant(false), checkKey: .constant(false))
    }
}
