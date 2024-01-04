import SwiftUI



struct PasswordView: View {
    struct TabIdentifier: Hashable, Identifiable {
            let id: Int
        }
    
    @Binding var isKeySaved: Bool
    @State private var selectedTab: TabIdentifier?
    @State private var selectedItem: SelectItem?
    @State private var showingSheet: Bool = false
    @State private var text: String = "Main Content"
    @State private var pin: String = "fesfs"
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: 0x001D38)
                    .edgesIgnoringSafeArea(.all)
                
                Text(text)
                    .foregroundColor(.white)
                    .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            Spacer()
                            Button {
                                selectedTab = TabIdentifier(id: 1)
                                text = "ejisf"
                            } label: {
                                Label("", systemImage: "list.dash")
                                    .foregroundColor(selectedTab?.id == 1 ? .blue : .white)
                            }
                            Spacer()
                            Button {
                                selectedTab = TabIdentifier(id: 2)
                                text = "kop"
                            } label: {
                                Label("", systemImage: "plus")
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            Button {
                                selectedTab = TabIdentifier(id: 3)
                            } label: {
                                Label("", systemImage: "person.fill")
                                    .foregroundColor(selectedTab?.id == 3 ? .blue : .white)
                            }
                            Spacer()
                        }
                    }
                    .sheet(item: $selectedTab) { tab in
                        switch tab.id {
                        case 1:
                            Text("tab1")
                        case 2:
                            Text("tab2")
                        case 3:
                            Text("tab3")
                        default:
                            EmptyView()
                        }
                    }
//                    .sheet(isPresented: $showingSheet) {
//                        Text(pin)
//                            .foregroundColor(.black)
//
//                        Button("Send pin") {
//                            pin = retrievePinFromKeychain(keyIdentifier: "pin") ?? "oij"
//
//                        }
//
//                        Button("Se deconnecter") {
//                            deleteKey(keyIdentifier: "key")
//                            isKeySaved = false
//                        }
//                        .buttonStyle(LoginButtonStyle())
//                        .foregroundColor(.black)
//                        .frame(width: 340, height: 60)
//                        .background(Color(hex: 0x4485C4))
//                        .cornerRadius(50)
////                        ZStack{
////                            Color(hex: 0x001D38)
////                                .edgesIgnoringSafeArea(.all)
////                            VStack {
////                                Text("Nouveau")
////                                    .font(.system(size:25, weight: .bold))
////                                    .foregroundColor(.white)
////                                    .padding()
////                                SelectItemView(selectedItem: $selectedItem, showingSheet: $showingSheet)
////                                    .presentationDetents([.medium])
////                                    .presentationDragIndicator(.hidden)
////                            }
////                        }
//                    }
                    .sheet(item: $selectedItem) { selectedItem in
                        switch selectedItem.id {
                        case 1:
                            NewIdentifantView()
                        case 2:
                            NewCardView()
                        case 3:
                            NewNoteView()
                        case 4:
                            ZStack{
                                Color(hex: 0x001D38)
                                    .edgesIgnoringSafeArea(.all)
                                VStack {
                                    Text("Nouveau")
                                        .font(.system(size:25, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding()
                                    NewPasswordView()
                                        .presentationDetents([.height(350)])
                                        .presentationDragIndicator(.hidden)
                                }
                                
                            }
                        default:
                            EmptyView()
                        }
                    }
            }
        }
    }
}

struct PasswordView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordView(isKeySaved: .constant(true))
    }
}
