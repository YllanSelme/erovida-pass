import SwiftUI

struct SelectItemView: View {
    @Binding var selectedItem: SelectItem?
    @Binding var showingSheet: Bool
    
    var items: [SelectItem] = [
        SelectItem(id: 1, backgroundColor: Color(hex: 0x7D41A2), color: Color(hex: 0x806491), imageName: "person", title: "Un identifiant", subTitle: "Conservez vos identifiants pour vous connectez à vos services facilement."),
        SelectItem(id: 2, backgroundColor: Color(hex : 0x297354), color: Color(hex : 0x298F64), imageName: "creditcard", title: "Des informations bancaires", subTitle: "Gardez vos codes de cartes bancaires de manière sécurisée."),
        SelectItem(id: 3, backgroundColor: Color(hex: 0x2F5090), color: Color(hex: 0x3463BD), imageName: "list.bullet.clipboard", title: "Une note", subTitle: "Sécurisez vos mots de passes, listes de courses, et toutes autres pensés."),
        SelectItem(id: 4, backgroundColor: Color(hex: 0x9F2929), color: Color(hex: 0xDB4242), imageName: "key", title: "Un mot de passe", subTitle: "Générez un mot de passe robuste.")
    ]

    var body: some View {
        List(items) { item in
            SelectItemRows(backgroundColor: item.backgroundColor, color: item.color, imageName: item.imageName, title: item.title, subTitle: item.subTitle)
                .listRowBackground(Color(hex: 0x001D38))
                .onTapGesture {
                    selectedItem = item
                    showingSheet.toggle()
                }
        }
        .listStyle(.plain)
    }
}
