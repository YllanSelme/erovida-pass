import SwiftUI

func stringFormat(text: String) -> String {
    return text.replacingOccurrences(of: "+", with: "_")
}
