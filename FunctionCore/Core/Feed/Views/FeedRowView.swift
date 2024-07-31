
import SwiftUI

struct FeedRowView: View {
    let posts: [Post]
    @Binding var selectedPost: Post?

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(posts) { post in
                    FeedCell(post: post, selectedPost: $selectedPost)
                        .padding(3)
                }
            }
            .padding(.top, 8)
        }
    }
}


////
////  FeedRowView.swift
////  UniPop-App
////
////  Created by Carly Googel on 6/4/24.
////
//
//import SwiftUI
//
//struct FeedRowView: View {
//    let posts: [Post]
//
//    var body: some View {
//        ScrollView(.horizontal) {
//            LazyHStack(spacing: 10) {
//
//
//                ForEach(posts) { post in
//                    FeedCell(post: post)
//                        .padding(3)
//                }
//            }
//            .padding(.top, 8)
//        }
//    }
//}
//
//#Preview {
//    FeedRowView(posts: Post.MOCK_POSTS)
//}
