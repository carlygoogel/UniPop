//
//  ChatService.swift
//  UniPop-App
//
//  Created by Carly Googel on 5/29/24.
//

import Foundation
import Firebase

struct ChatService {

    let chatPartner: User
   // private var firestoreListener: ListenerRegistration?



        func sendMessage(_ messageText: String) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id

        let currentUserRef = FirestoreConstants.MessagesCollection.document(currentUid).collection(chatPartnerId).document()
        let chatPartnerRef = FirestoreConstants.MessagesCollection.document(chatPartnerId).collection(currentUid)

        let recentCurrentUserRef = FirestoreConstants.MessagesCollection.document(currentUid).collection("recent-messages").document(chatPartnerId)
        let recentPartnerRef = FirestoreConstants.MessagesCollection.document(chatPartnerId).collection("recent-messages").document(currentUid)

        let messageId = currentUserRef.documentID

        let message = Message(
            messageId: messageId,
            fromId: currentUid,
            toId: chatPartnerId,
            messageText: messageText,
            timeStamp: Timestamp())

            let messageData: [String: Any] = [
                "messageId": message.id,
                "fromId": message.fromId,
                "toId": message.toId,
                "messageText": messageText,
                "timeStamp": Timestamp()
            ]

    //    guard let messageData = try? Firestore.Encoder().encode(message) else { return }
        currentUserRef.setData(messageData)
        chatPartnerRef.document(messageId).setData(messageData)

        recentCurrentUserRef.setData(messageData)
        recentPartnerRef.setData(messageData)
    }

     func observeMessages(completion: @escaping([Message]) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id

        let query = FirestoreConstants.MessagesCollection
            .document(currentUid)
            .collection(chatPartnerId)
            .order(by: "timeStamp", descending: false)

        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            var messages = changes.compactMap({ try? $0.document.data(as: Message.self) })

            for (index, message) in messages.enumerated() where !message.isFromCurrentUser {
                messages[index].user = chatPartner
            }
            completion(messages)
        }
    }

//    func updateMessageStatusIfNecessary(_ message: Message) async throws {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        guard !message.read! else { return }
//
//        try await FirestoreConstants.MessagesCollection
//            .document(uid)
//            .collection("recent-messages")
//            .document(message.chatPartnerId)
//            .updateData(["read": true])
//    }

  //  func removeListener() {
   //     self.firestoreListener?.remove()
   //     self.firestoreListener = nil
  //  }

}
