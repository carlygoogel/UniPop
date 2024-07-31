//
//  SplashLogin.swift
//  UniPop
//
//  Created by Carly Googel on 4/21/24.
//

import SwiftUI

struct SplashLogin: View {
    @EnvironmentObject var viewModel: RegistrationViewModel


    var body: some View {
        NavigationStack {
        ZStack {
        LinearGradient(gradient: Gradient(colors: [Color(hex: "E64FFF"), Color(hex: "76F6FE")]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            VStack {

                VStack {


                    // Image("UniPop-Logo2")
                        // .resizable()
                      //   .scaledToFit()
                    //     .frame(width: 150, height: 150)
                      //   .padding()
                     Text("UniPop")
                         .font(.largeTitle)
                         .fontWeight(.bold)
                         .foregroundColor(.black)
                Text("your college marketplace")
                    .font(.headline)
                    .foregroundColor(.black)

            }
                .padding(.bottom, 140.0)

            }
            VStack {
                 Spacer()
                 VStack {
                     // Terms and conditions text
                    
                     NavigationLink {
                         LoginView().environmentObject(viewModel)
                     } label: {
                             //     NavigationLink(destination: EnterCollegeEmail().environmentObject(viewModel)) {
                             Text("Sign up")
                                 .frame(minWidth: 0, maxWidth: .infinity)
                                 .frame(height: 50)
                                 .foregroundColor(.black)
                                 .background(Color.white)
                                 .cornerRadius(8)
                                 .padding(.horizontal)
                         }


                 }
                Text("By signing up you accept our\nTerms of use and Privacy policy")
                    .font(.footnote)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
             }
        }
        }
    }
}

struct SplashLogin_Previews: PreviewProvider {
    static var previews: some View {
        SplashLogin()
            .environmentObject(RegistrationViewModel())
    }
}
