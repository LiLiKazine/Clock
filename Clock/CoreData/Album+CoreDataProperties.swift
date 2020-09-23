//
//  Album+CoreDataProperties.swift
//  Clock
//
//  Created by yingkelei on 2020/9/23.
//  Copyright © 2020 LiLi Kazine. All rights reserved.
//
//

import Foundation
import CoreData


extension Album {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Album> {
        return NSFetchRequest<Album>(entityName: "Album")
    }

    @NSManaged public var name: String?
    @NSManaged public var create_date: Date?
    @NSManaged public var valid: Bool
    @NSManaged public var visiable: Bool
    @NSManaged public var pwd: String?
    @NSManaged public var relationship: NSOrderedSet?

}

// MARK: Generated accessors for relationship
extension Album {

    @objc(insertObject:inRelationshipAtIndex:)
    @NSManaged public func insertIntoRelationship(_ value: Photo, at idx: Int)

    @objc(removeObjectFromRelationshipAtIndex:)
    @NSManaged public func removeFromRelationship(at idx: Int)

    @objc(insertRelationship:atIndexes:)
    @NSManaged public func insertIntoRelationship(_ values: [Photo], at indexes: NSIndexSet)

    @objc(removeRelationshipAtIndexes:)
    @NSManaged public func removeFromRelationship(at indexes: NSIndexSet)

    @objc(replaceObjectInRelationshipAtIndex:withObject:)
    @NSManaged public func replaceRelationship(at idx: Int, with value: Photo)

    @objc(replaceRelationshipAtIndexes:withRelationship:)
    @NSManaged public func replaceRelationship(at indexes: NSIndexSet, with values: [Photo])

    @objc(addRelationshipObject:)
    @NSManaged public func addToRelationship(_ value: Photo)

    @objc(removeRelationshipObject:)
    @NSManaged public func removeFromRelationship(_ value: Photo)

    @objc(addRelationship:)
    @NSManaged public func addToRelationship(_ values: NSOrderedSet)

    @objc(removeRelationship:)
    @NSManaged public func removeFromRelationship(_ values: NSOrderedSet)

}
