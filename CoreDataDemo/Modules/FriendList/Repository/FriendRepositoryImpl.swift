//
//  FriendRepositoryImpl.swift
//  CoreDataDemo
//
//  Created by Ankit Verma on 27/07/23.
//

import Foundation

final class FriendRepositoryImpl: FriendRepository {

    // MARK: - Singleton

    static let shared = FriendRepositoryImpl()
    private init() {}

    // MARK: - Variables
    private let context = DatabaseManager.shared.context

    // MARK: - Protocol Functions

    func getFriends() -> [Friend] {
        let cdFriends = (try? context.fetch(CDFriend.fetchRequest())) ?? []
        return cdFriends.map({ $0.toFriend() })
    }

    func getFriend(withName name: String) -> Friend? {
        return nil
    }

    func addFriend(_ friend: Friend) -> Bool {
        _ = friend.toCDFriend(context: context)
        return saveContext()
    }

    func updateFriend(_ friend: Friend) -> Bool {
        let cdFriend = getCDFriend(id: friend.id)
        cdFriend?.updateValues(with: friend)
        return saveContext()
    }

    func deleteFriend(_ friend: Friend) -> Bool {
        guard let cdFriend = getCDFriend(id: friend.id) else {
            return false
        }
        context.delete(cdFriend)
        return saveContext()
    }

    // MARK: - Functions

    private func saveContext() -> Bool {
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }

    private func getCDFriend(id: UUID) -> CDFriend? {
        let request = CDFriend.fetchRequest()
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        request.predicate = predicate
        return try? context.fetch(request).first
    }
}
