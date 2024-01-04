import SwiftUI

func stringFormat(text: String) -> String {
    return text.replacingOccurrences(of: "+", with: "_")
}

func insertNewline(pin: String, at index: Int) -> String {
    if pin.count > 8{
        var mutablePin = pin
        mutablePin.insert("\n", at: pin.index(pin.startIndex, offsetBy: index))
        return mutablePin
    }else {
        return pin
    }
}
