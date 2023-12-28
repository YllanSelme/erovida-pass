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
                .font(.system(size:25))
                .frame(width: 50, height: 50)
                .padding(10)
            
            VStack(alignment: .leading){
                Text(titleText)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .frame(maxWidth: 230)
                TextField(field, text: $title)
                    .frame(maxWidth: 230)
                    .font(.system(size:25))
                    .foregroundColor(.white)
            }
        }
    }
}
