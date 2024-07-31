//
//  UploadPostViewModel.swift
//  UniPop-App
//
//  Created by Carly Googel on 6/6/24.
//

import Foundation
import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage



@MainActor
class UploadPostViewModel: ObservableObject {
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage) } }
    }
    @Published var postImage: Image?
    private var uiImage: UIImage?


    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }

        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
    }

    func uploadPost(itemName: String, description: String, category: String, itemPrice: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let uiImage = uiImage else { return }
        
        let postRef = Firestore.firestore().collection("posts").document()
        guard let imageUrl = try await ImageUploader.uploadImage(image: uiImage) else { return }

        let post = Post(id: postRef.documentID, ownerUid: uid, itemName: itemName, description: description, likes: 0, imageUrl: imageUrl, timestamp: Timestamp(), price: itemPrice, ticket: false, anonymous: false, category: category)

        let postData: [String: Any] = [
                "id": post.id,
                "ownerUid": post.ownerUid,
                "itemName": post.itemName,
                "description": post.description,
                "likes": post.likes,
                "imageUrl": post.imageUrl,
                "timestamp": post.timestamp,
                "price": post.price,
                "ticket": post.ticket ?? false,
                "anonymous": post.anonymous ?? false,
                "category": post.category ?? false
            ]

    //    guard let encodedPost = try? Firestore.Encoder().encode(post) else { return }
       // guard let encodedPost = try? JSONEncoder().encode(post) else { return }

        try await postRef.setData(postData)

    }

//    func updatePost(_ post: Post) async throws {
//         let postRef = Firestore.firestore().collection("posts").document(post.id)
//
//         let updatedData: [String: Any] = [
//             "itemName": post.itemName,
//             "description": post.description,
//             "price": post.price,
//             "category": post.category ?? "",
//             // Add any other fields that can be updated
//         ]
//
//         try await postRef.updateData(updatedData)
//     }
//
//     // New method to delete a post
//     func deletePost(_ post: Post) async throws {
//         let postRef = Firestore.firestore().collection("posts").document(post.id)
//         try await postRef.delete()
//
//         if !post.imageUrl.isEmpty {
//             let storage = Storage.storage()
//             let storageRef = storage.reference(forURL: post.imageUrl)
//             try await storageRef.delete()
//         }
//     }
}

//     @Published var user = User

// init() {
 //   Task { try await fetchAllUsers() }
//}

//@MainActor
//func fetchUser() async throws {
//    self.users = try await UserService.fetchAllUsers()
//}
