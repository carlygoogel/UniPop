//
//  ContentView.swift
//  UniPop-App
//
//  Created by Carly Googel on 4/23/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @StateObject var registrationViewModel = RegistrationViewModel()




    var body: some View {
        Group {
            if viewModel.userSession != nil && viewModel.isEmailVerified {
             //   SplashLogin()
                MainTabView()
//            } else if viewModel.userSession != nil  {
//                SplashLogin()
//                    .environmentObject(registrationViewModel)
            } else {
                SplashLogin()
                 .environmentObject(registrationViewModel)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//Group {
//    if viewModel.userSession == nil {
//        SplashLogin()
//         .environmentObject(registrationViewModel)
//    } else if let currentUser = viewModel2.currentUser
//}
