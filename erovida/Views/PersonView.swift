import SwiftUI

struct PersonView: View {
    @Binding var isKeySaved: Bool
    @State private var pin : String = ""
    
    var body: some View {
        VStack{
            Text(pin)
                .foregroundColor(.black)
            
            Button("Send pin") {
                pin = retrievePinFromKeychain(keyIdentifier: "pin") ?? "oij"
                
            }
            
            Button("Se deconnecter") {
                deleteKey(keyIdentifier: "key")
                isKeySaved = false
            }
            .buttonStyle(LoginButtonStyle())
            .foregroundColor(.black)
            .frame(width: 340, height: 60)
            .background(Color(hex: 0x4485C4))
            .cornerRadius(50)
        }
    }
}
