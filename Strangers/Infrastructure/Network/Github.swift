//
//  Github.swift
//  Strangers
//
//  Created by Robihamanto on 18/08/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import Moya

enum Github {
    case fetchUsers(page: Int, pageLimit: Int)
    case fetchUser(id: Int)
}

extension Github: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.github.com") else {
            fatalError("FAILED: https://api.github.com")
        }
        return url
    }
    
    var path: String {
        switch self {
            case .fetchUsers:
                return "/users"
            case .fetchUser(let id):
                return "/user/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .fetchUsers:
            return .get
            case .fetchUser(_):
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case let .fetchUsers (page, pageLimit):
            var params: [String: Any] = [:]
            params["page"] = page
            params["per_page"] = pageLimit

            return .requestParameters(parameters: params, encoding: URLEncoding())
            
        case .fetchUser:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .fetchUsers, .fetchUser:
            let token = "2c3448408fced55050d749406f9c43679fa49c26"
            return ["Authorization": "Bearer \(token)"]
        }
    }
    
    
}
