//
//  SearchView.swift
//  UniPop-App
//
//  Created by Carly Googel on 6/5/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @StateObject var viewModel = SearchViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.users) { user in
                        NavigationLink(value: user) {
                            CircularProfileImageNewView(user: user, size: .small)

                            VStack(alignment: .leading) {
                                if let username = user.username {
                                    Text(username)
                                        .fontWeight(.semibold)

                                }
                                Text("\(user.firstname) \(user.lastname)")
                            }
                            .font(.footnote)

                            Spacer()
                        }
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    }
                }
                .padding(.top, 8)
                .searchable(text: $searchText, prompt: "Search...")
                .textInputAutocapitalization(.never)
            }
            .navigationDestination(for: User.self, destination: { user in
                ProfilePageView(user: user)
            })
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SearchView()
}
