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
        Firestore.firestore().collection("users").getDocuments { (snapshot, error) in
            snapshot?.documents.forEach({ (document) in
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                users.append(user)
                //completion(users)
            })
            completion(users)
        }
    }
}
