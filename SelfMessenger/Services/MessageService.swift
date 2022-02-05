//
//  MessageService.swift
//  SelfMessenger
//
//  Created by Teerawat Vanasapdamrong on 2/2/2565 BE.
//

import Foundation

class MessageService {
    static let shared = MessageService()
    private var chats: [Chat]?
    private var messages: [String: [ChatMessage]]?
    
    private init() {
        messages = [:]
        getChatsFromRepo()
    }
    
    func sendMessage(message: ChatMessage) {
        messages?[message.chatID]?.append(message)
        if let index = chats?.firstIndex(where: { chat in
            chat.id == message.chatID
        }), var chat = chats?.remove(at: index) {
            chat.lastMessage = message
            chats?.insert(chat, at: 0)
            messageBot(message: message, opponentID: chat.opponent.id)
        }
    }
    
    func receiveMessage(message: ChatMessage) {
        messages?[message.chatID]?.append(message)
        if let index = chats?.firstIndex(where: { chat in
            chat.id == message.chatID
        }), var chat = chats?.remove(at: index) {
            chat.lastMessage = message
            chats?.insert(chat, at: 0)
        }
    }
    
    func getChats() -> [Chat]? {
        return chats
    }
    
    func getMessagesForChat(chatID: String?) -> [ChatMessage] {
        guard let id = chatID else {
            return []
        }
        return messages?[id] ?? []
    }
    
    private func getChatsFromRepo() {
        if let path = Bundle.main.path(forResource: "chat_mock", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
                do {
                    let decoder = JSONDecoder()
                    let chats = try decoder.decode([Chat].self, from: data)
                    self.chats = chats
                    for chat in chats {
                        messages?[chat.id] = [chat.lastMessage]
                    }
                } catch {
                    print(error.localizedDescription)
                }
             }
        }
    }
    
    private func messageBot(message: ChatMessage, opponentID: String) {
        let newMessage = ChatMessage(id: UUID().uuidString, chatID: message.chatID, message: message.message, senderID: opponentID, sentAt: Date().formatted())
        receiveMessage(message: newMessage)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: message.chatID), object: nil)
    }
}
