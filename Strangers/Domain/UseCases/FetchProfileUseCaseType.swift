//
//  FetchProfileUseCaseType.swift
//  Strangers
//
//  Created by Robihamanto on 05/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import Foundation

protocol FetchProfileUseCaseType {
    func execute(completion : @escaping((Result<User, Error>) -> Void))
}

final class FetchProfileUseCase: FetchProfileUseCaseType {
    
    private let userRepository: UserRepositoryType
    
    init(userRepository: UserRepositoryType) {
        self.userRepository = userRepository
    }
    
    func execute(completion: @escaping ((Result<User, Error>) -> Void)) {
        userRepository.fetchProfile(completion: { result in
            switch result {
            case .success(let users):
                completion(.success(users))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
}
