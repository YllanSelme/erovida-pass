//
//  SelectItemRows.swift
//  erovida
//
//  Created by nosh#1234 on 27/12/2023.
//

import SwiftUI

struct SelectItemRows: View {
    @State var backgroundColor: Color
    @State var color: Color
    @State var imageName: String
    @State var title: String
    @State var subTitle: String
    
    var body: some View {
        HStack {
            Text("")
            HStack(spacing: 20) {
                Image(systemName: imageName)
                    .foregroundColor(color)
                    .font(.system(size:25))
                    .frame(width: 50, height: 50)
                    .background(backgroundColor)
                    .cornerRadius(18)
                VStack (alignment: .leading){
                    Text(title)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                    Text(subTitle)
                        .foregroundColor(.gray)
                        .font(.system(size: 20, weight: .medium))
                }
            }
        }
    }
}

struct SelectItemRows_Previews: PreviewProvider {
    static var previews: some View {
        SelectItemRows(backgroundColor: Color(.green), color: Color(.red), imageName: "person", title: "Un identifiant", subTitle: "Ajoutez des informations d'identification pour une application ou un site")
    }
}
