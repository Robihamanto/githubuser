//
//  GithubService.swift
//  Strangers
//
//  Created by Robihamanto on 18/08/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import Moya

protocol GithubServiceType {
    func fetchUsers(page:Int, pageLimit: Int, completion: @escaping (Result<[User], Error>) -> Void)
    func fetchUser(userID: Int, completion: @escaping (Result<User, Error>) -> Void)
}

class GithubService: GithubServiceType {
    
    private let provider = MoyaProvider<Github>(plugins: [NetworkLoggerPlugin()])
    
    func fetchUsers(page:Int, pageLimit: Int, completion: @escaping (Result<[User], Error>) -> Void) {
        provider.request(.fetchUsers(page: page, pageLimit: pageLimit)) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try JSONDecoder().decode([User].self, from: response.data)
                    completion(.success(response))
                } catch (let error) {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchUser(userID: Int, completion: @escaping (Result<User, Error>) -> Void) {
        provider.request(.fetchUser(id: userID)) { result in
            switch result {
            case .success(let response):
                do {
                    let response = try JSONDecoder().decode(User.self, from: response.data)
                    completion(.success(response))
                } catch (let error) {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
