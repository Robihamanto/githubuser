//
//  User.swift
//  Strangers
//
//  Created by Robihamanto on 17/08/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: Int?
    var name: String?
    var avatar: String?
    var isAdmin: Bool?
    
    public enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "login"
        case avatar = "avatar_url"
        case isAdmin = "site_admin"
    }
    
}
