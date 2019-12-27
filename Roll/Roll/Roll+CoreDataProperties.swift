//
//  Roll+CoreDataProperties.swift
//  Roll
//
//  Created by Zachary Frew on 12/27/19.
//  Copyright © 2019 Zach Frew. All rights reserved.
//
//

import Foundation
import CoreData


extension Roll {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Roll> {
        return NSFetchRequest<Roll>(entityName: "Roll")
    }

    @NSManaged public var date: Date
    @NSManaged public var id: UUID
    @NSManaged public var result: Int16
    @NSManaged public var diceSideNumber: Int16

    var displayDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: self.date)
    }
}
