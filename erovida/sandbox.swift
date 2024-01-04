import SwiftUI

struct sandbox: View {
    var body: some View {
        Text("Hello, World!")
            .onTapGesture {
                checkKey(hashedKey: "3BLKk4snCr") { success in
                    if success {
                        print("Key is valid.")
                    } else {
                        print("Key is invalid.")
                    }
                }
            }
    }
}


struct sandbox_Previews: PreviewProvider {
    static var previews: some View {
        sandbox()
    }
}
