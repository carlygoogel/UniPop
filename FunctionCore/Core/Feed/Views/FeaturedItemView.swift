import SwiftUI


struct FeaturedItemView: View {
    @State private var currentIndex = 0
    private let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()

    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(0..<5) { index in
                    ZStack {
                        Image(Post.MOCK_POSTS[index].imageUrl)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 350, height: 150)
                            .cornerRadius(30)
                            .overlay(
                                Color.black.opacity(0.3)
                                    .cornerRadius(30)
                            )
                        
                        VStack {
                            //  Spacer()
                            Text(Post.MOCK_POSTS[index].itemName)
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(10)
                        }
                     //   .padding()

                    }
                    .frame(width: 350, height: 150)
                    .tag(index)
                }

        }
        .frame(height: 150)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .onReceive(timer) { _ in
            withAnimation {
                currentIndex = (currentIndex + 1) % Post.MOCK_POSTS.count
            }
        }
    }
}

#Preview {
    FeaturedItemView()
}
