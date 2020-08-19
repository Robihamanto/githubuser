//
//  UserRepositoryType.swift
//  Strangers
//
//  Created by Robihamanto on 18/08/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import Foundation

protocol UserRepositoryType {
    
    func fetchUsers(page: Int, pageLimit: Int, completion: @escaping (Result<[User], Error>) -> Void)
    
}
