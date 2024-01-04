import SwiftUI

struct PersonView: View {
    @Binding var isKeySavedByUserBoolPerma: Bool
    @Binding var isKeySaved: Bool
    @State private var selectKey: Bool = false
    @State private var checkKey: Bool = false

    var body: some View {
        ZStack {
            Color(hex: 0x001D38)
                .edgesIgnoringSafeArea(.all)
            VStack{
                
                List{
                    Section(header: Text("Clé de sauvegarde")
                        .foregroundColor(.gray)) {
                        HStack{
                            Text("Enregistrer ma clé")
                                .foregroundColor(isKeySavedByUserBoolPerma ? .gray : .black)
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectKey = true
                        }
                        .sheet(isPresented: $selectKey) {
                            SaveKeyView(isKeySavedByUserBoolPerma: $isKeySavedByUserBoolPerma, selectKey: $selectKey)
                        }
                        
                        
                        HStack{
                            Text("Vérifier ou générer une nouvelle clé")
                                .foregroundColor(isKeySavedByUserBoolPerma ? .black : .gray)
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            checkKey = true
                        }
                        .sheet(isPresented: $checkKey) {
                            ZStack {
                                Color(hex: 0x001D38)
                                    .edgesIgnoringSafeArea(.all)
                                VStack {
                                    CheckKey(isKeySavedByUserBoolPerma : $isKeySavedByUserBoolPerma, checkKey: $checkKey)
                                }
                            }
                        }
                    }
                }
                .background(Color(hex: 0x001D38))
                .scrollContentBackground(.hidden)

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
