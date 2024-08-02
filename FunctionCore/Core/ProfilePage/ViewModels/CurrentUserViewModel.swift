//
//  CurrentUserViewModel.swift
//  UniPop-App
//
//  Created by Carly Googel on 6/7/24.
//

import Foundation
import Combine
import Firebase

class CurrentUserViewModel: ObservableObject {
    @Published var currentUser: User?

    private var cancellables = Set<AnyCancellable>()

    

    init() {
        setupSubscribers()
    }


    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellables)

    }
    // added
//    @MainActor
//        func fetchUser() async {
//            do {
//                try await UserService.shared.fetchCurrentUser()
//            } catch {
//                print("Error fetching current user: \(error.localizedDescription)")
//            }
//        }

}
