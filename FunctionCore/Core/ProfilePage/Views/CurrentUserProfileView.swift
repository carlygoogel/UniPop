
////
////  CurrentUserProfileView.swift
////  UniPop-App
////
////  Created by Carly Googel on 6/5/24.
////
//
//import SwiftUI
//import Firebase
//
//struct CurrentUserProfileView: View {
//
//    @StateObject var viewModel = CurrentUserViewModel()
//    @State private var isRefreshing = false
//
////    @State private var selectedPost: Post?
//  //  @Namespace private var animation
//
//
//
//  //  let user = User.MOCK_USER
//
//    private var user: User? {
//        return viewModel.currentUser
//    }
//
//   // let user: User
//
//  //  var posts: [Post] {
//  //     return Post.MOCK_POSTS.filter({ $0.user?.username == user.username })
//  // }
//
//
//    var body: some View {
//        NavigationStack {
//        ScrollView {
//
//            // header
//
//            if let user = viewModel.currentUser {
//                ProfileHeaderView(user: user)
//
//            }
//
//
//            if let user = viewModel.currentUser {
//                PostGridView(user: user)
//                    .padding()
//            }
//
//        }
//        .navigationTitle("Profile")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                if let user = viewModel.currentUser {
//                    NavigationLink(destination: ProfileView(user: user)) {
//                        Image(systemName: "gearshape")
//                            .foregroundStyle(.black)
//                    }
//                }
////                Button {
////
////                } label: {
////                    Image(systemName: "gearshape")
////                        .foregroundStyle(.black)
////                }
//            }
//        }
//        }
//    }
//}
//
//#Preview {
//    CurrentUserProfileView()
//}
import SwiftUI
import Firebase


struct CurrentUserProfileView: View {
    @StateObject var viewModel = CurrentUserViewModel()
    @State private var isRefreshing = false
    @State private var selectedPost: Post?
    @Namespace private var animation
    
    private var user: User? {
        return viewModel.currentUser
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    if let user = viewModel.currentUser {
                        ProfileHeaderView(user: user)
                    }
                    
                    if let user = viewModel.currentUser {
                        PostGridView(user: user, selectedPost: $selectedPost, namespace: animation)
                            .padding()
                    }
                }
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if let user = viewModel.currentUser {
                            NavigationLink(destination: ProfileView(user: user)) {
                                Image(systemName: "gearshape")
                                    .foregroundStyle(.black)
                            }
                        }
                    }
                }
                .blur(radius: selectedPost == nil ? 0 : 3)
                
                if let post = selectedPost {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                selectedPost = nil
                            }
                        }
                    ExpandedPostView(post: post, namespace: animation) {
                                         withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                             self.selectedPost = nil
                                         }
                                     }
                 //
                                     .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.7)
                                         .transition(.asymmetric(
                                                insertion: .opacity,
                                                removal: .opacity
                                            ))
                                            .zIndex(1)
                                 }
                             }
                         }
                     }
                 }
