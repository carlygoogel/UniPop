
import SwiftUI

struct FeedView: View {
    @StateObject var viewModel = FeedViewModel()
    @State private var isRefreshing = false
    @State private var selectedPost: Post?

    var body: some View {
        NavigationStack {
            ScrollView {
                RefreshControl(isRefreshing: $isRefreshing, coordinateSpaceName: "pullToRefresh") {
                    await refreshData()
                }

                FeaturedItemView()
                    .padding(.top)

                ForEach(viewModel.categorizedPosts, id: \.category) { category, posts in
                    VStack {
                        HStack {
                            Text(category)
                                .padding(.leading)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        FeedRowView(posts: posts, selectedPost: $selectedPost)
                            .padding(.horizontal)
                    }
                    .padding(.top)
                    .onAppear {
                        if category == viewModel.categorizedPosts.last?.category {
                            viewModel.loadMorePosts(for: category)
                        }
                    }
                }
            }
            .coordinateSpace(name: "pullToRefresh")
         //   .navigationTitle("Penn Shop")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("UniPopWordLogo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 50)
                }

                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        // Add your search action here
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: LeaderboardView().navigationBarBackButtonHidden(true)) {
                        Image(systemName: "trophy")
                            .foregroundStyle(.black)
                            .imageScale(.large)
                    }
                }
            }
            .navigationDestination(item: $selectedPost) { post in
                if let user = post.user {
                    ChatView(user: user, post: post)
                }
            }
        }
        .overlay(Group {
            if viewModel.isLoading {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color(hex: "E64FFF"), Color(hex: "76F6FE")]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)

                    VStack(spacing: 20) {
                        Image("UniPopA")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 70)
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)

                        Text("UniPop")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.black)
                            .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 3)

                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1)
                            .frame(height: 50)
                    }
                    .padding(40)
              //      .background(
                //        RoundedRectangle(cornerRadius: 25)
               //             .fill(Color.white.opacity(0.10))
               //             .blur(radius: 10)
               //     )
                //    .overlay(
                //        RoundedRectangle(cornerRadius: 25)
                //            .stroke(Color.white.opacity(0.5), lineWidth: 2)
               //     )
                }
            }
        })
    }

    func refreshData() async {
        await viewModel.refreshPosts()
        isRefreshing = false
    }
}


////
////  FeedView.swift
////  UniPop-App
////
////  Created by Carly Googel on 6/4/24.
////
//
//import SwiftUI
//
//struct FeedView: View {
//    @StateObject var viewModel = FeedViewModel()
//
//    @State private var isRefreshing = false
//
//
//    var body: some View {
//
//        NavigationStack {
//                ScrollView {
//
//                    RefreshControl(isRefreshing: $isRefreshing, coordinateSpaceName: "pullToRefresh") {
//                            await refreshData()
//                        }
//
//                    FeaturedItemView()
//                        .padding(.top)
//
//
//                    ForEach(viewModel.categorizedPosts, id: \.category) { category, posts in
//                        VStack {
//                            HStack {
//                                Text(category)
//                                    .padding(.leading)
//                                    .fontWeight(.bold)
//                                Spacer()
//                            }
//                            FeedRowView(posts: posts)
//                                .padding(.horizontal)
//                        }
//                        .padding(.top)
//                        .onAppear {
//                            if category == viewModel.categorizedPosts.last?.category {
//                                viewModel.loadMorePosts(for: category)
//                            }
//                        }
//                    }
//
//
//
//                }
//            // added
//                .coordinateSpace(name: "pullToRefresh")
//            //
//
//                .navigationTitle("Penn Shop")
//                .navigationBarTitleDisplayMode(.inline)
//
//
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        Image("UniPopWordLogo")
//                        // UniPopWordLogo
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 100, height: 50)
//                    }
//
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        NavigationLink(destination:                 LeaderboardView()
//                            .navigationBarBackButtonHidden(true)
//
//                        ) {
//                                                Image(systemName: "trophy")
//                                                    .foregroundStyle(.black)
//                        .imageScale(.large)
//
//
//                                        }
//
//                    }
//                }
//            if viewModel.isLoading {
//                LinearGradient(gradient: Gradient(colors: [Color(hex: "FFFFFF"), Color(hex: "FFFFFF")]), startPoint: .top, endPoint: .bottom)
//                    .edgesIgnoringSafeArea(.all)
//                    .opacity(0.8)
//                    .overlay(
//                        ProgressView()
//                            .progressViewStyle(CircularProgressViewStyle(tint: .black))
//                            .scaleEffect(1)
//                    )
//            }
//
//
//
//            }
//
//
//    }
//
//    func refreshData() async {
//        await viewModel.refreshPosts()
//        isRefreshing = false
//    }
//}
//
//#Preview {
//    FeedView()
//}
//
//
