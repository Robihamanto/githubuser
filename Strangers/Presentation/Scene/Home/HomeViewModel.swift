//
//  HomeViewModel.swift
//  Strangers
//
//  Created by Robihamanto on 18/08/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import Foundation

final class HomeViewModel {
    
    private let fetchUsersUseCase: FetchUsersUseCase
    
    init(fetchUsersUseCase: FetchUsersUseCase) {
        self.fetchUsersUseCase = fetchUsersUseCase
    }
    
    
    func fetchUsers(completion: @escaping ([User]) -> Void) {
        
        let requestValue = FetchUsersUseCaseRequestValue(page: 1, limit: 10)
        
        fetchUsersUseCase.execute(requestValue: requestValue) { result in
            switch result {
            case .success(let users):
                completion(users)
            case .failure:
                completion([])
            }
        }
    }
    
}
