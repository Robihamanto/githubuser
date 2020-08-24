//
//  UserDetailsViewController.swift
//  Strangers
//
//  Created by Robihamanto on 17/08/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var isStaff: UIView!
    
    
    weak var coordinator: UserCoordinator?
    var userID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
