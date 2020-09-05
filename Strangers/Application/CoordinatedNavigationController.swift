//
//  CoordinatedNavigationController.swift
//  Strangers
//
//  Created by Robihamanto on 05/09/20.
//  Copyright © 2020 Robihamanto. All rights reserved.
//

import UIKit

/// A navigation controller that is aware of its coordinator. This is used extremely rarely through UIResponder-Coordinated.swift, for when we need to find the coordinator responsible for a specific view.
class CoordinatedNavigationController: UINavigationController {

    weak var coordinator: Coordinator?

}
