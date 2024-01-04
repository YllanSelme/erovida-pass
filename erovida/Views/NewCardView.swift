//
//  NewCardView.swift
//  erovida
//
//  Created by nosh#1234 on 30/12/2023.
//

import SwiftUI

struct NewCardView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectChest : Bool = false
    @State private var selectedItem: SelectItem?
    @State private var selectedDate = Date()
    @State private var dateSheet: Bool = false
    @State private var title: String = ""
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var key: String = ""
    @State private var website: String = ""
    @State private var note: String = ""
    @State private var date: String = "Ajoutez une date."
    @State private var isEditingTitle = false
    @State private var errorTitle = false
    
    var body: some View {
        ZStack {
            Color(hex: 0x001D38)
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 15){
                HStack{
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size:25))
                            .foregroundColor(Color(hex: 0x298F64))
                            .padding(10)
                            .background(Color(hex: 0x297354))
                            .cornerRadius(50)
                    }
                    Spacer()
                    Button {
                        print("create")
                    } label: {
                        Text("Créer")
                            .font(.system(size:25))
                            .foregroundColor(Color(hex: 0x298F64))
                            .padding(10)
                            .padding(.horizontal, 15)
                            .background(Color(hex: 0x297354))
                            .cornerRadius(50)
                    }
                }
                .padding(15)
                .padding(.horizontal, 25)
                
                ScrollView{
                    VStack (spacing: 2){
                        ZStack {
                            Rectangle()
                                .frame(width: 350, height: 100)
                                .background(Color(hex: 0x090D11))
                                .roundedCorner(20, corners: [.topLeft, .topRight])
                            HStack{
                                Image(systemName: "house")
                                    .foregroundColor(Color(hex: 0x298F64))
                                    .font(.system(size:25))
                                    .frame(width: 50, height: 50)
                                    .background(Color(hex: 0x297354))
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
                                    .padding(.leading, 50)
                            }
                            .padding(5)
                            
                        }
                        .onTapGesture {
                            self.selectChest.toggle()
                        }
                        .sheet(isPresented: $selectChest) {
                            SelectItemView(selectedItem: $selectedItem, showingSheet: $selectChest)
                        }
                        
                        
                        ZStack(alignment: .leading){
                            Rectangle()
                                .frame(width: 350, height: 120)
                                .background(Color(hex: 0x090D11))
                                .roundedCorner(20, corners: [.bottomLeft, .bottomRight])
                            
                            VStack(alignment: .leading, spacing: 0){
                                Text("Titre")
                                    .foregroundColor(.white)
                                    .font(.system(size:20))
                                IdentifiantTitleView(text: $title, placeholder: "Sans titre", placeholderColor: Color(.gray))
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .frame(maxWidth: 230)
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
                            IdentifiantsRowView(title: $name, imageName: "person", titleText: "Nom du titulaire de la carte", field: "Nom complet")
                        }
                        
                        
                        ZStack(alignment: .leading){
                            Rectangle()
                                .frame(width: 350, height: 100)
                                .background(Color(hex: 0x090D11))
                            IdentifiantsRowView(title: $password, imageName: "creditcard", titleText: "Numéro de la carte", field: "1234 1234 1234 1234")
                        }
                        
                        
                        ZStack(alignment: .leading){
                            Rectangle()
                                .frame(width: 350, height: 100)
                                .background(Color(hex: 0x090D11))
                            IdentifiantsRowView(title: $key, imageName: "calendar", titleText: "Expire le", field: "MM/AA")
                        }
                        
                        ZStack(alignment: .leading){
                            Rectangle()
                                .frame(width: 350, height: 100)
                                .background(Color(hex: 0x090D11))
                                .roundedCorner(20, corners: [.bottomLeft, .bottomRight])
                            IdentifiantsRowView(title: $key, imageName: "checkmark.shield", titleText: "Numéro de vérification", field: "123")
                        }
                        
                    }
                    .padding(0)
                    
                    ZStack(alignment: .leading){
                        Rectangle()
                            .frame(width: 350, height: 100)
                            .background(Color(hex: 0x090D11))
                            .roundedCorner(20, corners: [.bottomLeft, .bottomRight, .topLeft, .topRight])
                        IdentifiantsRowView(title: $note, imageName: "list.bullet.clipboard", titleText: "Note (optionel)", field: "Ajoutez une note.")
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
                            
                            VStack(alignment: .leading, spacing: 10){
                                Text("Date d'expiration (optionel)")
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .frame(maxWidth: 230)
                                Text(formatSelectedDate(selectedDate))
                                    .font(.system(size: 23, weight: .medium))
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 8)
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
                    }
                }
            }
        }
    }
}

struct NewCardView_Previews: PreviewProvider {
    static var previews: some View {
        NewCardView()
    }
}
