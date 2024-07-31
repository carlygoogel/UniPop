//
//  LoginViewModel.swift
//  UniPop-App
//
//  Created by Carly Googel on 5/27/24.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {

    @Published var email = ""
    @Published var password = ""
    @Published var showAlert = false
     @Published var alertMessage = ""

//    func signIn() async throws {
//        try await AuthService.shared.signIn(withEmail: email, password: password)
//        
//    }
    func signIn() async {
            do {
                try await AuthService.shared.signIn(withEmail: email, password: password)

                // Check if email is verified
                if !AuthService.shared.isEmailVerified {
                    await MainActor.run {
                        self.showAlert = true
                        self.alertMessage = "You must verify your email before logging in. Please check your inbox and verify your email."
                    }
                }
            } catch {
                await MainActor.run {
                    self.showAlert = true
                    self.alertMessage = error.localizedDescription
                }
            }
        }
}
