//
//  ContentViewModel.swift
//  UniPop-App
//
//  Created by Carly Googel on 5/27/24.
//

import Foundation
import Firebase
import Combine

@MainActor
class ContentViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    @Published var isEmailVerified = false

    private let userService = UserService.shared

    private let authService = AuthService.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
        setupSubscribers()
        checkEmailVerification()


    }

    private func setupSubscribers() {
        authService.$userSession.sink { [weak self] userSessionFromAuthService in
            self?.userSession = userSessionFromAuthService
        }.store(in: &cancellables)

        authService.$isEmailVerified.sink { [weak self] isVerified in
                self?.isEmailVerified = isVerified
            }.store(in: &cancellables)
    }



    func checkEmailVerification() {
        Task {
              authService.checkEmailVerification()
        }
    }



}


