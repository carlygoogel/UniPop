//
//  SearchViewModel.swift
//  UniPop-App
//
//  Created by Carly Googel on 6/10/24.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var users = [User]()

    init() {
        Task { try await fetchAllUsers() }
    }

    @MainActor
    func fetchAllUsers() async throws {
        self.users = try await UserService.fetchAllUsers()
    }
}
