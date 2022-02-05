//
//  FriendTableViewCell.swift
//  SelfMessenger
//
//  Created by Teerawat Vanasapdamrong on 3/2/2565 BE.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    private var chat: Chat?
    @IBOutlet private var nameLabel: UILabel?
    @IBOutlet private var messageLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func displayCell(chat: Chat) {
        self.chat = chat
        nameLabel?.text = chat.opponent.name
        messageLabel?.text = chat.lastMessage.message
    }
}
