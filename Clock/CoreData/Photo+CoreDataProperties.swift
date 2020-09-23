//
//  Photo+CoreDataProperties.swift
//  Clock
//
//  Created by yingkelei on 2020/9/23.
//  Copyright © 2020 LiLi Kazine. All rights reserved.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var content: Data?
    @NSManaged public var create_date: Date?
    @NSManaged public var thumbnail: Data?
    @NSManaged public var size: Int64
    @NSManaged public var name: String?
    @NSManaged public var relationship: Album?

}
