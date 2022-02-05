//
//  Models.swift
//  SelfMessenger
//
//  Created by Teerawat Vanasapdamrong on 2/2/2565 BE.
//

import Foundation

struct User: Codable {
    var id: String
    var name: String
}

struct ChatMessage: Codable {
    var id: String
    var chatID: String
    var message: String
    var senderID: String
    var sentAt: String
}

struct Chat: Codable {
    var id: String
    var opponent: User
    var lastMessage: ChatMessage
}
