//
//  AppCoordinator.swift
//  CoreDataDemo
//
//  Created by Ankit Verma on 26/07/23.
//

import UIKit

/// Main Coordinator for CoreDataDemo app
class AppCoordinator: Coordinator {

    // MARK: - Variables

    var navigationController: UINavigationController
    var childCoordinators: [Coordinator]?

    // MARK: - Initializer

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Protocol Functions

    func start() {
        let initialCoordinator = FriendListCoordinator(navigationController: navigationController)
        initialCoordinator.start()
    }

    func finish() {}
}
