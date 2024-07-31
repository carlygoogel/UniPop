//
//  ActiveNowView.swift
//  UniPop-App
//
//  Created by Carly Googel on 4/26/24.
//

import SwiftUI

struct ActiveNowView: View {
    @StateObject var viewModel = ActiveNowViewModel()

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 32) {
                ForEach(viewModel.users, id: \.self) { user in
                    NavigationLink(value: Route.chatView(user)) {
                        VStack {
                            ZStack(alignment: .bottomTrailing) {
                                CircularProfileImageNewView(user: user, size: .medium)

                                ZStack {
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 18, height: 18)

                                    Circle()
                                        .fill(Color(.systemGreen))
                                        .frame(width: 12, height: 12)
                                }
                            }

                            Text(user.firstname)
                                .font(.footnote)
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .padding()
        }
        .frame(height: 106)
    }
}

struct ActiveNowView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveNowView()
    }
}
