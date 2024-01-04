import SwiftUI

struct IdentifiantTextField: View {
    @Binding var text: String
    var placeholder: String
    var placeholderColor: Color

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .font(.system(size: 23, weight: .medium))
                    .foregroundColor(placeholderColor)
                    .padding(.horizontal, 8)
            }
            TextField("", text: $text)
                .font(.system(size: 23, weight: .medium))
                .foregroundColor(.white)
                .padding(8)
        }
        .background(Color.black)
        .cornerRadius(8)
    }
}

struct IdentifiantTitleView: View {
    @Binding var text: String
    var placeholder: String
    var placeholderColor: Color

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(placeholderColor)
                    .padding(.horizontal, 8)
            }
            TextField("", text: $text)
                .foregroundColor(.white)
                .font(.system(size: 40, weight: .bold))
                .padding(8)
        }
        .cornerRadius(8)
    }
}

