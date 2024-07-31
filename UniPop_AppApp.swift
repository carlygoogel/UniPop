//
//  UniPop_AppApp.swift
//  UniPop-App
//
//  Created by Carly Googel on 4/23/24.
//

import SwiftUI
import FirebaseCore
import Firebase
import StripePaymentSheet



class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

      // Configure Stripe
    StripeAPI.defaultPublishableKey = "pk_test_51PUJY5CggrV7v76UjLSFjdiVesDtrOW8CSrTpvXHvQ6CCmXTMErq1x2IbRsZiFnFVufbmlXA7AR7QS50e2YcDDa900MMyKxaD6"

    return true
  }
}

@main
struct UniPop_AppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {

                ContentView()
            // might not need this
                .onOpenURL { incomingURL in
                  let stripeHandled = StripeAPI.handleURLCallback(with: incomingURL)
                  if (!stripeHandled) {
                    // This was not a Stripe url – handle the URL normally as you would
                  }
                }

        }
    }
}
