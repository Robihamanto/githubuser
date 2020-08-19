//
//  FetchUsersUseCase.swift
//  Strangers
//
//  Created by Robihamanto on 17/08/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import Foundation

protocol FetchUsersUseCaseType {
    func execute(requestValue: FetchUsersUseCaseRequestValue,
                 completion : @escaping((Result<[User], Error>) -> Void))
}

final class FetchUsersUseCase: FetchUsersUseCaseType {
    
    private let userRepository: UserRepositoryType
    
    init(userRepository: UserRepositoryType) {
        self.userRepository = userRepository
    }
    
    func execute(requestValue: FetchUsersUseCaseRequestValue, completion: @escaping ((Result<[User], Error>) -> Void)) {
        userRepository.fetchUsers(page: requestValue.page, pageLimit: requestValue.limit) { result in
            switch result {
            case .success(let users):
                completion(.success(users))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct FetchUsersUseCaseRequestValue {
    let page: Int
    let limit: Int
}
