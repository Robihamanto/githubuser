//
//  FetchUserUseCase.swift
//  Strangers
//
//  Created by Robihamanto on 24/08/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import Foundation

protocol FetchUserUseCaseType {
    func execute(requestValue: FetchUserUseCaseRequestValue,
                 completion : @escaping((Result<User, Error>) -> Void))
}

final class FetchUserUseCase: FetchUserUseCaseType {
    
    private let userRepository: UserRepositoryType
    
    init(userRepository: UserRepositoryType) {
        self.userRepository = userRepository
    }
    
    func execute(requestValue: FetchUserUseCaseRequestValue, completion: @escaping ((Result<User, Error>) -> Void)) {
        userRepository.fetchUser(userID: requestValue.userID) { result in
            switch result {
            case .success(let users):
                completion(.success(users))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct FetchUserUseCaseRequestValue {
    let userID: Int
}
