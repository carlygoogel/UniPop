

import Foundation
import Combine
import Firebase

@MainActor
class UserStatusViewModel: ObservableObject {
    @Published var currentUser: User?

   // @Published  var enterEmail = ""
    //@Published  var description = ""

   
  //  static let shared = UserStatusViewModel()
    


    private var cancellables = Set<AnyCancellable>()

    init() {
        setupSubscribers()
        fetchCurrentUser() // Initial fetch when the view model is created
    }
  //  init(currentUser: User) {
  //      self.currentUser = currentUser
 //   }

    private func setupSubscribers() {
        UserService.shared.$currentUser
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.currentUser = user
            }
            .store(in: &cancellables)
    }

    func fetchCurrentUser() {
        Task {
            do {
                try await UserService.shared.fetchCurrentUser()
            } catch {
                print("Failed to fetch current user: \(error.localizedDescription)")
            }
        }
    }

    func requestStatus(email: String, description: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let statusRef = Firestore.firestore().collection("requestStatus").document()

        let statusRequest = Status(id: statusRef.documentID, ownerUid: uid, email: email, description: description, request: true)

        let statusData: [String: Any] = [
            "id": statusRequest.id,
            "ownerUid": statusRequest.ownerUid,
            "email": statusRequest.email,
            "description": statusRequest.description,
            "request": statusRequest.request
        ]

    //    guard let encodedStatus = try? Firestore.Encoder().encode(statusRequest) else { return }
       // guard let encodedStatus = try? JSONEncoder().encode(statusRequest) else { return }


        try await statusRef.setData(statusData)
    }

  func updateUserData() async throws {
////        // can also do updateUserData
        var data = [String: Bool]()

////
        data["submittedForm"] = true
      guard let userID = Auth.auth().currentUser?.uid else { return  }
////
        if !data.isEmpty  {
            try await Firestore.firestore().collection("users").document(userID).updateData(data)
        }
    }
}

// I think error might have something to do with when RequestStatusView is ititialized and updateUserData being called
// when requestStatus also inputed firebase
