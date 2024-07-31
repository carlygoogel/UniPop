//
//  InboxView.swift
//  UniPop-App
//
//  Created by Carly Googel on 4/26/24.
//

import SwiftUI

struct InboxView: View {
    @State private var showNewMessageView = false
    @StateObject var viewModel = InboxViewModel()
    @State private var selectedUser: User?
    @State private var showChat = false

    private var user: User? {
        return viewModel.currentUser
    }

  //  private var recentMessages: [Message] {
    //    Array(viewModel.recentMessages.values)
     //       .sorted { $0.timeStamp.dateValue() > $1.timeStamp.dateValue() }
   // }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(hex: "E64FFF"), Color(hex: "76F6FE")]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)


                VStack {
                    Text("University of Pennsylvania")
                        .foregroundColor(.white)

                    ActiveNowView()
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                        .padding(.vertical)
                        .padding(.horizontal, 4)

                    ZStack {

                        RoundedRectangle(cornerRadius: 46)
                            .fill(Color.white)
                            .edgesIgnoringSafeArea(.bottom)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)

                        List {


                            ForEach(viewModel.recentMessages) { message in
                                // disables the "chevron" > (workaround to basically hide the NavLink)
                                ZStack {
                                    NavigationLink(value: message) {
                                        EmptyView()
                                    }
                                    .opacity(0.0)

                                    InboxRowView(viewModel: viewModel, message: message)
                                }
                            }


                        }
                        .clipShape(RoundedRectangle(cornerRadius: 46, style: .continuous))
                        .navigationBarTitle("Chats")
                        .navigationBarTitleDisplayMode(.inline)
                        .listStyle(PlainListStyle())
                        // change started here
                        .onChange(of: selectedUser) {
                            showChat = selectedUser != nil
                        }
                        .navigationDestination(for: Message.self) { message in
                            if let user = message.user {
                                ChatView(user: user, post: nil)
                            }
                        }
                       // .onChange(of: selectedUser, perform: { newValue in
                      //      showChat = newValue != nil
                     //   })
                     //   .navigationDestination(for: Message.self, destination: { message in
                    //        if let user = message.user {
                     //           ChatView(user: user, post: nil)
                    //        }
                    //    })
                        .navigationDestination(for: Route.self, destination: { route in
                            switch route {
                            case .profile(let user):
                                //ProfileView(user: user)
                                Text(" ")
                            case .chatView(let user):
                                ChatView(user: user, post: nil)
                            }
                        })
                        .navigationDestination(isPresented: $showChat, destination: {
                            if let user = selectedUser {
                                ChatView(user: user, post: nil)
                            }
                        })
                        .fullScreenCover(isPresented: $showNewMessageView, content: {
                            NewMessageView(selectedUser: $selectedUser)
                        })
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                HStack {

                                    if let user {
                                       // NavigationLink(value: Route.profile(user)) {
                                            CircularProfileImageNewView(user: user, size: .xSmall)


                                    //    }
                                    }

                                        //    Text("Chats")
                                        //     .font(.title)
                                        //    .fontWeight(.semibold)
                                }
                            }
                            ToolbarItem(placement: .principal) {
                                                Text("Chats")
                                                    .font(.system(size: 40, weight: .bold))
                                                    .foregroundColor(.white)
                                            }


                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button {
                                    showNewMessageView.toggle()
                                    selectedUser = nil
                                } label: {
                                    Image(systemName: "square.and.pencil")
                                        .resizable()
                                        .frame(width: 32, height: 32)
                                        .foregroundStyle(.black, Color(.systemGray))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView()
    }
}
