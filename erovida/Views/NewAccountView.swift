import SwiftUI
import CryptoKit
import Foundation
import Security

struct NewAccountView: View {
    @Binding var isKeySaved: Bool
    @State var name = ""
    @State var lastName = ""
    @State private var isEditingName = false
    @State private var isEditingLastName = false
    @State private var errorName = false
    @State private var errorLastName = false

    var body: some View {
        ZStack {
            Color(hex: 0x001D38)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Text("Créer votre compte simplement")
                    .font(.system(size:30, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .multilineTextAlignment(.center)
                VStack{
                    VStack(alignment: .leading){
                        Text("Prénom")
                            .foregroundColor(errorName ? Color.red : Color.white)
                        TextField("", text: $name, onEditingChanged: { editing in isEditingName = editing
                        })
                        .modifier(LoginTextField(error: errorName, isEditing: isEditingName))
                        
                        Text("Merci de renseigner votre prénom")
                            .foregroundColor(errorName ? Color.red : Color(hex: 0x001D38))
                    }
                    .padding()
                    
                    VStack(alignment: .leading){
                        Text("Nom")
                            .foregroundColor(errorLastName ? Color.red : Color.white)
                        TextField("", text: $lastName, onEditingChanged: { editing in isEditingLastName = editing
                        })
                        .modifier(LoginTextField(error: errorLastName, isEditing: isEditingLastName))
                        Text("Merci de renseigner votre nom")
                            .foregroundColor(errorLastName ? Color.red : Color(hex: 0x001D38))
                    }
                    .padding()
                    
                    VStack{
                        Button("Créer un nouveau compte") {
                            updateErrorState(text: name, error: &errorName)
                            updateErrorState(text: lastName, error: &errorLastName)
                            
                            if (!errorLastName && !errorName)
                            {
                                let keyChain = AESAlgo.createPinString()
                                saveStringToKeychain(str: keyChain, keyIdentifier: "pin")
                                saveStringToKeychain(str: "no", keyIdentifier: "isKeySavedByUser")
                                let key = AESAlgo.generateSymmetricKey(fromPin: keyChain)
                                saveKeyToKeychain(key: key, keyIdentifier: "key")
                                let key64 = AESAlgo.keyToString(key: key)
                                print(key64)
                                let sealedBoxFirstName = AESAlgo.encryption(message: name, key: key)
                                let keyHashed = AESAlgo.sha256Hash(from: key64)
                                let sealedBoxLastName = AESAlgo.encryption(message: lastName, key: key)
                                
                                let tagBase64 = stringFormat(text: sealedBoxFirstName.tag.base64EncodedString())
                                
                                let tagBase64_Last = stringFormat(text: sealedBoxLastName.tag.base64EncodedString())
                                
                                let urlString = "http://192.168.1.37:5000/create_account?hashedKey=\(keyHashed)&nameCipher=\(stringFormat(text: sealedBoxFirstName.ciphertext.base64EncodedString()))&nameNonce=\(stringFormat(text: sealedBoxFirstName.nonce.withUnsafeBytes {Data(Array($0))}.base64EncodedString()))&nameTag=\(tagBase64)&lastNameCipher=\(stringFormat(text: sealedBoxLastName.ciphertext.base64EncodedString()))&lastNameNonce=\(stringFormat(text: sealedBoxLastName.nonce.withUnsafeBytes { Data(Array($0)) }.base64EncodedString()))&lastNameTag=\(tagBase64_Last)"

                                createAccount(hashedKey: keyHashed, nameCipher: stringFormat(text: sealedBoxFirstName.ciphertext.base64EncodedString()), nameNonce: stringFormat(text: sealedBoxFirstName.nonce.withUnsafeBytes {Data(Array($0))}.base64EncodedString()), nameTag: tagBase64, lastNameCipher: stringFormat(text: sealedBoxLastName.ciphertext.base64EncodedString()), lastNameNonce: stringFormat(text: sealedBoxLastName.nonce.withUnsafeBytes { Data(Array($0)) }.base64EncodedString()), lastNameTag: tagBase64_Last)
                            }
                            
                            isKeySaved = true
                            
                            
                        }
                        .buttonStyle(LoginButtonStyle())
                        .foregroundColor(.black)
                        .frame(width: 340, height: 60)
                        .background(Color(hex: 0x4485C4))
                        .cornerRadius(50)
                    }.padding()
                }.padding()
                
            }
        }
    }
}

struct NewAccountView_Previews: PreviewProvider {
    static var previews: some View {
        NewAccountView(isKeySaved: .constant(false))
    }
}


