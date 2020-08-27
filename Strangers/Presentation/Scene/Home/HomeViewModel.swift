//
//  HomeViewModel.swift
//  Strangers
//
//  Created by Robihamanto on 18/08/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import RxSwift
import RxCocoa

protocol HomeViewModelInput {
    var loadMore: BehaviorRelay<Bool> { get }
}

protocol HomeViewModelOutput {
    var users: PublishSubject<[User]> { get }
    var isLoading: BehaviorRelay<Bool> { get }
}

protocol HomeViewModelType {
    var input: HomeViewModelInput { get }
    var output: HomeViewModelOutput { get }
}

class HomeViewModel: HomeViewModelType, HomeViewModelInput, HomeViewModelOutput  {
    
    //MARK: - Input & Output
    var input : HomeViewModelInput { return self }
    var output: HomeViewModelOutput { return self }
    
    private let disposeBag = DisposeBag()
    private let fetchUsersUseCase: FetchUsersUseCase
    
    var loadMore: BehaviorRelay<Bool>
    var users: PublishSubject<[User]>
    var isLoading: BehaviorRelay<Bool>
    var currentPage = 1
    
    init() {
        fetchUsersUseCase = FetchUsersUseCase(userRepository: UserRepository())
        
        loadMore = loadMoreProperty
        isLoading = isLoadingProperty
        users = usersProperty
        fetchUsers()
        
        loadMore.subscribe(onNext: {[weak self] loadMore in
            if loadMore {
                let page = self?.currentPage ?? 0
                self?.currentPage = page + 1
                self?.fetchUsers()
                self?.loadMoreProperty.accept(false)
            }
        }).disposed(by: disposeBag)
    }
    
    func fetchUsers() {
        
        let requestValue = FetchUsersUseCaseRequestValue(page: 1, limit: (self.currentPage * 30))
        isLoadingProperty.accept(true)
        fetchUsersUseCase.execute(requestValue: requestValue) { result in
            switch result {
            case .success(let users):
                self.usersProperty.onNext(users)
                self.isLoadingProperty.accept(false)
            case .failure:
                self.isLoadingProperty.accept(false)
            }
        }
    }
    
    var loadMoreProperty: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var usersProperty: PublishSubject<[User]> = PublishSubject()
    var isLoadingProperty: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    
    
}
