
//
import SwiftUI
import Kingfisher

struct FeedCell: View {
    let post: Post
    @StateObject var viewModel = CurrentUserViewModel()
    @Binding var selectedPost: Post?

    var body: some View {
        VStack {
            // image + price
            VStack(spacing: 5) {
                ZStack(alignment: .bottomTrailing) {
                    KFImage(URL(string: post.imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 140, height: 140)
                        .frame(width: 175)
                        .cornerRadius(12)

                    Text(" $ " + post.price + " ")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .background(Color(hex: "E64FFF").opacity(0.85))
                        .foregroundColor(.white.opacity(0.8))
                        .cornerRadius(12)
                        .padding()
                }

                HStack {
                    Text(post.itemName)
                        .font(.footnote)
                }

                // bottom containing profile image + text, on click, brings to direct chat with that person
                Button {
                    if let currentUser = viewModel.currentUser, currentUser.id != post.user?.id {
                        selectedPost = post
                    }
                } label: {
                    if let user = post.user {
                        HStack {
                            CircularProfileImageNewView(user: user, size: .xSmall)

                            Text("Chat with @\(user.firstname)")
                                .foregroundColor(.black)
                                .scaledToFill()
                                .frame(width: 140, height: 40)
                                .font(.subheadline)
                        }
                    }
                }
                .background(Color(hex:"F1F0F0"))
                .cornerRadius(8)
            }
            .padding(10)
        }
        .background(Color.white)
        .cornerRadius(25)
        .shadow(color: Color.black.opacity(0.06), radius: 4, x: 5, y: 5)
    }
}


////
////  FeedCell.swift
////  UniPop-App
////
////  Created by Carly Googel on 6/4/24.
////
//
//import SwiftUI
//import Kingfisher
//
//struct FeedCell: View {
//    let post: Post
//    @StateObject var viewModel = CurrentUserViewModel()
//    @State private var isChatViewActive = false
//
//
//
//    var body: some View {
//
//        // if currentUser != post.user
//      //  NavigationLink(value: Route.chatView(post.user)) {
//            VStack {
//                // image + price
//                VStack(spacing: 5) {
//                    ZStack(alignment: .bottomTrailing) {
//                        KFImage(URL(string: post.imageUrl))
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 140, height: 140)
//
//                            .frame(width: 175)
//                            .cornerRadius(12)
//
//                        Text(" $ " + post.price + " ")
//                            .font(.footnote)
//                            .fontWeight(.semibold)
//                            .background(Color(hex: "E64FFF").opacity(0.85))
//                            .foregroundColor(.white.opacity(0.8))
//                            .cornerRadius(12)
//                            .padding()
//                          //  .frame(width: 150, alignment: .trailing)
//
//                    }
//                    //  .padding()
//
//
//                    HStack {
//
//                        Text(post.itemName)
//                            .font(.footnote)
//
//
//                    }
//
//                    // bottom containing profile image + text, on click, brings to direct chat with that person
//                    Button {
//                        print("bring to chat")
//                                            if let currentUser = viewModel.currentUser, currentUser.id != post.user?.id {
//                        isChatViewActive = true
//                    }
//                    } label: {
//                        if let user = post.user {
//                            HStack {
//                                CircularProfileImageNewView(user: user, size: .xSmall)
//
//                                Text("Chat with @\(user.firstname)")
//                                    .foregroundColor(.black)
//                                    .scaledToFill()
//                                    //.fixedSize()
//                                    .frame(width: 140, height: 40)
//                                    .font(.subheadline)
//                                //  .padding(10)
//                            }
//                        }
//                    }
//                    .background(Color(hex:"F1F0F0"))
//                    //     .padding()
//                    .cornerRadius(8)
//
//                    //
//                    .navigationDestination(isPresented: $isChatViewActive, destination: {
//
//                        ChatView(user: post.user!, post: post)
//
//                    })
//
//                    //
//
//                }
//                .padding(10)
//            }
//            .background(Color.white)
//            .cornerRadius(25)
//            .shadow(color: Color.black.opacity(0.06), radius: 4, x: 5, y: 5)
//          //  .overlay(
//          //      RoundedRectangle(cornerRadius: 12)
//           //         .stroke(Color.gray, lineWidth: 0.5)
//          //  )
//            //   .padding()
//
//  //      }
//    }
//}
//
//#Preview {
//    FeedCell(post: Post.MOCK_POSTS[0])
//}
