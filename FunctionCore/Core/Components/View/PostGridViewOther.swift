//
//  PostGridViewOther.swift
//  UniPop-App
//
//  Created by Carly Googel on 7/19/24.
//

import SwiftUI
import Kingfisher


struct PostGridViewOther: View {
    @StateObject var viewModel: PostGridViewModelOther

    init(user: User) {
        self._viewModel = StateObject(wrappedValue: PostGridViewModelOther(user: user))
    }

    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 20),
        .init(.flexible(), spacing: 20)
        //  .init(.flexible(), spacing: 1)
    ]

    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 2) - 25

        var body: some View {
            LazyVGrid(columns: gridItems, spacing: 20) {
                ForEach(viewModel.posts) { post in
                    KFImage(URL(string: post.imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: imageDimension, height: imageDimension)
                        .clipped()
                        .cornerRadius(15)

                }

            }
        }
}

#Preview {
    PostGridViewOther(user: User.MOCK_USER)
}
