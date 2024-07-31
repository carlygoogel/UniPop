//
//  CompleteAccount.swift
//  UniPop
//
//  Created by Carly Googel on 4/22/24.
//

import SwiftUI

// need to add logic to make fields required

struct CompleteAccount: View {
    @State var firstname: String = ""
    // 2
    @State var lastname: String = ""
    @State var bio: String = ""
    @State var communities: String = ""


    var body: some View {
        NavigationView {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: "E64FFF"), Color(hex: "76F6FE")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        VStack {
            Text("Complete your account")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Spacer()
            TextField("First name", text: $firstname)
                .padding()
                   .background(Color.clear)
                   .overlay(RoundedRectangle(cornerRadius: 8)
                               .stroke(Color.white, lineWidth: 1))
                   .frame(width: 358, height: 56, alignment: .center)
                   .foregroundColor(.white)
                   .font(.system(size: 14))
            TextField("Last name", text: $lastname)
                .padding()
                   .background(Color.clear)
                   .overlay(RoundedRectangle(cornerRadius: 8)
                               .stroke(Color.white, lineWidth: 1))
                   .frame(width: 358, height: 56, alignment: .center)
                   .foregroundColor(.white)
                   .font(.system(size: 14))

            TextField("Bio", text: $bio)
                .padding()
                   .background(Color.clear)
                   .overlay(RoundedRectangle(cornerRadius: 8)
                               .stroke(Color.white, lineWidth: 1))
                   .frame(width: 358, height: 56, alignment: .center)
                   .foregroundColor(.white)
                   .font(.system(size: 14))


            TextField("Communities", text: $communities)
                .padding()

                   .background(Color.clear)
                   .overlay(RoundedRectangle(cornerRadius: 8)
                               .stroke(Color.white, lineWidth: 1))
                   .frame(width: 358, height: 56, alignment: .center)
                   .foregroundColor(.white)
                   .font(.system(size: 14))

            Button("Confirm", action: {})
                .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.black)
                    .background( Color.white)
                    .cornerRadius(10)
                    .frame(width: 358, height: 56, alignment: .center)

            Spacer()

        }

    }
        }
    }
}
struct CompleteAccount_Previews: PreviewProvider {
    static var previews: some View {
        CompleteAccount()
    }
}
