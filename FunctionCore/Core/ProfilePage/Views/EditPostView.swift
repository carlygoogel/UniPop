//
//  EditPostView.swift
//  UniPop-App
//
//  Created by Carly Googel on 7/19/24.
//

import SwiftUI

struct EditPostView: View {
    @StateObject private var viewModel: EditPostViewModel
    @Environment(\.presentationMode) var presentationMode

    init(post: Post) {
        _viewModel = StateObject(wrappedValue: EditPostViewModel(post: post))
    }

    var body: some View {
      //  NavigationView {
        VStack {

            Form {
                Section(header: Text("Post Details")) {
                    TextField("Item Name", text: $viewModel.itemName)
                    TextField("Description", text: $viewModel.description)
                    TextField("Category", text: $viewModel.category)
                    TextField("Price", text: $viewModel.price)
                }

                Section {
                    Button("Save Changes") {
                        Task {
                            do {
                                try await viewModel.updatePostData()
                                presentationMode.wrappedValue.dismiss()
                            } catch {
                                print("Error updating post: \(error.localizedDescription)")
                            }
                        }
                    }
                }

                Section {
                    Button("Delete Post") {
                        Task {
                            do {
                                try await viewModel.deletePost()
                                presentationMode.wrappedValue.dismiss()
                            } catch {
                                print("Error deleting post: \(error.localizedDescription)")
                            }
                        }
                    }
                    .foregroundColor(.red)
                }
         //   }
            //       .navigationTitle("Edit Post")
                 }
        }
    }
}

#Preview {
    EditPostView(post: Post.MOCK_POSTS[0])
}

