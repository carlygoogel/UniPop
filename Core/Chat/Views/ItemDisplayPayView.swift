//
//  ItemDisplayPayView.swift
//  UniPop-App
//
//  Created by Carly Googel on 6/13/24.
//

import SwiftUI
import Kingfisher


struct ItemDisplayPayView: View {
    let post: Post?


    let user: User
    @State private var showPaymentPreview = false
    @State private var showErrorAlert = false
    @StateObject private var viewModel = CheckoutViewModel()


    var body: some View {

        ZStack() {


            ZStack(alignment: .top) {
                if let imageUrl = post?.imageUrl { KFImage(URL(string: imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 340, height: 200)
                        .cornerRadius(10)
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 340, height: 200)
                }


                VStack() {
                    Text(post?.itemName ?? "")
                        .foregroundColor(.black)
                        .font(.title2)
                        .fontWeight(.bold)


                    Text("$\(post?.price ?? "")")
                        .foregroundColor(.black)
                        .font(.caption)
                        .fontWeight(.bold)
                }

                .padding(3)
                .background(.ultraThinMaterial)
                .cornerRadius(12)


                Button(action: {
                    preparePayment()
                }) {
                    Text("PAY")
                        .font(.title3)
                        .fontWeight(.bold)
                        .frame(width: 280, height: 20)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "E64FFF"), Color(hex: "76F6FE")]), startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(.black)
                        .cornerRadius(10)

                }
                .padding(.top, 140)

                if let paymentResult = viewModel.paymentResult {
                    switch paymentResult {
                    case .completed:
                        Text("Payment complete")
                            .font(.footnote)
                            .foregroundStyle(.green)
                    case .failed(let error):
                        Text("Payment failed: \(error.localizedDescription)")
                            .font(.footnote)
                            .foregroundStyle(.red)

                    case .canceled:
                        Text("Payment canceled.")
                            .font(.footnote)
                            .foregroundStyle(.red)
                    }
                }


                if showPaymentPreview {


                    PaymentPreviewView(
                        paymentSheet: viewModel.paymentSheet,
                        onCompletion: viewModel.onPaymentCompletion,
                        amount: post?.price ?? "0",
                        post: post,
                        onDismiss: { showPaymentPreview = false }
                    )
                    .transition(.scale)
                }

            }
            .shadow(radius: 3)

            .animation(.easeInOut, value: showPaymentPreview)
            .alert(isPresented: $showErrorAlert) {
                       Alert(
                           title: Text("Error"),
                           message: Text(viewModel.errorMessage ?? "An unknown error occurred"),
                           dismissButton: .default(Text("OK"))
                       )
                   }
                   .onChange(of: viewModel.errorMessage) { newValue in
                       if newValue != nil {
                           showErrorAlert = true
                       }
                   }

       //     if showPaymentPreview {
       //            Color.black.opacity(0.1)
        //            .edgesIgnoringSafeArea(.all)
        //            .blur(radius: 2)
        //    }


        }
        .shadow(radius: 3)
    }

    private func preparePayment() {
        guard let amountDouble = Double(post?.price ?? "0"), amountDouble > 0 else {
            viewModel.errorMessage = "Invalid amount"
            return
        }

        let amountInt = Int(amountDouble * 100) // Convert to cents
                viewModel.preparePaymentSheet(amount: amountInt, connectedAccountId: user.connectedId ?? "")

                showPaymentPreview = true


    }
}

#Preview {
    ItemDisplayPayView(post: Post.MOCK_POSTS[0], user: User.MOCK_USER)
}
