//
//  CreateUsernameView.swift
//  UniPop-App
//
//  Created by Carly Googel on 6/5/24.
//

import SwiftUI

struct CreateUsernameView: View {

    @Environment(\.dismiss) var dismiss
     @EnvironmentObject var viewModel: RegistrationViewModel
     @State private var firstname = ""
    @State private var lastname = ""

    var body: some View {

        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: "E64FFF"), Color(hex: "76F6FE")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    Text("Enter name")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text("You can create a username in app for display!")
                        .font(.callout)
                        .foregroundColor(.white)
                        .padding(.horizontal, 5)

                    TextField("Enter firstname", text: $viewModel.firstname)
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

             //       Text("Lastname")
               //         .font(.callout)
                 //       .foregroundColor(.white)


                   // Text("Pick a username for your account. You can always change it later")
                     //   .font(.callout)
                       // .foregroundColor(.white)

                    TextField("Enter lastname", text: $viewModel.lastname)
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
                        CreatePasswordView()
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
    CreateUsernameView()
}
