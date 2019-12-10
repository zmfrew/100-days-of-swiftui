//
//  CDUser+CoreDataProperties.swift
//  FriendFaceChallenge
//
//  Created by Zachary Frew on 11/23/19.
//  Copyright © 2019 Zach Frew. All rights reserved.
//
//

import Foundation
import CoreData


extension CDUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: "CDUser")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: String?
    @NSManaged public var friends: NSSet?

    var friendsArray: [CDFriend] {
        (friends as? Set<CDFriend> ?? []).sorted { $0.name ?? "" > $1.name ?? "" }
    }
}

// MARK: Generated accessors for friends
extension CDUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CDFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CDFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}
