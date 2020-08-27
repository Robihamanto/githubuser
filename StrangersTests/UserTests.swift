//
//  UserTests.swift
//  StrangersTests
//
//  Created by Robihamanto on 27/08/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import XCTest
@testable import Strangers

class UserTests: XCTestCase {
    
    var users = [User]()
    
    override func setUp() {
        super.setUp()
        
        users = [
            User(id: 1738, name: "frank", avatar: "https://avatars0.githubusercontent.com/u/2?v=4", isAdmin: false, bio: "🎉", login: "Kurt", location: "San Diego", url: "https://api.github.com/users/defunkt/repos", blog: "http://chriswanstrath.com/"),
            User(id: 1728, name: "bruno", avatar: "https://avatars0.githubusercontent.com/u/2?v=4", isAdmin: true, bio: "This is my Bio", login: "Mraz", location: "San Diego", url: "https://api.github.com/users/defunkt/repos", blog: "http://chriswanstrath.com/"),
            User(id: 1718, name: "Halilintar", avatar: "https://avatars0.githubusercontent.com/u/2?v=4", isAdmin: false, bio: "Hello world", login: "Atta", location: "San Diego", url: "https://api.github.com/users/defunkt/repos", blog: "http://comeapp.id/")
            ]
        
    }
    
    struct UserRepositoryMock: UserRepositoryType {
        
        var singleResult: Result<User, Error>
        var arrayResult: Result<[User], Error>
        
        func fetchUsers(page: Int, pageLimit: Int, completion: @escaping (Result<[User], Error>) -> Void) {
            completion(arrayResult)
        }
        
        func fetchUser(userID: Int, completion: @escaping (Result<User, Error>) -> Void) {
            completion(singleResult)
        }
        
        
    }
    
    func testFetchContactsHasExpectedItemCount() {
        let requestValue = FetchUsersUseCaseRequestValue(page: 1, limit: 1)
        let useCase = FetchUsersUseCase(userRepository: UserRepositoryMock(singleResult: .success(users[0]), arrayResult: .success(users)))
        
        useCase.execute(requestValue: requestValue) { result in
            switch result {
            case .success(let users):
                XCTAssert(users.count == 3, "Users doesn't give us the right value")
            case .failure:
                XCTAssert(false, "Cannot fetch Users")
            }
        }
        
    }
    
    func testFetchContactsHasExpectedFirstItemValue() {
        let requestValue = FetchUsersUseCaseRequestValue(page: 1, limit: 1)
        let useCase = FetchUsersUseCase(userRepository: UserRepositoryMock(singleResult: .success(users[0]), arrayResult: .success(users)))
        
        useCase.execute(requestValue: requestValue) { result in
            switch result {
            case .success(let users):
                
                XCTAssertEqual(users.first?.name, "frank")
                XCTAssertEqual(users.first?.avatar, "https://avatars0.githubusercontent.com/u/2?v=4")
                XCTAssertEqual(users.first?.isAdmin, false)
                XCTAssertEqual(users.first?.bio, "🎉")
                XCTAssertEqual(users.first?.login, "Kurt")
                XCTAssertEqual(users.first?.location, "San Diego")
                XCTAssertEqual(users.first?.url, "https://api.github.com/users/defunkt/repos")
                XCTAssertEqual(users.first?.blog, "http://chriswanstrath.com/")
                
            case .failure:
                XCTAssert(false, "Cannot fetch User")
            }
        }
        
    }
    
    func testFetchContactHasExpectedFirstItemValue() {
        let requestValue = FetchUserUseCaseRequestValue(userID: 1738)
        let useCase = FetchUserUseCase(userRepository: UserRepositoryMock(singleResult: .success(users[0]), arrayResult: .success(users)))
        
        useCase.execute(requestValue: requestValue) { result in
            switch result {
            case .success(let user):
                
                XCTAssertEqual(user.name, "frank")
                XCTAssertEqual(user.avatar, "https://avatars0.githubusercontent.com/u/2?v=4")
                XCTAssertEqual(user.isAdmin, false)
                XCTAssertEqual(user.bio, "🎉")
                XCTAssertEqual(user.login, "Kurt")
                XCTAssertEqual(user.location, "San Diego")
                XCTAssertEqual(user.url, "https://api.github.com/users/defunkt/repos")
                XCTAssertEqual(user.blog, "http://chriswanstrath.com/")
                
            case .failure:
                XCTAssert(false, "Cannot fetch User")
            }
        }
        
    }

}
