import Foundation
import SwiftUI

struct LoginButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 20))
            .padding(.horizontal, 50)
            .padding(.vertical, 15)
            .multilineTextAlignment(.center)
    }
}
