//
//  CDFriend+CoreDataProperties.swift
//  FriendFaceChallenge
//
//  Created by Zachary Frew on 11/23/19.
//  Copyright © 2019 Zach Frew. All rights reserved.
//
//

import Foundation
import CoreData


extension CDFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFriend> {
        return NSFetchRequest<CDFriend>(entityName: "CDFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var user: CDUser?

}
