//
//  ChatViewModel.swift
//  UniPop-App
//
//  Created by Carly Googel on 5/29/24.
//

import Foundation


import Firebase
import FirebaseFirestoreSwift
import SwiftUI


class ChatViewModel: ObservableObject {
    @Published var messages = [Message]()
    @Published var messageText = ""

    let service: ChatService

    init(user: User) {
        self.service = ChatService(chatPartner: user)
        observeMessages()
    }

    func observeMessages() {
     //   service.observeMessages() { messages in
    //       self.messages.append(contentsOf: messages)
    //    }
        service.observeMessages { [weak self] messages in
            guard let self = self else { return }
            self.messages.append(contentsOf: messages)
        }
    }

    func sendMessage() {
        service.sendMessage(messageText)
    }

    // adding
//    func updateMessageStatusIfNecessary() async throws {
//        guard let lastMessage = messages.last else { return }
//        try await service.updateMessageStatusIfNecessary(lastMessage)
//    }

    func nextMessage(forIndex index: Int) -> Message? {
        return index != messages.count - 1 ? messages[index + 1] : nil
    }
}
