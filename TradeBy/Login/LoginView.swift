import SwiftUI

struct LoginView: View {
    @State private var firstName = ""
    @State private var password = ""
    @State private var passwordIsSecured = true
    @State private var loginError = false
    @EnvironmentObject private var coordinator: Coordinator
    @ObservedObject var viewModel = LoginViewModel()
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea(.all)
            loginView
        }
    }
    
    var loginView: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Welcome back")
                .font(.largeTitle).bold()
            Spacer()
            VStack(spacing: 30) {
                TextField("", text: $firstName)
                    .padding(.horizontal)
                    .placeholder(when: firstName.isEmpty) {
                        HStack {
                            Spacer()
                            Text("First name")
                                .foregroundColor(.gray)
                                .bold()
                                .opacity(0.6)
                            Spacer()
                        }
                    }
                
                    .frame(height: 40)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
                
                LoginSecureField(field: $password, isSecured: $passwordIsSecured, placeholder: "Password")
            }
            Spacer()
            Button {
                if viewModel.checkLogin(firstName: firstName) {
                    withAnimation(.easeInOut) {
                        coordinator.present(fullScreen: .content)
                    }
                }
                else {
                   loginError = true
                }
            } label: {
                Text("Login")
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 50, height: 60)
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color("DarkPurple")))
            }
            if loginError {
                VStack {
                    Text("User not found")
                        .foregroundColor(.red)
                        .font(.caption)
                    Button {
                        coordinator.dismissFullscreenCover()
                    } label: {
                        Text("Sign in")
                            .font(.caption)
                    }
                }
            }
            Spacer()
        }.padding()
    }
    
   
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
