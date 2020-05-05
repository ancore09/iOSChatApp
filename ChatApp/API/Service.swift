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
    
    func fetchUsers() {
        Firestore.firestore().collection("users").getDocuments { (snapshot, error) in
            snapshot?.documents.forEach({ (document) in
                print(document.data())
            })
        }
    }
}
