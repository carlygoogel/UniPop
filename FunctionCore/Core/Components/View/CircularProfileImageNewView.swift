//
//  CircularProfileImageNewView.swift
//  UniPop-App
//
//  Created by Carly Googel on 6/11/24.
//

import SwiftUI
import Kingfisher

enum ProfileImageSizeNew {
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case largee
    case xLarge

    var dimension: CGFloat {
        switch self {
        case .xxSmall: return 28
        case .xSmall: return 32
        case .small: return 40
        case .medium: return 56
        case .large: return 64
        case .largee: return 80
        case .xLarge: return 100
        }
    }
}

struct CircularProfileImageNewView: View {
    let user: User
    let size: ProfileImageSizeNew


    var body: some View {
        if let imageUrl = user.profileImage {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
                .foregroundColor(Color(.systemGray4))
        }
    }
}

#Preview {
    CircularProfileImageNewView(user: User.MOCK_USER, size: .medium)
}
