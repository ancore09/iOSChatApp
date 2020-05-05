//
//  Service.swift
//  ChatApp
//
//  Created by Andrey  Grechko on 05.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import Firebase

struct Service {
    static let shared = Service()
    
    func fetchUsers(completion: @escaping([User]) -> Void) {
        var users = [User]()
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            snapshot?.documents.forEach({ (document) in
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                users.append(user)
                //completion(users)
            })
            completion(users)
        }
    }
    
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
            guard let dict = snapshot?.data() else { return }
            let user = User(dictionary: dict)
            completion(user)
        }
    }
    
    func uploadMessage(_ message: String, toUser: User, completion: ((Error?) -> Void)?) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["text": message,
                    "fromId": currentUid,
                    "toId": toUser.uid,
                    "timestamp": Timestamp(date: Date())] as [String : Any]
        
        COLLECTION_MESSAGES.document(currentUid).collection(toUser.uid).addDocument(data: data) { (error) in
            COLLECTION_MESSAGES.document(toUser.uid).collection(currentUid).addDocument(data: data, completion: completion)
            
            COLLECTION_MESSAGES.document(currentUid).collection("recent-messages").document(toUser.uid).setData(data)
            COLLECTION_MESSAGES.document(toUser.uid).collection("recent-messages").document(currentUid).setData(data)
        }
    }
    
    func fetchMessages(forUser user: User, completion: @escaping([Message]) -> Void) {
        var messages = [Message]()
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let query = COLLECTION_MESSAGES.document(currentUid).collection(user.uid).order(by: "timestamp")
        
        query.addSnapshotListener { (snapshot, error) in
            snapshot?.documentChanges.forEach({ (change) in
                if change.type == .added {
                    let dict = change.document.data()
                    messages.append(Message(dictionary: dict))
                    completion(messages)
                }
            })
            //completion(messages)
        }
    }
    
    func fetchConversations(completion: @escaping([Conversation]) -> Void) {
        var conversations = [Conversation]()
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let query = COLLECTION_MESSAGES.document(currentUid).collection("recent-messages").order(by: "timestamp")
        
        query.addSnapshotListener { (snapshot, error) in
            snapshot?.documentChanges.forEach({ (change) in
                let dict = change.document.data()
                let message = Message(dictionary: dict)
                
                var id = ""
                
                if message.fromId == Auth.auth().currentUser?.uid {
                    id = message.toId
                } else {
                    id = message.fromId
                }
                
                self.fetchUser(withUid: id) { (user) in
                    let conversation = Conversation(user: user, message: message)
                    conversations.append(conversation)
                    completion(conversations)
                }
            })
            //completion(conversations)
        }
    }
}
