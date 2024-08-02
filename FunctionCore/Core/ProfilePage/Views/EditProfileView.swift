//
//  EditProfileView.swift
//  UniPop-App
//
//  Created by Carly Googel on 6/11/24.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss

    @StateObject var viewModel: EditProfileViewModel

    init(user: User) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }

    var body: some View {
        VStack {

            // toolbar
            VStack {
                HStack {
                    Button("Cancel") {
                        dismiss()
                    }
                    Spacer()

                    Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    Spacer()

                    Button {
                        Task {
                            try await viewModel.updateUserData()
                            dismiss()

                        }
                    } label: {
                        Text("Done")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }

                }
                .padding(.horizontal)

                Divider()

            }


            // edit profile pic
            PhotosPicker(selection: $viewModel.selectedImage) {
                VStack {
                    if let image = viewModel.profileImage {
                        image
                            .resizable()
                            .foregroundColor(.white)
                            .background(.gray)
                            .clipShape(Circle())
                            .frame(width: 80, height: 80)
                    } else {
                        CircularProfileImageNewView(user: viewModel.user, size: .largee)

                    }

                    Text("Edit profile picture")
                        .font(.footnote)
                        .fontWeight(.semibold)

                    Divider()
                }

            }
            .padding(.vertical, 8)

            // edit profile info
            VStack {
                EditProfileRowView(title: "Username", placeholder: "Enter your username..", text: $viewModel.username)
                    .autocorrectionDisabled(true)

                EditProfileRowView(title: "Bio", placeholder: "Enter your bio..", text: $viewModel.bio)
                    .autocorrectionDisabled(true)

            }


            Spacer()
        }
        .onTapGesture {
            self.endEditing()
        }
    }
}

struct EditProfileRowView: View {
    let title: String
    let placeholder: String

    @Binding var text: String

    var body: some View {
        HStack {
            Text(title)
                .padding(.leading, 10)
                .frame(width: 100, alignment: .leading)

            VStack {
                TextField(placeholder, text: $text)

                Divider()
            }
        }
        .font(.subheadline)
        .frame(height: 36)
    }
}

