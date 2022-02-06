//
//  ChatViewController.swift
//  SelfMessenger
//
//  Created by Teerawat Vanasapdamrong on 4/2/2565 BE.
//

import UIKit

class ChatViewController: UIViewController {
    @IBOutlet private var tableView: UITableView?
    @IBOutlet private var sendButton: UIButton?
    @IBOutlet private var messageTextField: UITextField?
    private var messages: [ChatMessage]?
    var chat: Chat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let chat = chat else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        title = chat.opponent.name
        NotificationCenter.default.addObserver(self, selector: #selector(receiveMessage), name: NSNotification.Name(rawValue: chat.id), object: nil)
        receiveMessage()
    }
    
    @objc func receiveMessage() {
        messages = MessageService.shared.getMessagesForChat(chatID: chat?.id)
        tableView?.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func sendTapped(sender: UIButton) {
        guard let messageText = messageTextField?.text, let chat = self.chat, let user = UserInstance.shared.getUser() else {
            return
        }
        if !messageText.isEmpty {
            let message = ChatMessage(id: UUID().uuidString, chatID: chat.id, message: messageText, senderID: user.id, sentAt: Date().formatted())
            MessageService.shared.sendMessage(message: message)
            messages = MessageService.shared.getMessagesForChat(chatID: chat.id)
            tableView?.reloadData()
            messageTextField?.text = nil
            messageTextField?.resignFirstResponder()
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let message = messages?[indexPath.row], let user = UserInstance.shared.getUser() else {
            return UITableViewCell()
        }
        
        let cellIdentifier: String
        
        if message.senderID != user.id {
            cellIdentifier = "OpponentCell"
        } else {
            cellIdentifier = "UserCell"
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ChatTableViewCell else {
            return UITableViewCell()
        }
        
        cell.displayCell(message: message)
        return cell
    }
}
