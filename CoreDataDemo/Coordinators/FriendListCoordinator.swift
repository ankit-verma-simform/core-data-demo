//
//  FriendListCoordinator.swift
//  CoreDataDemo
//
//  Created by Ankit Verma on 26/07/23.
//

import UIKit

/// Coordinator for FriendList Screen
class FriendListCoordinator: Coordinator {

    // MARK: - Variables

    var childCoordinators: [Coordinator]?
    var navigationController: UINavigationController

    // MARK: - Initializer

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Protocol Functions

    func start() {
        guard let viewController = R.storyboard.main.friendListVC() else {
            return
        }
        navigationController.pushViewController(viewController, animated: true)
    }

    func finish() {
        navigationController.popViewController(animated: true)
    }
}
