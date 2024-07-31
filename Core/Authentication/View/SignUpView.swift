//
//  SignUpView.swift
//  UniPop
//
//  Created by Carly Googel on 4/21/24.
//

import SwiftUI
struct SignUpView: View {
    // 1
    let showLogin: () -> Void

  //  @StateObject var viewModel = RegistrationViewModel()
    @EnvironmentObject var viewModel: RegistrationViewModel


 

    @State var passwordConfirm: String = ""
    @State var shouldShowConfirmSignUp: Bool = false
    @Environment(\.dismiss) var dismiss
  //  @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
    //    NavigationView {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: "E64FFF"), Color(hex: "76F6FE")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        VStack {

            Text("Sign Up")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
              //  .padding(.bottom, 100)


            VStack {
                Spacer()

                TextField("Email", text: $viewModel.email)
                    .autocapitalization(.none)
                .padding()
                   .background(Color.clear)
                   .overlay(RoundedRectangle(cornerRadius: 8)
                               .stroke(Color.white, lineWidth: 1))
                   .frame(width: 358, height: 56, alignment: .center)
                   .foregroundColor(.white)
                   .font(.system(size: 14))

                TextField("Firstname", text: $viewModel.firstname)
                .autocapitalization(.none)
                .padding()
                   .background(Color.clear)
                   .overlay(RoundedRectangle(cornerRadius: 8)
                               .stroke(Color.white, lineWidth: 1))
                   .frame(width: 358, height: 56, alignment: .center)
                   .foregroundColor(.white)
                   .font(.system(size: 14))

                TextField("Lastname", text: $viewModel.lastname)
                .autocapitalization(.none)
                .padding()
                   .background(Color.clear)
                   .overlay(RoundedRectangle(cornerRadius: 8)
                               .stroke(Color.white, lineWidth: 1))
                   .frame(width: 358, height: 56, alignment: .center)
                   .foregroundColor(.white)
                   .font(.system(size: 14))

                SecureField("Passowrd", text: $viewModel.password)
                .autocapitalization(.none)
                .padding()
                   .background(Color.clear)
                   .overlay(RoundedRectangle(cornerRadius: 8)
                               .stroke(Color.white, lineWidth: 1))
                   .frame(width: 358, height: 56, alignment: .center)
                   .foregroundColor(.white)
                   .font(.system(size: 14))

            ZStack(alignment: .trailing) {
            SecureField("Confirm Password", text: $passwordConfirm)
                .padding()
                   .background(Color.clear)
                   .overlay(RoundedRectangle(cornerRadius: 8)
                               .stroke(Color.white, lineWidth: 1))
                   .frame(width: 358, height: 56, alignment: .center)
                   .foregroundColor(.white)
                   .font(.system(size: 14))

                if !viewModel.password.isEmpty && !passwordConfirm.isEmpty {
                    if viewModel.password == passwordConfirm {
                        Image(systemName: "checkmark.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(Color(.systemGreen))
                    } else {
                        Image(systemName: "xmark.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(Color(.systemRed))
                    }
                }
            }

            Button("Sign Up", action: {
                Task {
              //      try await viewModel.createUser(withEmail: email, password: password, firstname: firstname, lastname: lastname)
                    try await viewModel.createUser()
                }
            })
                .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.black)
                    .background( Color.white)
                    .cornerRadius(10)
                    .frame(width: 358, height: 56, alignment: .center)
                    .disabled(!formValid)
                    .opacity(formValid ? 1.0 : 0.7 )
                Spacer()

            }


            Divider()


            NavigationLink {
                LoginView()
                    .navigationBarBackButtonHidden(true)

            } label: {
                Text("Already have an account? Login.")
                    .foregroundColor(.white)
            }
        }

    }
        }

}

extension SignUpView: AuthenticationFormProtocol {
    var formValid: Bool {
        return !viewModel.email.isEmpty
        && viewModel.email.contains("upenn.edu")
        && !viewModel.password.isEmpty
        && viewModel.password.count > 5
        && passwordConfirm == viewModel.password
    //    && !viewModel.lastname.isEmpty
      //  && !viewModel.firstname.isEmpty
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(showLogin: {})
    }
}

