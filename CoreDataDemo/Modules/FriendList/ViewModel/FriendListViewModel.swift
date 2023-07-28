//
//  FriendListViewModel.swift
//  CoreDataDemo
//
//  Created by Ankit Verma on 27/07/23.
//

class FriendListViewModel {

    // MARK: - Variables

    private (set) var friends = Dynamic([Friend]())
    private let friendsRepository: FriendRepository

    // MARK: - Initializer

    init(friendsRepository: FriendRepository = FriendRepositoryImpl.shared) {
        self.friendsRepository = friendsRepository
        getFriends()
    }

    // MARK: - Functions

    func getFriends() {
        friends.value = friendsRepository.getFriends()
    }

    func addFriend(_ friend: Friend) {
        if friendsRepository.addFriend(friend) {
            getFriends()
        }
    }

    func updateFriend(_ friend: Friend) {
        if friendsRepository.updateFriend(friend) {
            getFriends()
        }
    }

    func deteleFriend(_ friend: Friend) {
        if friendsRepository.deleteFriend(friend) {
            getFriends()
        }
    }
}
