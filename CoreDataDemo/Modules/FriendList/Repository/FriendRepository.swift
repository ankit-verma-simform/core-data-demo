//
//  FriendRepository.swift
//  CoreDataDemo
//
//  Created by Ankit Verma on 27/07/23.
//

import Foundation

protocol FriendRepository {
    func getFriends() -> [Friend]
    func getFriend(withName name: String) -> Friend?
    func addFriend(_ friend: Friend) -> Bool
    func updateFriend(_ friend: Friend) -> Bool
    func deleteFriend(_ friend: Friend) -> Bool
}
