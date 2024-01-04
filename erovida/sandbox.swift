import SwiftUI

struct sandbox: View {
    var body: some View {
        Text("Hello, World!")
            .onAppear{
                let key = AESAlgo.generateSymmetricKey(fromPin: "03157126")
                let key64 = AESAlgo.keyToString(key: key)
                let keyHashed = AESAlgo.sha256Hash(from: key64)
                print(keyHashed)
            }
    }
}


struct sandbox_Previews: PreviewProvider {
    static var previews: some View {
        sandbox()
    }
}
