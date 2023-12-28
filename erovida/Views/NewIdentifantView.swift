//
//  NewIdentifantView.swift
//  erovida
//
//  Created by nosh#1234 on 28/12/2023.
//

import SwiftUI

struct NewIdentifantView: View {
    @State private var selectedDate = Date()
    @State private var dateSheet: Bool = false
    @State private var title: String = ""
    @State private var name: String = ""
    @State private var isEditingTitle = false
    @State private var errorTitle = false
    
    var body: some View {
        ZStack {
            Color(hex: 0x001D38)
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                VStack (spacing: 15){
                    HStack{
                        Button {
                            print("exit")
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size:25))
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color(hex: 0x4485C4))
                                .cornerRadius(50)
                        }
                        Spacer()
                        Button {
                            print("create")
                        } label: {
                            Text("Créer")
                                .font(.system(size:25))
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color(hex: 0x4485C4))
                                .cornerRadius(50)
                        }
                    }
                    .padding()
                    .padding(.horizontal, 25)
                    
                    VStack (spacing: 2){
                        ZStack(alignment: .leading){
                            Rectangle()
                                .frame(width: 350, height: 100)
                                .background(Color(hex: 0x090D11))
                                .roundedCorner(20, corners: [.topLeft, .topRight])
                            HStack{
                                Image(systemName: "house")
                                    .foregroundColor(.white)
                                    .font(.system(size:25))
                                    .frame(width: 50, height: 50)
                                    .background(Color(.red))
                                    .cornerRadius(50)
                                    .padding(10)
                                
                                VStack(alignment: .leading){
                                    Text("Coffre-Fort")
                                        .foregroundColor(.gray)
                                    Text("Personal")
                                        .font(.system(size:30))
                                        .foregroundColor(.white)
                                }
                                
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.white)
                                    .padding(25)
                            }
                            .padding(5)
                        }
                        
                        
                        ZStack(alignment: .leading){
                            Rectangle()
                                .frame(width: 350, height: 100)
                                .background(Color(hex: 0x090D11))
                                .roundedCorner(20, corners: [.bottomLeft, .bottomRight])
                            
                            VStack(alignment: .leading){
                                Text("Titre")
                                    .foregroundColor(.white)
                                    .font(.system(size:20))
                                TextField("Sans titre", text: $title)
                                    .frame(maxWidth: 230)
                                    .font(.system(size:35))
                                    .foregroundColor(.white)
                            }
                            .padding()
                        }
                    }
                    .padding(0)
                    
                    VStack (spacing: 2){
                        ZStack(alignment: .leading){
                            Rectangle()
                                .frame(width: 350, height: 100)
                                .background(Color(hex: 0x090D11))
                                .roundedCorner(20, corners: [.topLeft, .topRight])
                            IdentifiantsRowView(title: $name, imageName: "person", titleText: "Nom d'utilisateur ou adresse mail", field: "Ajoutez votre nom d'utilisateur ou adresse mail")
                        }
                        
                        ZStack(alignment: .leading){
                            Rectangle()
                                .frame(width: 350, height: 100)
                                .background(Color(hex: 0x090D11))
                            IdentifiantsRowView(title: $name, imageName: "key", titleText: "Un mot de passe", field: "Ajoutez votre mot de passe")
                        }
                        
                        ZStack(alignment: .leading){
                            Rectangle()
                                .frame(width: 350, height: 100)
                                .background(Color(hex: 0x090D11))
                                .roundedCorner(20, corners: [.bottomLeft, .bottomRight])
                            IdentifiantsRowView(title: $name, imageName: "lock", titleText: "Clé secrète A2F (optionel)", field: "Ajoutez la clé secreète A2F.")
                        }
                    }
                    .padding(0)
                    
                    ZStack(alignment: .leading){
                        Rectangle()
                            .frame(width: 350, height: 100)
                            .background(Color(hex: 0x090D11))
                            .roundedCorner(20, corners: [.bottomLeft, .bottomRight, .topLeft, .topRight])
                        IdentifiantsRowView(title: $name, imageName: "globe", titleText: "Site", field: "https://")
                    }
                    
                    ZStack(alignment: .leading){
                        Rectangle()
                            .frame(width: 350, height: 100)
                            .background(Color(hex: 0x090D11))
                            .roundedCorner(20, corners: [.bottomLeft, .bottomRight, .topLeft, .topRight])
                        IdentifiantsRowView(title: $name, imageName: "list.bullet.clipboard", titleText: "Note (optionel)", field: "Ajoutez une note.")
                    }
                    
                    ZStack(alignment: .leading){
                        Rectangle()
                            .frame(width: 350, height: 100)
                            .background(Color(hex: 0x090D11))
                            .roundedCorner(20, corners: [.bottomLeft, .bottomRight, .topLeft, .topRight])
                        HStack{
                            Image(systemName: "calendar.badge.clock")
                                .foregroundColor(.white)
                                .font(.system(size:25))
                                .frame(width: 50, height: 50)
                                .padding(10)
                            
                            VStack(alignment: .leading){
                                Text("Date d'expiration (optionel)")
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .frame(maxWidth: 230)
                                Text("Ajoutez une date")
                                    .frame(maxWidth: 230)
                                    .font(.system(size:25))
                                    .foregroundColor(.white)
                            }
                        }
                        .onTapGesture {
                            dateSheet.toggle()
                        }
                        .sheet(isPresented: $dateSheet) {
                            VStack {
                                DatePicker("Select a date", selection: $selectedDate, in: Date()..., displayedComponents: [.date])
                                    .datePickerStyle(WheelDatePickerStyle())
                                    .labelsHidden()
                            }
                            .presentationDetents([.medium])
                        }
                        Text("\(formattedDate)")
                            .foregroundColor(.white)
                    }
                }
            }
        }
        var formattedDate: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            return dateFormatter.string(from: selectedDate)
        }
    }
}

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 8)
            )
    }
}


struct NewIdentifantView_Previews: PreviewProvider {
    static var previews: some View {
        NewIdentifantView()
    }
}
