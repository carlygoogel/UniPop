//
//  RequestStatusView.swift
//  UniPop-App
//
//  Created by Carly Googel on 6/13/24.
//

import SwiftUI

struct RequestStatusView: View {
    @State private var showingAlert = false
    @State private var enterEmail = ""
    @State private var description = ""
    //@S

    @StateObject var userStatusViewModel = UserStatusViewModel()
  //  @StateObject var userStatusViewModel: UserStatusViewModel

 //   init(currentUser: User) {
  //      _userStatusViewModel = StateObject(wrappedValue: UserStatusViewModel(currentUser: currentUser))
    //}

    var body: some View {
        //  if !(userStatusViewModel.currentUser?.status ?? true) {


        VStack(spacing: 20) {
            NavigationStack {

            Text("Request UniPop Seller Status")
                .font(.title2)
                .fontWeight(.bold)
                .padding()

            Text("Please fill out your email along with a brief description of what you're looking to sell!")
                .font(.subheadline)
                .fontWeight(.regular)

                TextField("Enter email", text: $enterEmail)
            //   .textFieldStyle(RoundedBorderTextFieldStyle())
                .modifier(TextFieldModifier2())
                .frame(width: 320, height: 50)
                .foregroundColor(.black)
            //      .shadow(radius: 10)
            //  .padding()

                TextField("ex. I'm in XYZ sorority and want to sell a lot of items to make money! Selling vintage sorority merch, my spring break outfits, etc.", text: $description,  axis: .vertical)
                .modifier(TextFieldModifier2())
                .frame(width: 320, height: 100)
                .lineLimit(4...8)
                .foregroundColor(.black)
            //   .shadow(radius: 10)

            NavigationLink {
                
                RequestStatusSuccessView()
                    .navigationBarBackButtonHidden(true)
                    .onAppear {
                        Task {
        try await userStatusViewModel.requestStatus(email: enterEmail, description: description)

                            try await userStatusViewModel.updateUserData()

        }
                    }


            } label: {

                
             //     if !(userStatusViewModel.currentUser?.submittedForm ?? true) {

                Text("Submit")
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "E64FFF"), Color(hex: "76F6FE")]), startPoint: .leading, endPoint: .trailing))
                                    .foregroundColor(.black)
                                    .fontWeight(.semibold)
                                    .cornerRadius(8)

             //     } else {
             //         Text("Successfully Sent")

              //    }
                // add outline error that must be same email yu signed up with


            }
            .disabled(!formValid)
            .opacity(formValid ? 1.0 : 0.9 )


            .padding()
        }
        .frame(width: 350, height: 420)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 20)
        .padding()
    }
    //           }
        .onTapGesture {
            self.endEditing()
        }

}

//    }
}

extension RequestStatusView: AuthenticationFormProtocol {
    var formValid: Bool {
        return !enterEmail.isEmpty
        && !description.isEmpty
        && enterEmail.contains("upenn.edu")
        // work on adding later, seems to cause delay
     //   && userStatusViewModel.currentUser?.email == enterEmail


    }
}

extension View {
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

