//
//  UserRepository.swift
//  Strangers
//
//  Created by Robihamanto on 18/08/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import Foundation

final class UserRepository {
    
    // Add Moya Service Provider
    // Inject the provider
    
}

extension UserRepository: UserRepositoryType {
    
    func fetchUsers(page: Int, pageLimit: Int, completion: @escaping (Result<[User], Error>) -> Void) {
        let service = GithubService()
        service.fetchUsers(page: page, pageLimit: pageLimit) { result in
            switch result {
            case .success(let users):
                completion(.success(users))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchUser(userID: Int, completion: @escaping (Result<User, Error>) -> Void) {
        let service = GithubService()
        service.fetchUser(userID: userID) { result in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
