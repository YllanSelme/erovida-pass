import SwiftUI
import Combine

struct SignInView: View {
    enum FocusPin {
        case  pinOne, pinTwo, pinThree, pinFour, pinFive, pinSix, pinSeven, pinEight
    }
    
    @FocusState private var pinFocusState : FocusPin?
    
    @State private var isEditingOne: Bool = false
    @State private var isEditingTwo: Bool = false
    @State private var isEditingThree: Bool = false
    @State private var isEditingFour: Bool = false
    @State private var isEditingFive: Bool = false
    @State private var isEditingSix: Bool = false
    @State private var isEditingSeven: Bool = false
    @State private var isEditingEight: Bool = false
    
    @State private var isSignInButtonDisabled: Bool = true
    
    @State private var pinOne: String = ""
    @State private var pinTwo: String = ""
    @State private var pinThree: String = ""
    @State private var pinFour: String = ""
    @State private var pinFive: String = ""
    @State private var pinSix: String = ""
    @State private var pinSeven: String = ""
    @State private var pinEight: String = ""
    
    var body: some View {
        ZStack {
            Color(hex: 0x001D38)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Text("Connectez vous simplement")
                    .font(.system(size:30, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .multilineTextAlignment(.center)
                
                Text("Entrez le code fourni lors de la création de votre compte")
                    .font(.system(size:20, weight: .medium))
                    .foregroundColor(.gray)
                    .padding()
                    .multilineTextAlignment(.center)
                
                VStack {
                    HStack(spacing: 10) {
                        TextField("", text: $pinOne, onEditingChanged: { editing in
                            isEditingOne = editing
                        })
                        .modifier(OtpModifer(pin: $pinOne, isEditing: isEditingOne))
                        .focused($pinFocusState, equals: .pinOne)
                        .onChange(of: pinOne) { newValue in
                            if newValue.count >= 1 {
                                pinFocusState = .pinTwo
                            }
                        }
                        
                        TextField("", text: $pinTwo, onEditingChanged: { editing in
                            isEditingTwo = editing
                        })
                        .modifier(OtpModifer(pin: $pinTwo, isEditing: isEditingTwo))
                        .focused($pinFocusState, equals: .pinTwo)
                        .onChange(of: pinTwo) { newValue in
                            if newValue.count >= 1 {
                                pinFocusState = .pinThree
                            }
                            else if newValue.count == 0 {
                                pinFocusState = .pinOne
                            }
                        }
                        
                        
                        TextField("", text: $pinThree, onEditingChanged: { editing in
                            isEditingThree = editing
                        })
                        .modifier(OtpModifer(pin: $pinThree, isEditing: isEditingThree))
                        .focused($pinFocusState, equals: .pinThree)
                        .onChange(of: pinThree) { newValue in
                            if newValue.count >= 1 {
                                pinFocusState = .pinFour
                            }
                            else if newValue.count == 0 {
                                pinFocusState = .pinTwo
                            }
                        }
                        
                        
                        TextField("", text: $pinFour, onEditingChanged: { editing in
                            isEditingFour = editing
                        })
                        .modifier(OtpModifer(pin: $pinFour, isEditing: isEditingFour))
                        .focused($pinFocusState, equals: .pinFour)
                        .onChange(of: pinFour) { newValue in
                            if newValue.count >= 1 {
                                pinFocusState = .pinFive
                            }
                            else if newValue.count == 0 {
                                pinFocusState = .pinThree
                            }
                        }
                        
                        
                        
                        TextField("", text: $pinFive, onEditingChanged: { editing in
                            isEditingFive = editing
                        })
                        .modifier(OtpModifer(pin: $pinFive, isEditing: isEditingFive))
                        .focused($pinFocusState, equals: .pinFive)
                        .onChange(of: pinFive) { newValue in
                            if newValue.count >= 1 {
                                pinFocusState = .pinSix
                            }
                            else if newValue.count == 0 {
                                pinFocusState = .pinFour
                            }
                        }
                        
                        
                        TextField("", text: $pinSix, onEditingChanged: { editing in
                            isEditingSix = editing
                        })
                        .modifier(OtpModifer(pin: $pinOne, isEditing: isEditingSix))
                        .focused($pinFocusState, equals: .pinSix)
                        .onChange(of: pinSix) { newValue in
                            if newValue.count >= 1 {
                                pinFocusState = .pinSeven
                            }
                            else if newValue.count == 0 {
                                pinFocusState = .pinFive
                            }
                        }
                        
                        
                        TextField("", text: $pinSeven, onEditingChanged: { editing in
                            isEditingSeven = editing
                        })
                        .modifier(OtpModifer(pin: $pinSeven, isEditing: isEditingSeven))
                        .focused($pinFocusState, equals: .pinSeven)
                        .onChange(of: pinSeven) { newValue in
                            if newValue.count >= 1 {
                                pinFocusState = .pinEight
                            }
                            else if newValue.count == 0 {
                                pinFocusState = .pinSix
                            }
                        }
                        
                        TextField("", text: $pinEight, onEditingChanged: { editing in
                            isEditingEight = editing
                        })
                        .modifier(OtpModifer(pin: $pinEight, isEditing: isEditingEight))
                        .focused($pinFocusState, equals: .pinEight)
                        .onChange(of: pinEight) { newValue in
                            if newValue.count == 0 {
                                pinFocusState = .pinSeven
                            }
                        }
                        
                        
                    }
                    Button {
                        pinOne = ""
                        pinTwo = ""
                        pinThree = ""
                        pinFour = ""
                        pinFive = ""
                        pinSix = ""
                        pinSeven = ""
                        pinEight = ""
                    } label: {
                        Text("Recommencer")
                            .font(.system(size: 17))
                    }
                }
                .padding()
                
                Button("Se connecter") {
                    print("jioges")
                }
                .disabled(checkFields())
                .buttonStyle(LoginButtonStyle())
                .foregroundColor(.black)
                .frame(width: 340, height: 60)
                .background(checkFields() ? Color(hex: 0x2F70AF) : Color(hex: 0x4485C4))
                .cornerRadius(50)
            }
        }
    }
        
    func checkFields() -> Bool{
        return pinOne.isEmpty || pinTwo.isEmpty || pinThree.isEmpty || pinFour.isEmpty || pinFive.isEmpty || pinSix.isEmpty || pinSeven.isEmpty || pinEight.isEmpty
    }
    
}


struct SignInView_Preview: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
