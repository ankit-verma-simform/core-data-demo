//
//  CDFriend+CoreDataClass.swift
//  CoreDataDemo
//
//  Created by Ankit Verma on 27/07/23.
//
//

import Foundation
import CoreData

@objc(CDFriend)
public class CDFriend: NSManagedObject {
    func toFriend() -> Friend {
        Friend(id: id ?? UUID(),
               name: name ?? "")
    }

    func updateValues(with friend: Friend) {
        id = friend.id
        name = friend.name
    }
}

extension Friend {
    func toCDFriend(context: NSManagedObjectContext) -> CDFriend {
        let cdFriend = CDFriend(context: context)
        cdFriend.id = id
        cdFriend.name = name
        return cdFriend
    }
}
