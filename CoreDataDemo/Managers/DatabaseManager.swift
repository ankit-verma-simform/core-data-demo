//
//  DatabaseManager.swift
//  CoreDataDemo
//
//  Created by Ankit Verma on 26/07/23.
//

import Foundation
import CoreData

/// Database Manager for CoreData uses in app
final class DatabaseManager {

    // MARK: - Singleton

    static let shared = DatabaseManager()
    private init() {}

    // MARK: - Core Data stack

    private lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: R.string.databaseManager.persistentContainerName())
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError(R.string.databaseManager.unresolvedError(error.localizedDescription))
            }
        })
        return container
    }()

    private (set) lazy var context = persistentContainer.viewContext

    // MARK: - Core Data Saving support

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError(R.string.databaseManager.unresolvedError(nserror.localizedDescription))
            }
        }
    }
}
