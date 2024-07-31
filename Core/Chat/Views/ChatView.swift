//
//  ChatView.swift
//  UniPop-App
//
//  Created by Carly Googel on 5/11/24.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel: ChatViewModel
    let user: User
    let post: Post?
    private var thread: Thread?


    init(user: User, post: Post?) {
        self.user = user
        self.post = post

        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
    }

    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: "E64FFF"), Color(hex: "76F6FE")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack {
                VStack {
                //    CircularImageProfileView(user: user, size: .large)

                    VStack(spacing: 4) {
                        Text("\(user.firstname) \(user.lastname)")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Text("University of Pennsylvania")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
                }

                    ZStack {

                        RoundedRectangle(cornerRadius: 46)
                            .fill(Color.white)
                            .edgesIgnoringSafeArea(.bottom)

                        VStack {


                            ZStack {

                                if post != nil {

                                    ItemDisplayPayView(post: post, user: user)


                                   } else {
                                       /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                                   }
                            }
                            .padding()

                            ScrollViewReader { proxy in

                                ScrollView {

                                    // messages
                                    LazyVStack {
                                        ForEach(viewModel.messages) { message in
                                            ChatMessageCell(message: message)

                                        }
                                    }

                                }
                                .padding(.top, 15)
                                .padding(.bottom, 10)
                                .background(Color.white)
                                
                                .onChange(of: viewModel.messages) { newValue in
                                    guard  let lastMessage = newValue.last else { return }

                                    withAnimation(.spring()) {
                                        proxy.scrollTo(lastMessage.id)
                                    }
                                }

                            }

                        }
                    }


                // message input view
                Spacer()

                ZStack(alignment: .trailing) {
                    TextField("Message...", text: $viewModel.messageText, axis: .vertical)
                        .padding(12)
                        .padding(.trailing, 48)
                        .background(Color(.systemGroupedBackground))
                        .clipShape(Capsule())
                        .font(.subheadline)

                    Button {
                        viewModel.sendMessage()
                        viewModel.messageText = ""
                    } label: {
                     //   Text("Send")
                      //      .fontWeight(.semibold)
                      //      .foregroundColor(Color(hex: "E64FFF"))
                        Image(systemName: "chevron.right.circle")
                                                .foregroundColor(Color(hex: "E64FFF"))
                      //                          .padding()
                    }

                    .padding(.horizontal)
                }

                .padding()
                .background(Color.white)
            }
            .navigationTitle("UniPop")
            .navigationBarTitleDisplayMode(.inline)


        }
        .onTapGesture {
            self.endEditing()
        }
    }
}

#Preview {
    ChatView(user: User.MOCK_USER, post: Post.MOCK_POSTS[0])
}

extension ChatView {
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
