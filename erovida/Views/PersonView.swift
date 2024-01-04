import SwiftUI

struct PersonView: View {
    @Binding var isKeySavedByUserBoolPerma: Bool
    @Binding var isKeySaved: Bool
    @State private var checkKeySheet: Bool = false
    @State private var selectKey: Bool = false
    @State private var checkKey: Bool = false

    var body: some View {
        ZStack {
            Color(hex: 0x001D38)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Button("Vérifier ma clé") {
                    checkKeySheet = true
                }
                .buttonStyle(LoginButtonStyle())
                .foregroundColor(.black)
                .frame(width: 340, height: 60)
                .background(Color(hex: 0x4485C4))
                .cornerRadius(50)
                .sheet(isPresented: $checkKeySheet) {
                    CheckKey()
                }
                
                Button("Se deconnecter") {
                    deleteKey(keyIdentifier: "isKeySavedByUser")
                    deleteKey(keyIdentifier: "pin")
                    deleteKey(keyIdentifier: "key")
                    isKeySaved = false
                }
                .buttonStyle(LoginButtonStyle())
                .foregroundColor(.black)
                .frame(width: 340, height: 60)
                .background(Color(hex: 0x4485C4))
                .cornerRadius(50)

                Button("Suppprimer le compte") {
                    print("delete")
                }
                .buttonStyle(LoginButtonStyle())
                .foregroundColor(Color(hex: 0x4485C4))
            }
        }
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView(isKeySavedByUserBoolPerma: .constant(false), isKeySaved: .constant(false))
    }
}
