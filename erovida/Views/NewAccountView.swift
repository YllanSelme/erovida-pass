//
//  NewAccountView.swift
//  erovida
//
//  Created by nosh#1234 on 27/12/2023.
//

import SwiftUI

struct NewAccountView: View {
    @State var prenom = ""
    @State var nom = ""
    @State private var isEditingPrenom = false
    @State private var isEditingNom = false
    @State private var errorPrenom = false
    @State private var errorNom = false

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
                            .foregroundColor(errorPrenom ? Color.red : Color.white)
                        TextField("", text: $prenom, onEditingChanged: { editing in isEditingPrenom = editing
                        })
                        .modifier(LoginTextField(error: errorPrenom, isEditing: isEditingPrenom))
                        
                        Text("Merci de renseigner votre prénom")
                            .foregroundColor(errorPrenom ? Color.red : Color(hex: 0x001D38))
                    }
                    .padding()
                    
                    VStack(alignment: .leading){
                        Text("Nom")
                            .foregroundColor(errorNom ? Color.red : Color.white)
                        TextField("", text: $nom, onEditingChanged: { editing in isEditingNom = editing
                        })
                        .modifier(LoginTextField(error: errorNom, isEditing: isEditingNom))
                        Text("Merci de renseigner votre nom")
                            .foregroundColor(errorNom ? Color.red : Color(hex: 0x001D38))
                    }
                    .padding()
                    
                    VStack{
                        Button("Créer un nouveau compte") {
                            updateErrorState(text: prenom, error: &errorPrenom)
                            updateErrorState(text: nom, error: &errorNom)
                            
                            if (!errorNom && !errorPrenom)
                            {
                                print("hello")
                            }
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
        NewAccountView()
    }
}


