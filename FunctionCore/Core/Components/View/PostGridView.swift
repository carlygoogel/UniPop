//
//import SwiftUI
//import Kingfisher
//
//struct PostGridView: View {
//    @StateObject var viewModel: PostGridViewModel
//    @State private var selectedPost: Post?
//
//    init(user: User) {
//        self._viewModel = StateObject(wrappedValue: PostGridViewModel(user: user))
//    }
//
//    private let gridItems: [GridItem] = [
//        .init(.flexible(), spacing: 20),
//        .init(.flexible(), spacing: 20)
//    ]
//
//    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 2) - 25
//
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                LazyVGrid(columns: gridItems, spacing: 20) {
//                    ForEach(viewModel.posts) { post in
//                        PostGridItem(post: post, imageDimension: imageDimension)
//                            .onTapGesture {
//                                selectedPost = post
//                            }
//                    }
//                }
//                .padding()
//            }
//            .navigationTitle("My Posts")
//            .navigationDestination(item: $selectedPost) { post in
//                EditPostView(post: post)
//            }
//        }
//    }
//}
//
//struct PostGridItem: View {
//    let post: Post
//    let imageDimension: CGFloat
//
//    var body: some View {
//        KFImage(URL(string: post.imageUrl))
//            .resizable()
//            .scaledToFill()
//            .frame(width: imageDimension, height: imageDimension)
//            .clipped()
//            .cornerRadius(15)
//    }
//}
//
//#Preview {
//    PostGridView(user: User.MOCK_USER)
//}
//
//
import SwiftUI
import Kingfisher

struct PostGridView: View {
    @StateObject var viewModel: PostGridViewModel
    @Binding var selectedPost: Post?
    var namespace: Namespace.ID

    init(user: User, selectedPost: Binding<Post?>, namespace: Namespace.ID) {
        self._viewModel = StateObject(wrappedValue: PostGridViewModel(user: user))
        self._selectedPost = selectedPost
        self.namespace = namespace
    }

    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 20),
        .init(.flexible(), spacing: 20)
    ]

    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 2) - 25

    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 20) {
            ForEach(viewModel.posts) { post in
                PostGridItem(post: post, imageDimension: imageDimension, namespace: namespace, isSelected: selectedPost?.id == post.id)
                    .onTapGesture {
                        if selectedPost == nil {
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                selectedPost = post
                            }
                        }
                    }
            }
        }
    }
}

struct PostGridItem: View {
    let post: Post
    let imageDimension: CGFloat
    var namespace: Namespace.ID
    var isSelected: Bool

    var body: some View {
        KFImage(URL(string: post.imageUrl))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: imageDimension, height: imageDimension)
            .clipped()
            .cornerRadius(15)
        // added isSourced: true and on ExpandedPostView isSOurced: False
            .matchedGeometryEffect(id: post.id, in: namespace, properties: .frame, isSource: true)
            .opacity(isSelected ? 0 : 1)
    }
}
