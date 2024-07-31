//
//  SplashScreenView.swift
//  UniPop
//
//  Created by Carly Googel on 4/21/24.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
  //  @EnvironmentObject var viewModel: AuthViewModel
    @StateObject var viewModel = ContentViewModel()
    @StateObject var registrationViewModel = RegistrationViewModel()


    var body: some View {
        if isActive {
            Group {
                if viewModel.userSession != nil {
                 //   SplashLogin()
                    MainTabView()
                } else {
                    SplashLogin()
                     .environmentObject(registrationViewModel)
                


            }
            }
        } else {
            ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: "E64FFF"), Color(hex: "76F6FE")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

                VStack {
                   // Image("UniPop-Logo2")
                       // .resizable()
                     //   .scaledToFit()
                   //     .frame(width: 150, height: 150)
                     //   .padding()
                    Text("UniPop")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Text("your college marketplace")
                        .font(.headline)
                        .foregroundColor(.black)
                }
            }

            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }

    }

}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue:  Double(b) / 255, opacity: Double(a) / 255)
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
