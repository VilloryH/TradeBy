import SwiftUI

struct SignInView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var emailError = false
    @State private var loginError = false
    @EnvironmentObject private var coordinator: Coordinator
    @ObservedObject var viewModel = LoginViewModel()
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea(.all)
            signInContentView
        }
    }
    
    var signInContentView: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Sign in")
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
                
                TextField("", text: $lastName)
                    .padding(.horizontal)
                    .placeholder(when: lastName.isEmpty) {
                        HStack {
                            Spacer()
                            Text("Last name")
                                .foregroundColor(.gray)
                                .bold()
                                .opacity(0.6)
                            Spacer()
                        }
                    }
                    .frame(height: 40)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
                
                TextField("", text: $email)
                    .padding(.horizontal)
                    .foregroundColor(emailError ? .red : .black)
                    .placeholder(when: email.isEmpty) {
                        HStack {
                            Spacer()
                            Text("Email")
                                .foregroundColor(.gray)
                                .bold()
                                .opacity(0.6)
                            Spacer()
                        }
                    }
                    .frame(height: 40)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
                if emailError {
                    Text("Incorrect email")
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }
            
            Spacer()
            VStack {
                Button {
                    emailError = !isValidEmail(email: email)
                    let mail = email
                    email = mail
                    if !emailError && !email.isEmpty && !firstName.isEmpty && !lastName.isEmpty {
                        if !viewModel.checkSingin(firstName: firstName, lastName: lastName, email: email) {
                            viewModel.saveLogin(firstName: firstName, lastName: lastName, email: email)
                            coordinator.present(fullScreen: .content)
                        }
                        else {
                            loginError = true
                        }
                    }
                  
                } label: {
                    Text("Sign in")
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 50, height: 60)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color("DarkPurple")))
                }
                if loginError {
                    Text("User is already registered")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
            HStack {
                Text("Already have an account?")
                    .foregroundColor(.gray)
                    .font(.caption)
                Button {
                    coordinator.present(fullScreen: .login)
                } label: {
                    Text("Log in")
                        .font(.caption)
                }
                Spacer()
            }.padding(.horizontal)
            Spacer()
                HStack {
                    VStack(spacing: 30) {
                        Image("google_logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                        Image(systemName: "apple.logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                        
                    }
                    VStack(spacing: 40) {
                        Button {
                            
                        } label: {
                            Text("Sign in with Google")
                        }
                        Button {
                            
                        } label: {
                            Text("Sign in with Apple")
                        }
                    }.foregroundColor(.black)
            }
            Spacer()
        }.padding()
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
 
    
    
    


}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
