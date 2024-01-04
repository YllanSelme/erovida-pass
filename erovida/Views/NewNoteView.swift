//
//  NewNoteView.swift
//  erovida
//
//  Created by nosh#1234 on 30/12/2023.
//

import SwiftUI

struct NewNoteView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectChest : Bool = false
    @State private var selectedItem: SelectItem?
    @State private var selectedDate = Date()
    @State private var dateSheet: Bool = false
    @State private var title: String = ""
    @State private var note: String = ""
    @State private var date: String = "Ajoutez une date."
    
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
                            .foregroundColor(Color(hex: 0x3463BD))
                            .padding(10)

                            .background(Color(hex: 0x2F5090))
                            .cornerRadius(50)
                    }
                    Spacer()
                    Button {
                        print("create")
                    } label: {
                        Text("Créer")
                            .font(.system(size:25))
                            .foregroundColor(Color(hex: 0x3463BD))
                            .padding(10)
                            .padding(.horizontal, 15)
                            .background(Color(hex: 0x2F5090))
                            .cornerRadius(50)
                    }
                }
                .padding(15)
                .padding(.horizontal, 25)
                
                VStack (spacing: 10){
                    ZStack {
                        Rectangle()
                            .frame(width: 350, height: 100)
                            .background(Color(hex: 0x090D11))
                            .roundedCorner(20, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
                        HStack{
                            Image(systemName: "house")
                                .foregroundColor(Color(hex: 0x3463BD))
                                .font(.system(size:25))
                                .frame(width: 50, height: 50)
                                .background(Color(hex: 0x2F5090))
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
                    
                    VStack(alignment: .leading, spacing: 0){
                        Text("Titre")
                            .foregroundColor(.white)
                            .font(.system(size:20))
                        
                        IdentifiantTitleView(text: $title, placeholder: "Sans titre", placeholderColor: Color(.gray))
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .frame(maxWidth: 300)
                        
                        TextEditor(text: $note)
                            .foregroundColor(.white)
                            .scrollContentBackground(.hidden)
                            .background(Color(hex: 0x001D38))
                            .font(.system(size: 26))
                    }
                    .padding()
                }
                .padding(0)
                    
            }
        }
    }
}

struct NewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NewNoteView()
    }
}
