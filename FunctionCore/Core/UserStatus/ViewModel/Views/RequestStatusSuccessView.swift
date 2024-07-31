//
//  RequestStatusSuccessView.swift
//  UniPop-App
//
//  Created by Carly Googel on 6/20/24.
//

import SwiftUI

struct RequestStatusSuccessView: View {
   // @Binding var tabIndex: Int
  //  @Environment(\.dismiss) var dismiss


    var body: some View {
        VStack(spacing: 20) {
            Text("Request Successfully Sent")
                .font(.title2)
                .fontWeight(.bold)
                .padding()

            Text("We will get back to you as soon as possible with your updated status!")
                .font(.subheadline)
                .fontWeight(.regular)
                .padding(.horizontal)



            Button(action: {
                // Handle submit action
             //   userStatusViewModel.currentUser?.status = true // Update the status
                // You should also update the status in the backend
           //     Task {
             //       returnToFeed()
               // }
            }) {
                Text("Continue")
                  //  .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "E64FFF"), Color(hex: "76F6FE")]), startPoint: .leading, endPoint: .trailing))
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .cornerRadius(8)
                   // .onTapGesture {
                     //   dismiss()
                   // }
            }
            .padding()
        }
        .frame(width: 350, height: 420)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 20)
        .padding()
    }
//           }



//    }
 //   func returnToFeed() {
   //     tabIndex = 0
    //}
}




#Preview {
    RequestStatusSuccessView()
}
