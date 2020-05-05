//
//  NewMessageController.swift
//  ChatApp
//
//  Created by Andrey  Grechko on 05.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import UIKit

private let reuseId = "UserCell"

class NewMessageController: UITableViewController {
    
    // MARK: Properties
    
    private var users = [User]()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirureUI()
        fetchUsers()
    }
    
    // MARK: Selectors
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: API
    
    func fetchUsers() {
        Service.shared.fetchUsers { (users) in
            self.users = users
            print(users)
            self.tableView.reloadData()
        }
    }
    
    // MARK: Helpers
    
    func confirureUI() {
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .white
        configureNavigationBar(withTitle: "New Message", prefersLargeTitles: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismiss))
        
        tableView.tableFooterView = UIView()
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseId)
        tableView.rowHeight = 80
    }
}

extension NewMessageController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! UserCell
        cell.user = users[indexPath.row]
        return cell
    }
}
