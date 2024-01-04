import SwiftUI
import Combine

struct ContentView: View {
    @State private var selectedTab: Int = 1
    @State private var selectedItem: SelectItem?
    @State private var showingSheet: Bool = false
    @State private var text: String = "Hello"
    @State private var pin: String = "fesfs"
    @State private var isKeySaved = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.blue)
                    .edgesIgnoringSafeArea(.all)
                Text(text)
                    .foregroundColor(.white)
                    .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            Spacer()
                            Button {
                                selectedTab = 1
                            } label: {
                                Label("", systemImage: "list.dash")
                            }
                            Spacer()
                            Button {
                                selectedTab = 2
                            } label: {
                                Label("", systemImage: "plus")
                            }
                            Spacer()
                            Button {
                                selectedTab = 2
                            } label: {
                                Label("", systemImage: "person.fill")
                            }
                            Spacer()
                        }
                    }
            }
        }
//        NavigationView {
//            Group {
//                if let _ = retrieveKeyFromKeychain(keyIdentifier: "key") {
//                    PasswordView(isKeySaved: $isKeySaved)
//                } else {
//                    LoginInView(isKeySaved: $isKeySaved)
//                        .onReceive(Just(isKeySaved)) { newValue in
//                            if newValue {
//                                NavigationLink("", destination: PasswordView(isKeySaved: $isKeySaved), isActive: $isKeySaved)
//                                    .isDetailLink(false)
//                            }
//                        }
//                }
//            }
//            .navigationBarHidden(true)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
