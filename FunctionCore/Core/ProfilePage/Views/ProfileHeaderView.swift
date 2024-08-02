//
//  ProfileHeaderView.swift
//  UniPop-App
//
//  Created by Carly Googel on 6/5/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    var user: User
    @State private var showEditProfile = false

    var body: some View {
        VStack {

            // Profile, name, and bio
            VStack(spacing: 2) {
              //  CircularImageProfileView(user: user, size: .xLarge)
                CircularProfileImageNewView(user: user, size: .xLarge)
                // .padding(.bottom, 6)


                Text("\(user.firstname) \(user.lastname)")
                    .font(.title2)
                    .fontWeight(.bold)

                // Add logic for username
                if let username = user.username {
                    Text("@\(username)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }

                // Add logic for bio
                if let bio = user.bio {
                    Text(bio)
                        .font(.subheadline)
                        .fontWeight(.regular)
                }


            }
            .padding()


            // Stats
            HStack() {
                UserStatView(title: "BOUGHT", value: 12)

                UserStatView(title: "POSTS", value: 3)

                UserStatView(title: "SOLD", value: 124)

            }

            // Action button
            Button {
                if user.isCurrentUser2 {
                    showEditProfile.toggle()
                } else {
                    print("Follow user...")
                }

            } label: {
                Text(user.isCurrentUser2 ? "Edit Profile" : "Follow" )
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 32)
                    .background(user.isCurrentUser2 ? .white : Color(.systemBlue))
                    .foregroundColor(user.isCurrentUser2 ? .black : .white)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(user.isCurrentUser2 ? Color.gray : .clear, lineWidth: 1)
                    )
            }


            Divider()
        }
        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView(user: user)
        }
    }
}

#Preview {
    ProfileHeaderView(user: User.MOCK_USER)
}
