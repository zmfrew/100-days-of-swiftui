//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Zachary Frew on 11/19/19.
//  Copyright © 2019 Zach Frew. All rights reserved.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?
    
    public var wrappedName: String {
        name ?? "Unknown Candy"
    }
}
