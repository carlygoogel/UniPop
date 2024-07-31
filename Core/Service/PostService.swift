//
//  PostService.swift
//  UniPop-App
//
//  Created by Carly Googel on 6/12/24.
//

import Firebase

struct PostService {

    static func fetchFeedPosts() async throws -> [Post] {
        let snapshot = try await Firestore.firestore().collection("posts").getDocuments()
        var posts = try snapshot.documents.compactMap({ try $0.data(as: Post.self) })

        for i in 0 ..< posts.count {
            let post = posts[i]
            let ownerUid = post.ownerUid
            let postUser = try await UserService.fetchUserByUid(withUid: ownerUid)
            posts[i].user = postUser
        }

        return posts
    }

    static func fetchUserPosts(uid: String) async throws -> [Post] {
        // postCollection = Firestore.firestore().collection("posts")
        let snapshot = try await Firestore.firestore().collection("posts").whereField("ownerUid", isEqualTo: uid).getDocuments()
        return try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
    }
}
