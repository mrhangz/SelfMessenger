//
//  ChatListViewController.swift
//  SelfMessenger
//
//  Created by Teerawat Vanasapdamrong on 2/2/2565 BE.
//

import UIKit

class ChatListViewController: UITableViewController {
    private var chats: [Chat]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let chats = MessageService.shared.getChats() {
            self.chats = chats
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chats?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendTableViewCell, let chat = chats?[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.displayCell(chat: chat)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let chat = chats?[indexPath.row] else {
            return
        }
        performSegue(withIdentifier: "ChatVC", sender: chat)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let chat = sender as? Chat, let destination = segue.destination as? ChatViewController else {
            return
        }
        destination.chat = chat
    }
}

