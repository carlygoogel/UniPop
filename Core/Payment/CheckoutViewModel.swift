//
//  CheckoutViewModel.swift
//  UniPop-App
//
//  Created by Carly Googel on 7/30/24.
//

import SwiftUI
import StripePaymentSheet

class CheckoutViewModel: ObservableObject {
    @Published var paymentSheet: PaymentSheet?
    @Published var paymentResult: PaymentSheetResult?
    @Published var errorMessage: String?
    @Published var isLoading = false

    let backendCheckoutUrl = URL(string: "http://localhost:4242/create-payment-intent-for-product")!

    func preparePaymentSheet(amount: Int, connectedAccountId: String) {
        isLoading = true
        errorMessage = nil


        let body: [String: Any] = ["amount": amount, "connectedAccountId": connectedAccountId]
        var request = URLRequest(url: backendCheckoutUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = "Network error: \(error.localizedDescription)"
                    print("Network error: \(error.localizedDescription)")
                    return
                }

                guard let data = data else {
                    self?.errorMessage = "No data received from server"
                    print("No data received from server")
                    return
                }

                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("Received JSON: \(json)")

                        if let errorMessage = json["error"] as? String {
                            self?.errorMessage = errorMessage
                            print("Server error: \(errorMessage)")
                            return
                        }

                        guard let paymentIntentClientSecret = json["paymentIntent"] as? String,
                              let ephemeralKeySecret = json["ephemeralKey"] as? String,
                              let customerId = json["customer"] as? String,
                              let publishableKey = json["publishableKey"] as? String else {
                            self?.errorMessage = "Missing required data in server response"
                            print("Missing required data in server response")
                            return
                        }

                        STPAPIClient.shared.publishableKey = publishableKey

                        var configuration = PaymentSheet.Configuration()
                        configuration.merchantDisplayName = "UniPop"
                        configuration.customer = .init(id: customerId, ephemeralKeySecret: ephemeralKeySecret)
                        configuration.allowsDelayedPaymentMethods = true

                        self?.paymentSheet = PaymentSheet(paymentIntentClientSecret: paymentIntentClientSecret, configuration: configuration)
                        print("PaymentSheet created successfully")
                    } else {
                        self?.errorMessage = "Invalid JSON response"
                        print("Invalid JSON response")
                    }
                } catch {
                    self?.errorMessage = "JSON parsing error: \(error.localizedDescription)"
                    print("JSON parsing error: \(error.localizedDescription)")
                }
            }
        }.resume()
    }

    func onPaymentCompletion(result: PaymentSheetResult) {
        self.paymentResult = result
        print("Payment result: \(result)")
    }
}
