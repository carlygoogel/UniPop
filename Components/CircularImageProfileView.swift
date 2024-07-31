//
//  CircularImageProfileView.swift
//  UniPop-App
//
//  Created by Carly Googel on 5/7/24.
//

import SwiftUI

enum ProfileImageSize {
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xLarge

    var dimension: CGFloat {
        switch self {
        case .xxSmall: return 28
        case .xSmall: return 32
        case .small: return 40
        case .medium: return 56
        case .large: return 64
        case .xLarge: return 100
        }
    }
}

struct CircularImageProfileView: View {
    var user: User?
    let size: ProfileImageSize

    var body: some View {
        if let imageUrl = user?.profileImage {
            Image(imageUrl)
                .resizable()
                .scaledToFit()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
                .foregroundColor(Color(.systemGray4))
        }
    }
}

#Preview {
    CircularImageProfileView(user: User.MOCK_USER, size: .medium)
}
