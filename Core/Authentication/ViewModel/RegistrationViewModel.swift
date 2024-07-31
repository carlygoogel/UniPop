//
//  RegistrationViewModel.swift
//  UniPop-App
//
//  Created by Carly Googel on 5/27/24.
//

import Foundation
import SwiftUI

@MainActor
class RegistrationViewModel: ObservableObject {

    @Published var email = ""
    @Published var password = ""
    @Published var firstname: String = ""
    @Published var lastname: String = ""
    //added below
    @Published var verificationCode: String = ""
    @Published var isEmailSent = false
    @Published var isEmailVerified = false

    func createUser() async throws {

        try await AuthService.shared.createUser(withEmail: email, password: password, firstname: firstname, lastname: lastname)

        //

//

         email = ""
         password = ""
         firstname = ""
         lastname = ""
    }

    // added below
    func verifyEmail() async throws {
         AuthService.shared.checkEmailVerification()
        isEmailVerified = AuthService.shared.isEmailVerified
        isEmailSent = true

    }

    func resendVerification() async throws {
        try await AuthService.shared.resendVerificationEmail()
        isEmailSent = true
    }

 
//

}
