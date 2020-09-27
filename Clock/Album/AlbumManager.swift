//
//  AlbumManager.swift
//  Clock
//
//  Created by yingkelei on 2020/9/23.
//  Copyright © 2020 LiLi Kazine. All rights reserved.
//

import UIKit
import CoreData
import Photos

protocol AlbumManagerDelegate: class {
    func didImportPhotos(assets: [PHAsset])
    
}

class AlbumManager: NSObject {
    
    weak var delegate: AlbumManagerDelegate?
    
    var photos: NSOrderedSet {
        album.relationship ?? NSOrderedSet()
    }
    
    private let album: Album
    private let taskGroup: DispatchGroup
    
    private lazy var persistentContainer: NSPersistentContainer  = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer
    }()
    
    init(album: Album) {
        self.album = album
        taskGroup = DispatchGroup()
    }
    
    func importPhotos(_ assets: [PHAsset]) {
        for asset in assets {
            save(asset, enqueue: true, commit: false)
        }
        taskGroup.notify(queue: .global()) { [weak self] in
            if let context = self?.persistentContainer.viewContext {
                commitChanges(context: context)
            }
            DispatchQueue.main.async {    
                self?.delegate?.didImportPhotos(assets: assets)
            }
        }
    }
    
    func save(_ asset: PHAsset, enqueue: Bool = false, commit: Bool = true) {
        taskGroup.enter()
        let managedContext = persistentContainer.viewContext
        let photo = Photo(context: managedContext)
        photo.create_date = Date()
        photo.name = asset.localIdentifier
        photo.relationship = album
        let requestGroup = DispatchGroup()
        let fastOption = PHImageRequestOptions()
        fastOption.deliveryMode = .fastFormat
        fastOption.isSynchronous = false
        fastOption.resizeMode = .fast
        requestGroup.enter()
        let _ = PHImageManager.default().requestImage(for: asset, targetSize: thumbnailSize, contentMode: .aspectFill, options: fastOption) { (result, _) in
            if let image = result, let data = image.jpegData(compressionQuality: 0) {
                photo.thumbnail = data
            }
            requestGroup.leave()
        }
        let bestOption = PHImageRequestOptions()
        bestOption.deliveryMode = .highQualityFormat
        bestOption.isSynchronous = false
        bestOption.resizeMode = .none
        requestGroup.enter()
        let _ = PHImageManager.default().requestImage(for: asset, targetSize: .init(), contentMode: .default, options: bestOption) { (result, info) in
            if let image = result, let data = image.pngData() {
                photo.content = data
                photo.size = Int64(data.count)
            }
            requestGroup.leave()
        }
        requestGroup.notify(queue: .global()) {
            self.taskGroup.leave()
        }
        if commit {
            commitChanges(context: managedContext)
        }
    }
    
}

