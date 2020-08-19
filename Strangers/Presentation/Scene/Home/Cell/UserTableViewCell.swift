//
//  UserTableViewCell.swift
//  Strangers
//
//  Created by Robihamanto on 18/08/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell {
    
    static let reusableIdentifier = "UserTableViewCell"
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var isStaffUIView: UIView!
    
    
    func updateView(user: User) {
        isStaffUIView.layer.cornerRadius = isStaffUIView.layer.bounds.height / 2
        userImageView.layer.cornerRadius = userImageView.layer.bounds.height / 2
        
        nameLabel.text = user.name
        
        userImageView
            .kf
            .setImage(with: URL(string: user.avatar ?? ""))
        
        updateStaffLabel(isStaff: user.isAdmin ?? false)
    }
    
    func updateStaffLabel(isStaff: Bool) {
        isStaffUIView.isHidden = !isStaff
    }
    
}
