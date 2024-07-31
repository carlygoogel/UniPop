//
//  InboxViewModel.swift
//  UniPop-App
//
//  Created by Carly Googel on 5/28/24.
//

import Foundation
import Combine
import Firebase

@MainActor
class InboxViewModel: ObservableObject {
    @Published var currentUser: User?
  //  @Published var recentMessages = [String: Message]()
    @Published var recentMessages = [Message]()

    private var cancellables = Set<AnyCancellable>()
    private let service = InboxService()
    private var didCompleteInitialLoad = false


    init() {
        setupSubscribers()
        service.observeRecentMessages()
    }

    func deleteRecentMessage(_ message: Message) async {
        do {
            guard let index = self.recentMessages.firstIndex(where: { $0.id == message.id }) else { return }
            recentMessages.remove(at: index)
            try await service.deleteConversation(recentMessage: message)
        } catch {
            print("DEBUG: Error deleting message with \(error)")
        }

    }

    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellables)

        service.$documentChanges.sink { [weak self] changes in
            guard let self else { return }

            if didCompleteInitialLoad {
                updateMessages(changes)
            } else {
                // changing
                loadInitialMessages1(fromChanges: changes)
            }

        }.store(in: &cancellables)
    }

    // fix error where chat reshows up when send message in inbox view

    private func loadInitialMessages(fromChanges changes: [DocumentChange]) {
        var messages = changes.compactMap({ try? $0.document.data(as: Message.self ) })

        for i in 0 ..< messages.count {
            let message = messages[i]

            UserService.fetchUser(withUid: message.chatPartnerId) { user in
                messages[i].user = user
                self.recentMessages.append(messages[i])

                if i == messages.count - 1 {
                    self.didCompleteInitialLoad = true
                }
            }
        }
    }

    private func loadInitialMessages1(fromChanges changes: [DocumentChange]) {
        let newMessages = changes.compactMap({ try? $0.document.data(as: Message.self) })

        let dispatchGroup = DispatchGroup()
        var updatedMessages: [Message] = []

        for message in newMessages {
            dispatchGroup.enter()
            UserService.fetchUser(withUid: message.chatPartnerId) { user in
                var updatedMessage = message
                updatedMessage.user = user
                updatedMessages.append(updatedMessage)
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            // Remove duplicates based on message ID
            let uniqueMessages = Array(Set(self.recentMessages + updatedMessages))

            // Sort messages by timestamp, most recent first
            self.recentMessages = uniqueMessages.sorted(by: { $0.timeStamp.dateValue() > $1.timeStamp.dateValue() })

            self.didCompleteInitialLoad = true
        }
    }




  //  private func loadInitialMessages(fromChanges changes: [DocumentChange]) {
   //     let messages = changes.compactMap { change in
   //         try? change.document.data(as: Message.self)
   //     }

   //     for i in 0 ..< messages.count {
   //         var message = messages[i]
   //         let chatPartnerId = message.chatPartnerId

            // attach the user/chat-partner OBJECT for the message (profile picture + other metadata)
   //         UserService.fetchUser(withUid: chatPartnerId) { user in
   //             message.user = user

                // Update the dictionary with the recent message for the chat partner
          //      self.recentMessages[chatPartnerId] = message
 //           }
 //       }
 //   }

    private func updateMessages(_ changes: [DocumentChange]) {
        for change in changes {
            if change.type == .added {
                createNewConversation(change)
            } else if change.type == .modified {
                updateMessagesFromExistingConversation(change)
            }
        }

    }

    private func createNewConversation(_ change: DocumentChange) {
        guard var message = try? change.document.data(as: Message.self) else { return }

        UserService.fetchUser(withUid: message.chatPartnerId) { [weak self] user in
            message.user = user
            self?.recentMessages.insert(message, at: 0)

        }

    }

    private func updateMessagesFromExistingConversation(_ change: DocumentChange) {
        guard var message = try? change.document.data(as: Message.self) else { return }
        guard let index = self.recentMessages.firstIndex(where: { $0.user?.id == message.chatPartnerId }) else { return }

        message.user = recentMessages[index].user

        recentMessages.remove(at: index)
        recentMessages.insert(message, at: 0)
    }
}
