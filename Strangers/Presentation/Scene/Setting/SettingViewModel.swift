//
//  SettingViewModel.swift
//  Strangers
//
//  Created by Robihamanto on 05/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import RxSwift
import RxCocoa

protocol SettingViewModelInput {
    
}

protocol SettingViewModelOutput {
    var user: PublishSubject<User> { get }
    var isLoading: BehaviorRelay<Bool> { get }
    var error: BehaviorRelay<String> { get }
}

protocol SettingViewModelType {
    var input: SettingViewModelInput { get }
    var output: SettingViewModelOutput { get }
}

class SettingViewModel: SettingViewModelType, SettingViewModelInput, SettingViewModelOutput  {
    
    //MARK: - Input & Output
    var input : SettingViewModelInput { return self }
    var output: SettingViewModelOutput { return self }
    
    var user: PublishSubject<User>
    var isLoading: BehaviorRelay<Bool>
    var error: BehaviorRelay<String>
    
    var fetchProfileUseCase: FetchProfileUseCase
    
    init() {
        fetchProfileUseCase = FetchProfileUseCase(userRepository: UserRepository())
        
        user = userProperty
        isLoading = isLoadingProperty
        error = errorProperty
        
        fetchProfileUseCase.execute { [weak self] result in
            switch result {
            case .success(let value):
                self?.user.onNext(value)
            case .failure(let error):
                self?.error.accept(error.localizedDescription)
            }
        }
        
    }
    
    
    private var userProperty: PublishSubject<User> = PublishSubject()
    private var isLoadingProperty: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    private var errorProperty: BehaviorRelay<String> = BehaviorRelay(value: "")

}






