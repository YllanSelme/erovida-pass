import SwiftUI
import Combine

struct ContentView: View {
    @State private var isKeySavedByUserBool: Bool = false
    @State private var selectedTab: Int = 1
    @State private var selectedItem: SelectItem?
    @State private var showingSheet: Bool = false
    @State private var text: String = "Hello"
    @State private var pin: String = "fesfs"
    @State private var isKeySaved = false

    var body: some View {
        NavigationView {
            Group {
                if let _ = retrieveKeyFromKeychain(keyIdentifier: "key") {
                    PasswordView(isKeySavedByUserBoolPerma : $isKeySavedByUserBool, isKeySaved: $isKeySaved)
                } else {
                    LoginInView(isKeySaved: $isKeySaved)
                        .onReceive(Just(isKeySaved)) { newValue in
                            if newValue {
                                NavigationLink("", destination: PasswordView(isKeySavedByUserBoolPerma : $isKeySavedByUserBool, isKeySaved: $isKeySaved), isActive: $isKeySaved)
                                    .isDetailLink(false)
                            }
                        }
                }
            }
            .onAppear{
                if let permaBool = retrieveBoolFromKeychain(keyIdentifier: "isKeySavedByUser") {
                    isKeySavedByUserBool = permaBool
                }
            }
            .navigationBarHidden(true)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
