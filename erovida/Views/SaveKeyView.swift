import SwiftUI

struct SaveKeyView: View {
    @Binding var isKeySaved: Bool
    @State private var pin: String = ""
    
    var body: some View {
        ZStack {
            Color(hex: 0x001D38)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                Text("Sauvgarder ma clé de sauvegarde")
                    .font(.system(size:30, weight: .bold))
                    .padding()
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                VStack(alignment: .leading){
                    Text("Cette clé va servir à chiffrer tous vos mots de passes, ne la perdez pas.\nElle peut également vous servir à vous reconnecter après une décnonection.\nAprès avoir cliqué sur le bouton ci-dessous, vous ne reverez pour jamais cette clé, il est alors important de la noter et la preserver")
                        .foregroundColor(.white)
                }
                .padding()
                
                Text(insertNewline(pin: pin, at: 8))
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                
                Button("J'ai noté la clé à l'abris des regards")
                {
                    saveStringToKeychain(str: "yes", keyIdentifier: "isKeySavedByUser")
                    isKeySaved = true
                }
                .buttonStyle(LoginButtonStyle())
                .padding(.horizontal, 50)
                .foregroundColor(Color(hex: 0x4485C4))
            }
            .onAppear{
                if let pinP = retrieveStringFromKeychain(keyIdentifier: "pin") {
                    pin = pinP
                }
                else {
                    pin = "Error"
                }
            }
        }
        
    }
}

struct SaveKeyView_Previews: PreviewProvider {
    static var previews: some View {
        SaveKeyView(isKeySaved : .constant(false))
    }
}
