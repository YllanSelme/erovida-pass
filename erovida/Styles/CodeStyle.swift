import SwiftUI

struct OtpModifer: ViewModifier {
    @Binding var pin: String
    var isEditing: Bool

    var textLimit = 1

    func limitText() {
        if pin.count > textLimit {
            self.pin = String(pin.prefix(textLimit))
        }
        self.pin = self.pin.filter { $0.isNumber }
    }

    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onChange(of: pin) { _ in limitText() }
            .frame(width: 30, height: 40)
            .background(Color(hex: 0x001D38).cornerRadius(5))
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(isEditing ? Color.blue : Color.white, lineWidth: isEditing ? 2 : 1)
            )
    }
}
