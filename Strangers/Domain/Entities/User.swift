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
    var htmlUrl: String?
    var followingURL: String?
    var followersURL: String?
    var gistsURL: String?
    var starredURL: String?
    var organizationsURL: String?
    var reposURL: String?
    var eventsURL: String?
    var blog: String?
    
    public enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case avatar = "avatar_url"
        case isAdmin = "site_admin"
        case login = "login"
        case location = "location"
        case url = "url"
        case htmlUrl = "html_url"
        case followingURL = "following_url"
        case followersURL = "followers_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case blog = "blog"
    }
    
}


