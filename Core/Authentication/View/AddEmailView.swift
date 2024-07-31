//
//  AddEmailView.swift
//  UniPop-App
//
//  Created by Carly Googel on 6/5/24.
//

import SwiftUI

struct AddEmailView: View {
        @State private var emailValid: Bool = true
        @State private var showValidationError: Bool = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    @State private var email = ""


    var body: some View {


                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color(hex: "E64FFF"), Color(hex: "76F6FE")]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()

                    VStack(alignment: .leading, spacing: 20) {
                        Text("Enter college email")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Text("You must enter your school email to see items in your community and sign in to your account")
                            .font(.callout)
                            .foregroundColor(.white)

                        TextField("johnsmith@edu", text: $viewModel.email)
                            .font(.subheadline)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .autocorrectionDisabled(true)
                            .padding()
                            .background(Color.clear)
                            .foregroundColor(Color(.white))
                            .cornerRadius(10) // Applies
                            .overlay(
                               RoundedRectangle(cornerRadius: 10) //
                                   .stroke(emailValid ? Color.white : Color.red, lineWidth: 1) //
                            )
                             // Sets the keyboard type to email address


                        if showValidationError && !emailValid {
                            Text("Must be a .edu email address")
                                .font(.caption)
                                .foregroundColor(.red)
                        }

                        NavigationLink {
                            CreateUsernameView()
                                .navigationBarBackButtonHidden(true)
                        } label: {

                            Text("Next")
                            // add action
                      //       self.validateEmail()
                         //    self.showValidationError = true
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 50)
                                .foregroundColor(.black)
                                .background(emailValid ? Color.white : Color.gray)
                                .cornerRadius(10)
                        }
                        .disabled(!formValid)
                        .opacity(formValid ? 1.0 : 0.7 )





                            Button("Not in college", action: {
                                })
                                           .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                            .padding(.init(top: 10, leading: 130, bottom: 10, trailing: 10))
                                        }
                                        .padding()
                    Spacer()


                                    }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Image(systemName: "chevron.left")
                            .imageScale(.large)
                            .onTapGesture {
                                dismiss()
                            }
                    }
                }
            }
               // .onTapGesture {
               //     self.endEditing()
               // }
            }

            func validateEmail() {
                if email.hasSuffix(".edu") {
                    emailValid = true
                } else {
                    emailValid = false
                }

    }
}

extension AddEmailView: AuthenticationFormProtocol {

    var formValid: Bool {
        return !viewModel.email.isEmpty
        && (viewModel.email.hasSuffix("upenn.edu") || viewModel.email.hasSuffix("usc.edu"))

    }
}

#Preview {
    AddEmailView()
    }
