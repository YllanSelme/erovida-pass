import SwiftUI

//struct CustomTextField: View {
//    @Binding var text: String
//    var placeholder: String
//    var placeholderColor: Color
//
//    var body: some View {
//        ZStack(alignment: .leading) {
//            if text.isEmpty {
//                Text(placeholder)
//                    .foregroundColor(placeholderColor)
//                    .padding(.horizontal, 8)
//            }
//            TextField("", text: $text)
//                .foregroundColor(.white) // Couleur du texte lorsque le champ est rempli
//                .padding(8)
//        }
//        .background(Color.black)
//        .cornerRadius(8)
//        .padding(16)
//    }
//}
//
//struct ContentView: View {
//    @State private var searchText = ""
//
//    var body: some View {
//        CustomTextField(text: $searchText, placeholder: "Placeholder", placeholderColor: .green)
//    }
//}


struct ContentView: View {
    @State private var selectedDate = Date()

    var body: some View {
        HStack {
            Text("hjiesgkse")
            Image(systemName: "person")
        }
        .background(.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
