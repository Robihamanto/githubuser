//
//  UserTableViewCell.swift
//  Strangers
//
//  Created by Robihamanto on 18/08/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    static let reusableIdentifier = "UserTableViewCell"
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var isStaffUIView: UIView!
    
    
    func updateView(user: User) {
        isStaffUIView.layer.cornerRadius = isStaffUIView.layer.bounds.height / 2
        nameLabel.text = user.login
        
        updateStaffLabel(isStaff: true)
    }
    
    func updateStaffLabel(isStaff: Bool) {
        
    }
    
}
