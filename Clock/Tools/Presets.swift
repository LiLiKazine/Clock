//
//  Presets.swift
//  Clock
//
//  Created by yingkelei on 2020/9/27.
//  Copyright © 2020 LiLi Kazine. All rights reserved.
//

import UIKit
import CoreData

let thumbnailSpacing: CGFloat = 1
 
let thumbnailSize: CGSize = {
     let num: CGFloat
     switch UIDevice.current.userInterfaceIdiom {
     case .pad:
         num = 5.0
     default:
         num = 3.0
     }
     let avaliableWidth = UIScreen.main.bounds.width - (num - 1) * thumbnailSpacing
     let length = avaliableWidth / num
     return CGSize(width: length, height: length)
 }()

func commitChanges(context: NSManagedObjectContext) {
    do {
        try context.save()
    } catch let err {
        print(err.localizedDescription)
    }
}
