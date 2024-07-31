//
//  CreatePasswordView.swift
//  UniPop-App
//
//  Created by Carly Googel on 6/5/24.
//

import SwiftUI

struct CreatePasswordView: View {
    @Environment(\.dismiss) var dismiss
     @EnvironmentObject var viewModel: RegistrationViewModel
     @State private var password = ""


    var body: some View {

        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: "E64FFF"), Color(hex: "76F6FE")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()

                VStack(alignment: .leading, spacing: 20) {
                    Text("Create password")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text("Your password must be at least 6 figures in length")
                        .font(.callout)
                        .foregroundColor(.white)

                    SecureField("Password", text: $viewModel.password)
                        .font(.subheadline)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.clear)
                        .foregroundColor(Color(.white))
                        .cornerRadius(10) // Applies
                        .overlay(
                            RoundedRectangle(cornerRadius: 10) //
                                .stroke(Color.white, lineWidth: 1) //
                        )





                    NavigationLink {
                        CompleteSignUpView()
                            .navigationBarBackButtonHidden(true)

                    } label: {

                        Text("Next")

                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
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
    }
}

#Preview {
    CreatePasswordView()
}
