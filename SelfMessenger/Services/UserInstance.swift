//
//  UserInstance.swift
//  SelfMessenger
//
//  Created by Teerawat Vanasapdamrong on 4/2/2565 BE.
//

import Foundation

class UserInstance {
    static let shared = UserInstance()
    private let user: User?
    
    private init() {
        user = User(id: UUID().uuidString, name: "myself")
    }
    
    func getUser() -> User? {
        return user
    }
}
