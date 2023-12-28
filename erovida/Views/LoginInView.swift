import SwiftUI

struct LoginInView: View {
    @State private var newAccountSheet = false
    @State private var loginSheet = false
    
    var body: some View {
        ZStack {
            Color(hex: 0x001D38)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Spacer()
                
                Text("Erovida Pass")
                    .font(.system(size:30, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 16) {
                    Button("Créer un nouveau compte") {
                        newAccountSheet.toggle()
                    }
                    .buttonStyle(LoginButtonStyle())
                    .foregroundColor(.black)
                    .frame(width: 340, height: 60)
                    .background(Color(hex: 0x4485C4))
                    .cornerRadius(50)
                    .sheet(isPresented: $newAccountSheet) {
                        NewAccountView()
                    }
                    
                    Button("Se connecter") {
                        loginSheet.toggle()
                    }
                    .buttonStyle(LoginButtonStyle())
                    .foregroundColor(Color(hex: 0x4485C4))
                    .sheet(isPresented: $loginSheet) {
                        SignInView()
                    }
                }
                .padding()
                
                
                Spacer()
                
                Text("Erovida | La sécurité à votre portée")
                    .font(.system(size:20))
                    .foregroundColor(.gray)
                    .padding()
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct LoginInView_Previews: PreviewProvider {
    static var previews: some View {
        LoginInView()
    }
}


