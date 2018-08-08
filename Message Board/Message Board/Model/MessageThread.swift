//
//  MessageThread.swift
//  Message Board
//
//  Created by Simon Elhoej Steinmejer on 08/08/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import Foundation

class MessageThread: Codable
{
    var messages: [MessageThread.Message]
    
    let title: String
    let identifier: String
    
    init(title: String, identifier: String = UUID().uuidString, messages: [MessageThread.Message] = []) {
        self.title = title
        self.identifier = identifier
        self.messages = messages
    }
    
    struct Message: Equatable, Codable
    {
        let text: String
        let sender: String
        let timestamp: Date
        
        init(timestamp: Date = Date(), text: String, sender: String) {
            self.text = text
            self.sender = sender
            self.timestamp = timestamp
        }
    }
    
    required init(from decoder: Decoder) throws {
        
        // 1
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // 2
        let title = try container.decode(String.self, forKey: .title)
        let identifier = try container.decode(String.self, forKey: .identifier)
        let messagesDictionaries = try container.decode([String: MessageThread.Message].self, forKey: .messages)
        
        // 3
        let messages = messagesDictionaries.map({ $0.value })
        
        // 4
        self.title = title
        self.identifier = identifier
        self.messages = messages
    }
}