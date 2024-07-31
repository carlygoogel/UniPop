//
//  PostGridViewModelOther.swift
//  UniPop-App
//
//  Created by Carly Googel on 7/19/24.
//

import Foundation

class PostGridViewModelOther: ObservableObject {
    private let user: User
    @Published var posts = [Post]()

    init(user: User) {
        self.user = user
        Task { try await fetchUserPosts() }
    }

    @MainActor
    func fetchUserPosts() async throws {
        self.posts = try await PostService.fetchUserPosts(uid: user.id)

        for i in 0 ..< posts.count {
            posts[i].user = self.user
        }
    }
}
