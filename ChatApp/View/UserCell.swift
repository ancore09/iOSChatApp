//
//  UserCell.swift
//  ChatApp
//
//  Created by Andrey  Grechko on 05.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import UIKit
import SDWebImage

class UserCell: UITableViewCell {
    
    //MARK: Properties
    
    var user: User? {
        didSet { configure() }
    }
    
    private let profileImgeView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemPink
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "spiderman"
        return label
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "Peter Parker"
        return label
    }()
    
    //MARK: Lyfecycle
    
    //MARK: Selectors
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImgeView)
        profileImgeView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        profileImgeView.setDimensions(height: 56, width: 56)
        profileImgeView.layer.cornerRadius = 56 / 2
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        stack.axis = .vertical
        stack.spacing = 2
        addSubview(stack)
        stack.centerY(inView: profileImgeView, leftAnchor: profileImgeView.rightAnchor, paddingLeft: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Helpers
    
    func configure() {
        guard let user = user else { return }
        fullnameLabel.text = user.fullname
        usernameLabel.text = user.username
        
        guard let url = URL(string: user.profileImageUrl) else { return }
        profileImgeView.sd_setImage(with: url, completed: nil)
    }
}
