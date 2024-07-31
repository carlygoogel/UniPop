//
//  UserService.swift
//  UniPop-App
//
//  Created by Carly Googel on 5/28/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


class UserService {

    @Published var currentUser: User?

    static let shared = UserService()

    // added make sure no problem
    init() {
        Task { try await fetchCurrentUser() }
    }
    //

    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
       // self.currentUser = user
        self.currentUser = try snapshot.data(as: User.self)

    }



    static func fetchUserByUid(withUid uid: String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }

    static func fetchAllUsers(limit: Int? = nil) async throws -> [User] {
        let query = FirestoreConstants.UserCollection
        if let limit { query.limit(to: limit) }
        let snapshot = try await query.getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: User.self )})
    }

    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        FirestoreConstants.UserCollection.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            completion(user)
        }
    }
}


extension UserService {
    @MainActor
    func updateUserConnectedId(_ connectedId: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        self.currentUser?.connectedId = connectedId
        try await Firestore.firestore().collection("users").document(uid).updateData([
            "connectedId": connectedId,


        ])
    }

    @MainActor
    func updateVerifiedPayments(_ isVerified: Bool) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        self.currentUser?.verifiedPayments = isVerified
        try await Firestore.firestore().collection("users").document(uid).updateData([
            "verifiedPayments": isVerified
        ])
    }

    @MainActor
        func updateUserConnectedUrl(_ connectedUrl: String) async throws {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            self.currentUser?.connectedUrl = connectedUrl
            try await Firestore.firestore().collection("users").document(uid).updateData([
                "connectedUrl": connectedUrl
            ])
        }

}
