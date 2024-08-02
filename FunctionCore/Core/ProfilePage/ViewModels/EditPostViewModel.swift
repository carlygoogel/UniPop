
//
//  EditPostViewModel.swift
//  UniPop-App
//
//  Created by Carly Googel on 7/19/24.
//

import Firebase
import SwiftUI
import FirebaseStorage

@MainActor
class EditPostViewModel: ObservableObject {
    @Published var post: Post
 //   @Published var selectedImage: PhotosPickerItem? {
  //      didSet { Task { await loadImage(fromItem: selectedImage) } }
  //  }
  //  @Published var postImage: Image?

    @Published var itemName = ""
    @Published var description = ""
    @Published var category = ""
    @Published var price = ""

    private var uiImage: UIImage?

    init(post: Post) {
        self.post = post
        self.itemName = post.itemName
        self.description = post.description
        self.category = post.category ?? ""
        self.price = post.price
    }

//    func loadImage(fromItem item: PhotosPickerItem?) async {
//        guard let item = item else { return }
//        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
//        guard let uiImage = UIImage(data: data) else { return }
//        self.uiImage = uiImage
//        self.postImage = Image(uiImage: uiImage)
//    }

    func updatePostData() async throws {
        var data = [String: Any]()



        // Update other fields if changed
        if post.itemName != itemName {
            data["itemName"] = itemName
        }
        if post.description != description {
            data["description"] = description
        }
        if post.category != category {
            data["category"] = category
        }
        if post.price != price {
            data["price"] = price
        }

        if !data.isEmpty {
            try await Firestore.firestore().collection("posts").document(post.id).updateData(data)
        }
    }

    func deletePost() async throws {
        try await Firestore.firestore().collection("posts").document(post.id).delete()
        // If you're storing images separately, you may want to delete the associated image as well
        // This assumes you're using Firebase Storage for images
        if let imageUrl = URL(string: post.imageUrl) {
            let storage = Storage.storage()
            let storageRef = storage.reference(forURL: imageUrl.absoluteString)
            try await storageRef.delete()
        }
    }
}
