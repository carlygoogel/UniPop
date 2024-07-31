//
//  UserStatView.swift
//  UniPop-App
//
//  Created by Carly Googel on 6/4/24.
//

import SwiftUI

struct UserStatView: View {
    let title: String
    let value: Int

    var body: some View {
        VStack {
            Text(title)
                .font(.footnote)
            Text("\(value)")
                .font(.largeTitle)
        }
        .frame(width: 100)
    }
}


