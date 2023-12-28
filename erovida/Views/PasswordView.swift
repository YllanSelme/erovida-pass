import SwiftUI

struct PasswordView: View {
    @State private var selectedTab: Int = 1
    @State private var selectedItem: SelectItem?
    @State private var showingSheet: Bool = false
    @State private var text: String = "Hello"
    
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
                                selectedTab = 1
                                text = "ejisf"
                            } label: {
                                Label("", systemImage: "list.dash")
                                    .foregroundColor(selectedTab == 1 ? .blue : .white)
                            }
                            Spacer()
                            Button {
                                showingSheet = true
                            } label: {
                                Label("", systemImage: "plus")
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            Button {
                                selectedTab = 3
                                text = "fesgesg"
                            } label: {
                                Label("", systemImage: "person.fill")
                                    .foregroundColor(selectedTab == 3 ? .blue : .white)
                            }
                            Spacer()
                        }
                    }
                    .sheet(isPresented: $showingSheet) {
                        ZStack{
                            Color(hex: 0x001D38)
                                .edgesIgnoringSafeArea(.all)
                            VStack {
                                Text("Nouveau")
                                    .font(.system(size:25, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding()
                                SelectItemView(selectedItem: $selectedItem, showingSheet: $showingSheet)
                                    .presentationDetents([.medium])
                                    .presentationDragIndicator(.hidden)
                            }
                        }
                    }
                    .sheet(item: $selectedItem) { selectedItem in
                        switch selectedItem.id {
                        case 1:
                            Text("\(selectedItem.title)")
                        case 2:
                            Text("\(selectedItem.title)")
                        case 3:
                            Text("\(selectedItem.title)")
                        case 4:
                            Text("\(selectedItem.title)")
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
        PasswordView()
    }
}
