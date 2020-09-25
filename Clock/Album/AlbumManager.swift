//
//  AlbumManager.swift
//  Clock
//
//  Created by yingkelei on 2020/9/23.
//  Copyright © 2020 LiLi Kazine. All rights reserved.
//

import UIKit
import CoreData

class AlbumManager: NSObject {
    
    let album: Album
    
    private lazy var persistentContainer: NSPersistentContainer  = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer
    }()
    
    init(album: Album) {
        self.album = album
    }

}

