//
//  MainTabView.swift
//  UniPop-App
//
//  Created by Carly Googel on 6/4/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedIndex = 0




    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedIndex) {

                FeedView()
                    .onAppear {
                        selectedIndex = 0
                    }
                    .tabItem {
                        Image(systemName: "rectangle.grid.2x2")
                    }
                    .tag(0)

                SearchView()
                    .onAppear {
                        selectedIndex = 1
                    }
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                    .tag(1)


                UploadPostView(tabIndex: $selectedIndex)
                    .onAppear {
                        selectedIndex = 2
                    }
                    .tabItem {
                        Image(systemName: "plus.square")
                    }
                    .tag(2)


                InboxView()
                    .onAppear {
                        selectedIndex = 3
                    }
                    .tabItem {
                        Image(systemName: "bubble.left.and.bubble.right")
                    }
                    .tag(3)


                // edit to user object and add viewModel
                CurrentUserProfileView()
                    .onAppear {
                        selectedIndex = 4
                    }
                    .tabItem {
                        Image(systemName: "person")
                    }
                    .tag(4)




            }
            .accentColor(Color(hex: "E64FFF"))
         //   .accentColor(.black)
         //   .tabViewStyle(.page(indexDisplayMode: .always))
       //     .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))



        }

    }


}




#Preview {
    MainTabView()
}
