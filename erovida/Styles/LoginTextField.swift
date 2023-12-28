import SwiftUI

struct LoginTextField: ViewModifier {
    var error: Bool
    var isEditing: Bool

    func body(content: Content) -> some View {
        content
            .padding(10)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(error ? Color.red : isEditing ? Color.blue : Color.white, lineWidth: isEditing ? 2 : 1)
            )
    }
}
