//
//  ChatTableViewCell.swift
//  SelfMessenger
//
//  Created by Teerawat Vanasapdamrong on 5/2/2565 BE.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    @IBOutlet private var messageLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func displayCell(message: ChatMessage) {
        messageLabel?.text = message.message
    }
}
