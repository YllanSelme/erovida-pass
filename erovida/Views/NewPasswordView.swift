import SwiftUI

struct NewPasswordView: View {
    @State private var selectedValue: Double = 8.0
    @State private var generatedPassword: String = ""

    var body: some View {
        VStack {
            HStack {
                Text("\(Int(selectedValue)) caractères : ")
                    .foregroundColor(.white)

                Slider(value: $selectedValue, in: 8...64, step: 1)
                    .padding()
                    .padding(.horizontal, 20)
            }

            Text(generatedPassword)
                .frame(maxWidth: 200)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .foregroundColor(.white)

            Button("Copier dans le presse-papiers") {
                copierDansPressePapiers()
            }
            .padding()
        }
        .padding()
        .onChange(of: selectedValue, perform: { _ in
            generatedPassword = generateString(count: Int(selectedValue))
        })
    }

    func copierDansPressePapiers() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = generatedPassword
    }

    func generateString(count: Int) -> String {
        let characters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789&@*$%")
        var result = ""

        for _ in 0..<count {
            if let randomCharacter = characters.randomElement() {
                result.append(randomCharacter)
            }
        }

        return result
    }
}

struct NewPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        NewPasswordView()
    }
}
