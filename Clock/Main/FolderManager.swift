//
//  FolderManager.swift
//  Clock
//
//  Created by yingkelei on 2020/9/23.
//  Copyright © 2020 LiLi Kazine. All rights reserved.
//

import UIKit
import CoreData

protocol FolderManagerDelegate: class {
    func didInsert(album: Album, at indexPath: IndexPath)
    func didDelete(album: Album, at indexPath: IndexPath)
    func didUpdate(album: Album, at indexPath: IndexPath)
    func didMove(album: Album, from: IndexPath, to: IndexPath)
}

class FolderManager: NSObject {
    
    weak var delegate: FolderManagerDelegate?
    
    var albums: [Album] {
        self.fetchedResultsController.fetchedObjects ?? []
    }
    
    private let persistentContainer: NSPersistentContainer
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Album> = {
        let managedContext = persistentContainer.viewContext
        let request: NSFetchRequest<Album> = Album.fetchRequest()
        let sort = NSSortDescriptor(keyPath: \Album.create_date, ascending: true)
        request.sortDescriptors = [sort]
        
        let res = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil);
        res.delegate = self
        return res
    }()
    
    init(_ container: NSPersistentContainer) {
        self.persistentContainer = container
    }
    
    func fetch() {
        do {
            try fetchedResultsController.performFetch()
        } catch let err {
            print(err.localizedDescription)
        }
        
        //        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Album")
        //
        //        do {
        //            albums = try managedContext.fetch(fetchRequest)
        //        } catch let err {
        //            print(err.localizedDescription)
        //        }
    }
    
    func save(_ name: String, _ visiable: Bool = true, _ pwd: String? = nil) {
        
        let managedContext = persistentContainer.viewContext
        let album = Album(context: managedContext)
        album.name = name
        album.create_date = Date()
        album.valid = true
        album.visiable = visiable
        album.pwd = pwd
        
        do {
            try managedContext.save()
        } catch let err {
            print(err.localizedDescription)
        }
        //        guard let entity = NSEntityDescription.entity(forEntityName: "Album", in: managedContext) else {
        //            fatalError("No entity named \"Album\".")
        //        }
        //        let album = NSManagedObject(entity: entity, insertInto: managedContext)
        //        album.setValue("test", forKeyPath: "name");
        //        do {
        //            try managedContext.save()
        //            albums.append(album);
        //        } catch let err {
        //            print(err.localizedDescription)
        //        }
        
    }
}

extension FolderManager: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        guard let album = anObject as? Album else {
            return
        }
        switch type {
        case .insert:
            if let ip = newIndexPath {
                delegate?.didInsert(album: album, at: ip)
            }
        case .delete:
            if let ip = indexPath {
                delegate?.didDelete(album: album, at: ip)
            }
        case .move:
            if let from = indexPath, let to = newIndexPath {
                delegate?.didMove(album: album, from: from, to: to)
            }
            break
        case .update:
            if let ip = indexPath {
                delegate?.didUpdate(album: album, at: ip)
            }
        @unknown default:
            break
        }
        
    }
    
}

