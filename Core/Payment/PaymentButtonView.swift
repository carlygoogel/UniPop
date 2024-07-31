//
//  PaymentButtonView.swift
//  UniPop-App
//
//  Created by Carly Googel on 7/30/24.
//

import SwiftUI
import StripePaymentSheet
import Kingfisher



struct PaymentPreviewView: View {
    let paymentSheet: PaymentSheet?
    let onCompletion: (PaymentSheetResult) -> Void
    let amount: String
    let post: Post?
    let onDismiss: () -> Void

    var body: some View {
        VStack {
            Spacer()

            if let imageUrl = post?.imageUrl { KFImage(URL(string: imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 340, height: 250)
                    .cornerRadius(10)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 340, height: 200)
                    .cornerRadius(10)

            }


            Text("\(post?.itemName ?? " ")")
                .font(.title)
                .padding(.top, 5)

            Text("\(post?.description ?? " ")")
                .font(.subheadline)

            Text("$\(amount)")
                .font(.headline)
                .padding(.top, 5)

            if let paymentSheet = paymentSheet {
                PaymentButtonView(
                    paymentSheet: paymentSheet,
                    onCompletion: onCompletion,
                    amount: amount
                )
            } else {
                Text("Payment not ready")
                    .foregroundColor(.red)
            }

            Button("Cancel") {
                onDismiss()
            }
            .font(.title3)
            .fontWeight(.black)
            .frame(width: 130, height: 30)
            .padding(.vertical, 8)
            .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "E5E3E3"), Color(hex: "E5E3E3")]), startPoint: .leading, endPoint: .trailing))
            .foregroundColor(.black)
            .cornerRadius(10)

            Spacer()
        }
        .frame(width: 300, height: 500)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 2)
    }
}

struct PaymentButtonView: View {
    let paymentSheet: PaymentSheet
    let onCompletion: (PaymentSheetResult) -> Void
    let amount: String

    var body: some View {
        PaymentSheet.PaymentButton(
            paymentSheet: paymentSheet,
            onCompletion: onCompletion
        ) {
            Text("Pay $\(amount)")
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(hex: 0xE64FFF),
                            Color(hex: 0x76F6FE)
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .foregroundColor(.black)
                .fontWeight(.semibold)
                .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}


