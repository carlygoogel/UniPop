//
//  CompleteSignUpView.swift
//  UniPop-App
//
//  Created by Carly Googel on 6/5/24.
//

import SwiftUI

struct CompleteSignUpView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel

    // added below
    @State private var showAlert = false
    @State private var showAlert2 = false
    @State private var alertMessage = ""
    @State private var isLoading = false
    @State private var navigateToContentView = false






    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(hex: "E64FFF"), Color(hex: "76F6FE")]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 12) {
                    Spacer()

                    Image("UniPopA")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)

                    Text("Welcome to UniPop")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)


                    Text("Click below to complete registration and start browsing cool things at your university marketplace")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)

                    Button {
                        signUp()
                    } label: {
                        Text(isLoading ? "Creating Account..." : "Verify Email and Continue")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(.top)
                    }
                    .disabled(isLoading)

//                    NavigationLink {
//                        ContentView()
//                            .navigationBarBackButtonHidden(true)
//
//                    } label: {
//
//                        Text("Log in")
//                            .frame(minWidth: 0, maxWidth: .infinity)
//                            .frame(height: 50)
//                            .foregroundColor(.black)
//                            .background(Color.white)
//                            .cornerRadius(10)
//                            .padding(.top)
//                    }

                    //                if viewModel.isEmailVerified {
                    //                    NavigationLink {
                    //                        LoginView()
                    //                            .navigationBarBackButtonHidden(true)
                    //
                    //                    } label: {
                    //
                    //                        Text("Log in")
                    //
                    //                            .frame(minWidth: 0, maxWidth: .infinity)
                    //                            .frame(height: 50)
                    //                            .foregroundColor(.black)
                    //                            .background(Color.white)
                    //                            .cornerRadius(10)
                    //                    }
                    //                }

                    //
                    Spacer()


                }
                .padding()

            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Notification"), message: Text(alertMessage),
                      dismissButton: .default(Text("OK")) {
                    if showAlert2 {
                        navigateToContentView = true
                    }
                }
                )
            }
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
//
        .navigationDestination(isPresented: $navigateToContentView) {
                       ContentView()
                           .navigationBarBackButtonHidden(true)
                   }

    }


    private func signUp() {
        isLoading = true
        Task {
            do {
                if isValidEmail(viewModel.email) {
                    try await viewModel.createUser()
                    showAlert = true
                    alertMessage = "Verification email sent. Please check your inbox."


                } else {
                    showAlert = true
                    alertMessage = "Please navigate to login."
                }
            } catch {
                showAlert = true
                alertMessage = "Error: \(error.localizedDescription)"
            }
            isLoading = false
            showAlert = true
            showAlert2 = true

        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.edu"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}

#Preview {
    CompleteSignUpView()
}
