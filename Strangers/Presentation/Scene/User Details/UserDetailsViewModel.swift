//
//  UserDetailsViewModel.swift
//  Strangers
//
//  Created by Robihamanto on 24/08/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import RxSwift
import RxCocoa

protocol UserDetailsViewModelInput {
    var userID: Int { get set }
}

protocol UserDetailsViewModelOutput {
    var user: PublishSubject<User> { get }
    var isLoading: BehaviorRelay<Bool> { get }
    var error: BehaviorRelay<String> { get }
}

protocol UserDetailsViewModelType {
    var input: UserDetailsViewModelInput { get }
    var output: UserDetailsViewModelOutput { get }
}

class UserDetailsViewModel: UserDetailsViewModelType, UserDetailsViewModelInput, UserDetailsViewModelOutput  {
    
    var userID: Int = 0
    var user: PublishSubject<User>
    var isLoading: BehaviorRelay<Bool>
    var error: BehaviorRelay<String>
    
    //MARK: - Input & Output
    var input : UserDetailsViewModelInput { return self }
    var output: UserDetailsViewModelOutput { return self }
    
    private var fetchUserUseCase: FetchUserUseCase
    
    init(userID: Int) {
        
        self.userID = userID
        user = userProperty
        isLoading = isLoadingProperty
        error = errorProperty
        
        fetchUserUseCase = FetchUserUseCase(userRepository: UserRepository())
        
        let requestValue = FetchUserUseCaseRequestValue(userID: userID)
        self.isLoading.accept(true)
        
        fetchUserUseCase.execute(requestValue: requestValue) { result in
            self.isLoading.accept(false)
            switch result {
            case .success(let user):
                self.userProperty.onNext(user)
            case .failure(let error):
                self.error.accept(error.localizedDescription)
            }
        }
    }
    
    private var userProperty: PublishSubject<User> = PublishSubject()
    private var isLoadingProperty: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    private var errorProperty: BehaviorRelay<String> = BehaviorRelay(value: "")
    
}
