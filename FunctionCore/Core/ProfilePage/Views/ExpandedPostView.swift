import SwiftUI
import Kingfisher

struct ExpandedPostView: View {
    @StateObject private var viewModel: EditPostViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var hasAppeared = false


    let post: Post
    var namespace: Namespace.ID
    var onDismiss: () -> Void

    init(post: Post, namespace: Namespace.ID, onDismiss: @escaping () -> Void) {
        self.post = post
        self.namespace = namespace
        self.onDismiss = onDismiss
        _viewModel = StateObject(wrappedValue: EditPostViewModel(post: post))
    }
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                KFImage(URL(string: post.imageUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.4)
                    .clipped()
                 //  .matchedGeometryEffect(id: post.id, in: namespace, properties: .frame, isSource: false)
              //      .zIndex(1)


                VStack(spacing: 15) {
                    CustomTextField5(title: "Item Name", text: $viewModel.itemName)
                    CustomTextField5(title: "Description", text: $viewModel.description)
                    CustomTextField5(title: "Price", text: $viewModel.price)
                }
                .padding()

                Spacer()

                HStack(spacing: 20) {
                    Button("Save") {
                        Task {
                            do {
                                try await viewModel.updatePostData()
                           //     presentationMode.wrappedValue.dismiss()
                                onDismiss()
                            } catch {
                                print("Error updating post: \(error.localizedDescription)")
                            }
                        }
                    }
                    .buttonStyle(GradientButtonStyle(colors: [Color(hex: "E64FFF"), Color(hex: "76F6FE")]))

                    Button("Delete") {
                        Task {
                            do {
                                try await viewModel.deletePost()
                             //   presentationMode.wrappedValue.dismiss()
                                onDismiss()
                            } catch {
                                print("Error deleting post: \(error.localizedDescription)")
                            }
                        }
                    }
                    .buttonStyle(GradientButtonStyle(colors: [Color(hex: "E5E3E3"), Color(hex: "E5E3E3")]))
                }
                .padding(.bottom, 20)
            }
            .background(Color.white)
            .cornerRadius(25)
            .shadow(radius: 10)
        }
    }
}



struct GradientButtonStyle: ButtonStyle {
    let colors: [Color]

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .fontWeight(.black)
            .frame(width: 100, height: 30)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing))
            .foregroundColor(.black)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct CustomTextField5: View {
    let title: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            TextField(title, text: $text)
               // .padding(10)
                //.background(Color.gray.opacity(0.1))
               // .cornerRadius(8)
                .modifier(TextFieldModifier2())
            //   .padding(.horizontal)
                .padding(.top, 10)
                .frame(height: 50)
        }
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

