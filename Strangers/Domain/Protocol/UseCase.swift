//
//  UseCase.swift
//  Strangers
//
//  Created by Robihamanto on 17/08/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import Foundation

public protocol UseCase {
    
    @discardableResult
    func start() -> Cancellable?
}
