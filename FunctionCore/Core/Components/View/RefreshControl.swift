//
//  RefreshControl.swift
//  UniPop-App
//
//  Created by Carly Googel on 7/20/24.
//
import SwiftUI

struct RefreshControl: View {
    @Binding var isRefreshing: Bool
    let coordinateSpaceName: String
    let onRefresh: () async -> Void

    var body: some View {
        GeometryReader { geo in
            if geo.frame(in: .named(coordinateSpaceName)).midY > 50 {
                Spacer()
                    .onAppear {
                        if !isRefreshing {
                            isRefreshing = true
                            Task {
                                await onRefresh()
                            }
                        }
                    }
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(width: geo.size.width)
                    .offset(y: max(geo.frame(in: .named(coordinateSpaceName)).minY - 50, -50))
            }
        }
        .padding(.top, -50)
    }
}
