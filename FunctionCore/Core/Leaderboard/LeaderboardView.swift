//
//  LeaderboardView.swift
//  UniPop-App
//
//  Created by Carly Googel on 7/12/24.
//

import SwiftUI

struct LeaderboardView: View {

    @Environment(\.dismiss) var dismiss



    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color(hex: "E64FFF"), Color(hex: "76F6FE")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 8) {
                Text("Leaderboard")
                    .font(.title)
                    .fontWeight(.bold)

                Text("Coming Soon")
                    .font(.title3)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                    Text(" Back ")
                   
                }
                                            .onTapGesture {
                                                dismiss()
                                            }
            }
        }
    }
        
}

#Preview {
    LeaderboardView()
}
