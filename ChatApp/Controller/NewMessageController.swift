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
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirureUI()
    }
    
    // MARK: Selectors
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
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
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! UserCell
        return cell
    }
}
