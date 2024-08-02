
//
//  ProfilePageView.swift
//  UniPop-App
//
//  Created by Carly Googel on 6/4/24.
//

import SwiftUI

struct ProfilePageView: View {


    // need to edit viewModel and user object
    @StateObject var viewModelProfile = ProfileViewMod()

    let user: User



    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 2) - 25

    // change to flexible
     var posts: [Post] {
        return Post.MOCK_POSTS.filter({ $0.user?.username == user.username })
    }


    var body: some View {
            ScrollView {
                // header
                ProfileHeaderView(user: user)



                // post grid view

                PostGridViewOther(user: user)
                .padding()

            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)

        }

}

#Preview {
    ProfilePageView(user: User.MOCK_USER)
}

//                    Image("studyAbroadOutfit")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: imageDimension, height: imageDimension)
//                        .clipped()
//                        .cornerRadius(30)
//
//
//                    Image("MGHoodie")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: imageDimension, height: imageDimension)
//                        .clipped()
//                        .cornerRadius(30)
//
//                    Image("dormify_mirror_light")
//                        .resizable()
//                        .scaledToFit()
//                   //     .frame(width: 170, height: 170)
//                        .cornerRadius(30)
//
//                    Image("flipperzero")
//                        .resizable()
//                        .scaledToFit()
//                  //      .frame(width: 170, height: 170)
//                        .cornerRadius(30)
//
//                    Image("homeworkImage")
//                        .resizable()
//                        .scaledToFit()
//                        .cornerRadius(30)
