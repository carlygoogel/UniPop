//
//  InboxRowView.swift
//  UniPop-App
//
//  Created by Carly Googel on 4/26/24.
//

import SwiftUI

struct InboxRowView: View {
    @ObservedObject var viewModel: InboxViewModel
    let message: Message

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
          //  CircularImageProfileView(user: message.user, size: .large)
            CircularProfileImageNewView(user: message.user ?? User.MOCK_USER, size: .large)


            VStack(alignment: .leading, spacing: 4) {
                Text("\(message.user?.firstname ?? "") \(message.user?.lastname ?? "")")
                    .font(.subheadline)
                    .fontWeight(.bold)

                Text(message.messageText)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
            }

            HStack {
                Text(message.timestampString)

                Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundColor(.gray)
        }
      //  .frame(height: 72)
        .swipeActions {
            Button {
                Task { onDelete() }
            } label: {
                Image(systemName: "trash")
            }
            .tint(Color(.systemRed))
        }
        .frame(height: 80)
    }
}

private extension InboxRowView {
    func onDelete() {
        Task { await viewModel.deleteRecentMessage(message) }
    }
}


