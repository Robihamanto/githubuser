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
    var login: String?
    var avatar: String?
    
    public enum CodingKeys: String, CodingKey {
        case avatar = "avatar_url"
    }
    
}
