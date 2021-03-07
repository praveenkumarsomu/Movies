//
//  Coordinator.swift
//  Movies
//
//  Created by Praveen on 6/3/21.
//

import UIKit

/// Coordinator Protocol each protocol should confirm to this
protocol Coordinator {
    var chileCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
