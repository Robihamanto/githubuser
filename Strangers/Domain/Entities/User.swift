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
    var bio: String?
    var login: String?
    var location: String?
    var url: String?
    
    public enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case avatar = "avatar_url"
        case isAdmin = "site_admin"
        case login = "login"
        case location = "location"
        case url = "url"
    }
    
}
