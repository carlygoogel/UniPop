//
//  ProfileView.swift
//  UniPop-App
//
//  Created by Carly Googel on 4/24/24.
//

import SwiftUI
import PhotosUI


struct ProfileView: View {
  // @EnvironmentObject var viewModel: AuthViewModel
    @State private var isPresentingPhotosPicker = false
    @State private var profileImage: UIImage? = nil
    @StateObject var viewModelProfile = ProfileViewMod()
    let user: User


    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    @State private var isCheckingStatus = false

    var body: some View {
     //   if let user = viewModel.currentUser {
            VStack {
                VStack {

                  //  PhotosPicker(selection: //$viewModelProfile.selectedItem) {
                        if let profileImage = viewModelProfile.ProfileImage {
                            
                            profileImage
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(.circle)

                        } else {
                            CircularProfileImageNewView(user: user, size: .xLarge)
                        }
                //    }

                    Text("\(user.firstname) \(user.lastname)")
                        .font(.title2)
                        .fontWeight(.semibold)
                }

                // put button here
                VStack {
                    HStack {
                    if let existingConnectedUrl = UserService.shared.currentUser?.connectedUrl {
                        Button(action: {
                            if let url = URL(string: existingConnectedUrl) {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Text("Your Stripe Dashboard")
                                .padding()
                            //  .background(Color(red: 0.9, green: 0.31, blue: 1.0))
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
                    } else {
                        Button(action: connectToStripe) {
                            if isLoading {
                                ProgressView()
                            } else {
                                Text("Connect with Stripe")
                                    .padding()
                                    .background(Color(hex: 0xE64FFF))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                        .disabled(isLoading)
                    }

                    Button(action: {
                        if let connectedId = UserService.shared.currentUser?.connectedId {
                            checkAccountStatus(with: connectedId)
                        } else {
                            showAlert(title: "Info", message: "You haven't connected a Stripe account yet.")
                        }
                    }) {
                        Image(systemName: "info.circle")
                            .foregroundColor(Color(hex: 0xE64FFF))
                    }
                    .disabled(isCheckingStatus)
                }


                    if let error = errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                .padding(.bottom, 10)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }




                List {
                    Section {
                        ForEach(SettingsOptionsViewModel.allCases) { option in
                            HStack {
                                Image(systemName: option.imageName)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(option.imageBackgroundColor)

                                Text(option.title)
                                    .font(.subheadline)
                            }
                        }

                    }

                    Section("Account") {
                        Button("Sign Out") {
                            AuthService.shared.signOut()
                        }

                        .foregroundColor(.red)


                            Button {
                                print("Delete out...")
                            } label: {
                                Text("Delete Account")

                    }
                            .foregroundColor(.red)

                }



            }
                


            }
        }
    func connectToStripe() {
        isLoading = true
        errorMessage = nil

        if let existingConnectedId = UserService.shared.currentUser?.connectedId {
            // Use existing connectedId to open Stripe dashboard
            checkAccountStatus(with: existingConnectedId)
        } else {
            // Proceed with creating a new account session
            createAccountSession()
        }
    }

    func checkAccountStatus(with connectedId: String) {
        isLoading = true
        errorMessage = nil

        guard let url = URL(string: "http://localhost:4242/check-account-status") else {
            showAlert(title: "Error", message: "Invalid URL")
            isLoading = false
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["connectedAccountId": connectedId]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false

                if let error = error {
                    self.showAlert(title: "Error", message: error.localizedDescription)
                    return
                }

                guard let data = data else {
                    self.showAlert(title: "Error", message: "No data received")
                    return
                }

                do {
                    if let status = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        let isFullyVerified = status["isFullyVerified"] as? Bool ?? false
                        let detailsSubmitted = status["detailsSubmitted"] as? Bool ?? false
                        let chargesEnabled = status["chargesEnabled"] as? Bool ?? false
                        let payoutsEnabled = status["payoutsEnabled"] as? Bool ?? false

                        var statusMessage = "Account Status:\n"
                        statusMessage += "Fully Verified: \(isFullyVerified)\n"
                        statusMessage += "Details Submitted: \(detailsSubmitted)\n"
                        statusMessage += "Can Accept Payments: \(chargesEnabled)\n"
                        statusMessage += "Can Receive Payouts: \(payoutsEnabled)\n"

                        let requirements = status["requirements"] as? [String: Any]
                        let currentlyDue = requirements?["currently_due"] as? [String] ?? []

                        if currentlyDue.isEmpty && isFullyVerified && chargesEnabled && payoutsEnabled {
                            Task {
                                do {
                                    try await UserService.shared.updateVerifiedPayments(true)
                                    statusMessage += "\nVerified Payments status updated to true."
                                } catch {
                                    statusMessage += "\nError updating Verified Payments status: \(error.localizedDescription)"
                                }
                            }
                        }

                        if !currentlyDue.isEmpty {
                            statusMessage += "\nOutstanding Requirements:\n"
                            statusMessage += currentlyDue.joined(separator: ", ")
                        }

                        self.showAlert(title: "Account Status", message: statusMessage)
                    } else {
                        self.showAlert(title: "Error", message: "Invalid response from server")
                    }
                } catch {
                    self.showAlert(title: "Error", message: "Error parsing response: \(error.localizedDescription)")
                }
            }
        }.resume()
    }

    private func showAlert(title: String, message: String) {
        self.alertTitle = title
        self.alertMessage = message
        self.showAlert = true
    }

    func openStripeDashboard(with connectedId: String) {
        isLoading = true
        errorMessage = nil

        guard let url = URL(string: "http://localhost:4242/get-dashboard-link") else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["connectedAccountId": connectedId]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false

                if let error = error {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                    return
                }

                guard let data = data else {
                    self.errorMessage = "No data received"
                    return
                }

                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let urlString = json["url"] as? String,
                       let dashboardUrl = URL(string: urlString) {
                        UIApplication.shared.open(dashboardUrl)
                    } else {
                        self.errorMessage = "Invalid response from server"
                    }
                } catch {
                    self.errorMessage = "Error parsing response: \(error.localizedDescription)"
                }
            }
        }.resume()
    }

    func createAccountSession() {
   //     isLoading = true
     //   errorMessage = nil

        guard let url = URL(string: "http://localhost:4242/create-account-session") else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false

                if let error = error {
                    errorMessage = "Error: \(error.localizedDescription)"
                    return
                }

                guard let data = data else {
                    errorMessage = "No data received"
                    return
                }

                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let urlString = json["url"] as? String,
                       let url = URL(string: urlString),
                       let connectedId = json["accountId"] as?

                        String {
                        UIApplication.shared.open(url)

                        // Update the user's connectedId in Firebase
                        Task {
                            do {

                                try await UserService.shared.updateUserConnectedId(connectedId)
                                try await UserService.shared.updateUserConnectedUrl(urlString)
                            } catch {
                                errorMessage = "Failed to update user: \(error.localizedDescription)"
                            }
                        }
                    } else {
                        errorMessage = "Invalid response from server"
                    }
                } catch {
                    errorMessage = "Error parsing response: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
    }


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User.MOCK_USER)
            // Fallback on earlier versions

    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double(hex & 0xff) / 255,
            opacity: alpha
        )
    }
}
