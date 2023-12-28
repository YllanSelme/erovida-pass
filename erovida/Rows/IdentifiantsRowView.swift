import SwiftUI

struct IdentifiantsRowView: View {
    @Binding var title:String
    @State var imageName:String
    @State var titleText:String
    @State var field:String
    
    var body: some View {
        HStack{
            Image(systemName: imageName)
                .foregroundColor(.white)
                .font(.system(size:24))
                .frame(width: 50, height: 50)
                .padding(10)
            
            VStack(alignment: .leading, spacing: 0){
                Text(titleText)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .frame(maxWidth: 230)
                IdentifiantTextField(text: $title, placeholder: field, placeholderColor: Color(.gray))
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .frame(maxWidth: 230)
            }
        }
    }
}

struct RowView: View {
    @State var name: String = "Exemple Name"
    var body: some View {
        IdentifiantsRowView(title: $name, imageName: "person", titleText: "Nom d'utilisateur ou adresse mail", field: "Ajoutez votre nom d'utilisateur ou adresse mail")
    }
}

struct IdentifiantsRowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView()
    }
}
