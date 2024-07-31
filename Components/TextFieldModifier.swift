//
//  TextFieldModifier.swift
//  UniPop-App
//
//  Created by Carly Googel on 6/5/24.
//

import Foundation
import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
               .background(Color.clear)
               .overlay(RoundedRectangle(cornerRadius: 8)
                           .stroke(Color.white, lineWidth: 1))
               .frame(width: 358, height: 56, alignment: .center)
               .foregroundColor(.white)
               .font(.system(size: 14))
               .autocorrectionDisabled(true)
    }
}

struct TextFieldModifier2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
               .background(Color.clear)
               .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1))
               .foregroundColor(.black)
               .font(.system(size: 14))
               .shadow(radius: 5)
               .autocorrectionDisabled(true)
    }
}
