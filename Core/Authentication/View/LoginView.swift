//
//  LoginView.swift
//  UniPop
//
//  Created by Carly Googel on 4/21/24.
//

import SwiftUI
import Firebase

struct LoginView: View {
    // 1
//    @State var email: String = ""
//    @State var password: String = ""
//    @EnvironmentObject var viewModel: AuthViewModel

    @EnvironmentObject var viewModel1: RegistrationViewModel

    @StateObject var viewModel = LoginViewModel()

    // 2
    @State var shouldShowSignUp: Bool = false


    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(hex: "E64FFF"), Color(hex: "76F6FE")]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()

               // Text("Sign In")
               //     .font(.largeTitle)
               //     .fontWeight(.bold)
                //    .foregroundColor(.white)
                //    .padding(.bottom, 100)

                Image("UniPopWordLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 100)

                VStack {



                    TextField("Enter your email", text: $viewModel.email)
                        .autocapitalization(.none)
                    .modifier(TextFieldModifier())




                    SecureField("Password", text: $viewModel.password)
                    .autocapitalization(.none)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.clear)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.white, lineWidth: 1))
                    .frame(width: 358, height: 56, alignment: .center)
                    .font(.system(size: 14))

                    Button {
                        print("Forgot password")
                    } label: {
                        Text("Forgot password")
                            .font(.footnote)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .padding(.top)
                            .padding(.trailing, 20)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)


                    Button {
                   //     Task {  try await viewModel.signIn() }
                        Task {   await viewModel.signIn() }
                    } label: {
                        Text("Login")
                            .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 50)
                                .foregroundColor(.black)
                                .background( Color.white)
                                .frame(width: 358, height: 56, alignment: .center)
                                .cornerRadius(10)
                                .disabled(!formValid)
                                .opacity(formValid ? 1.0 : 0.7 )
                             //   .cornerRadius(10)
                    }
                    .alert("Alert", isPresented: $viewModel.showAlert) {
                             Button("OK", role: .cancel) { }
                         } message: {
                             Text(viewModel.alertMessage)
                         }


                 //   Spacer()

                }

                Spacer()
                Divider()

           //     Button("Don't have an account? Sign Up") {
        //            shouldShowSignUp = true
        //        }
        //        .foregroundColor(.white)
        //        .padding(.vertical)




                NavigationLink {
                 //   SignUpView(showLogin: { shouldShowSignUp = true })
                //        .navigationBarBackButtonHidden(true)

                     AddEmailView()
                     .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                            .foregroundColor(.white)

                        Text("Sign Up")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)

                    }
                    .font(.footnote)
                }


            }
        }
            .onTapGesture {
                self.endEditing()
            }
        }
    }

}

extension LoginView: AuthenticationFormProtocol {
    var formValid: Bool {
        return !viewModel.email.isEmpty
        && viewModel.email.contains(".edu")
        && !viewModel.password.isEmpty
        && viewModel.password.count > 5
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
