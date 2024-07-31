//
//  AuthService.swift
//  UniPop-App
//
//  Created by Carly Googel on 5/27/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

protocol AuthenticationFormProtocol {

    var formValid: Bool { get }
}

class AuthService {

    @Published var userSession: FirebaseAuth.User?
    @Published var isEmailVerified = false


    static let shared = AuthService()

    init() {
        self.userSession = Auth.auth().currentUser
        //
        checkEmailVerification()

        //

        loadCurrentUserData()

        print("DEBUG: User session is \(String(describing: userSession?.uid))")
    }

    @MainActor
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            loadCurrentUserData()
            if result.user.isEmailVerified {
            //                self.userSession = result.user
                            self.isEmailVerified = true
                    //        loadCurrentUserData()
                        } else {
                            throw NSError(domain: "AuthService", code: 1, userInfo: [NSLocalizedDescriptionKey: "Email not verified"])
                        }
        } catch {
            print("DEBUG: Failed to sign in user with \(error.localizedDescription)")
        }
    }

    @MainActor
    func createUser(withEmail email: String, password: String, firstname: String, lastname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user

            // adding line below
            try await result.user.sendEmailVerification()

            // adding above

            try await self.uploadUserData(email: email, firstname: firstname, lastname: lastname, id: result.user.uid)
            loadCurrentUserData()
            print("DEBUG: Create user")

        } catch {
            print("DEBUG: Failed to create user with \(error.localizedDescription)")
        }
    }

    func checkEmailVerification() {
        guard let user = Auth.auth().currentUser else { return }
        user.reload { [weak self] error in
            if let error = error {
                print("Error reloading user: \(error.localizedDescription)")
                return
            }
            self?.isEmailVerified = user.isEmailVerified
            if user.isEmailVerified {
                self?.userSession = user
                self?.loadCurrentUserData()
            } else {
             //   self?.userSession = nil
                print("not valid")
            }
        }
    }


    func resendVerificationEmail() async throws {
        guard let user = Auth.auth().currentUser else { throw NSError(domain: "RegistrationViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "No user logged in"]) }
        try await user.sendEmailVerification()
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.isEmailVerified = false
            UserService.shared.currentUser = nil
        } catch {
            print("DEBUG: failed to sign out with error \(error.localizedDescription)")
        }

    }

    private func uploadUserData(email: String, firstname: String, lastname: String, id: String) async throws {

        let user = User(firstname: firstname, lastname: lastname, email: email, profileImage: nil, status: false)
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(encodedUser)
    }

    private func loadCurrentUserData() {
        Task { try await UserService.shared.fetchCurrentUser() }

    }

}
