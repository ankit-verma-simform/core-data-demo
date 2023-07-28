//
//  Coordinator.swift
//  CoreDataDemo
//
//  Created by Ankit Verma on 26/07/23.
//

import UIKit

/// Protocol to allow Easy Navigation using Coordinator Pattern
protocol Coordinator {
    var childCoordinators: [Coordinator]? { get set }
    var navigationController: UINavigationController { get set }
    func start()
    func finish()
}
