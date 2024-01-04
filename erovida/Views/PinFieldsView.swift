import SwiftUI

struct PinFieldView: View {
    @FocusState private var pinFocusState: SignInView.FocusPin?
    @Binding var pinValues: [String]

    var body: some View {
        VStack {
            ForEach(0..<2) { row in
                HStack(spacing: 10) {
                    ForEach(0..<8) { col in
                        let index = row * 8 + col
                        TextField("", text: $pinValues[index], onEditingChanged: { editing in
                            setFocusState(for: index, isEditing: editing)
                        })
                        .modifier(OtpModifer(pin: $pinValues[index], isEditing: isEditing(at: index)))
                        .focused($pinFocusState, equals: focusState(for: index))
                        .onChange(of: pinValues[index]) { newValue in
                            updateFocusState(afterEditing: newValue, atIndex: index)
                        }
                    }
                }
            }

            Button("Recommencer") {
                pinValues = Array(repeating: "", count: 16)
                pinFocusState = .pinOne
            }
            .font(.system(size: 17))
            .padding()
        }
        .padding()
    }

    private func setFocusState(for index: Int, isEditing: Bool) {
        guard isEditing else { return }
        pinFocusState = focusState(for: index)
    }

    private func isEditing(at index: Int) -> Bool {
        pinFocusState == focusState(for: index)
    }

    private func focusState(for index: Int) -> SignInView.FocusPin {
        SignInView.FocusPin.allCases[index]
    }

    private func updateFocusState(afterEditing newValue: String, atIndex index: Int) {
        if newValue.isEmpty {
            let previousIndex = max(0, index - 1)
            pinFocusState = focusState(for: previousIndex)
        } else if index < pinValues.count - 1 {
            let nextIndex = min(index + 1, pinValues.count - 1)
            pinFocusState = focusState(for: nextIndex)
        }
    }
}
