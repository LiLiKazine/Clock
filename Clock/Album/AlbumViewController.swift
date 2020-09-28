//
//  AlbumViewController.swift
//  Clock
//
//  Created by LiLi Kazine on 2020/8/28.
//  Copyright © 2020 LiLi Kazine. All rights reserved.
//

import UIKit
import Photos
import CoreData

class AlbumViewController: UIViewController {

    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var importButton: UIButton!
    @IBOutlet weak var thumbnailCollection: UICollectionView!
    @IBOutlet weak var rightItem: UIBarButtonItem!
    
    var album: Album!
    
    private var editMode: Bool = false
    
    private lazy var manager: AlbumManager = {
        let manager = AlbumManager(album: album)
        manager.delegate = self
        return manager
    }()
    
    private lazy var persistentContainer: NSPersistentContainer  = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(album != nil, "Did not find album.");
        thumbnailCollection.allowsSelection = true
        thumbnailCollection.allowsMultipleSelection = true
        updateAlbum()
    }
    
    func updateAlbum() {
        setEditMode(false)
        importButton.isHidden = manager.photos.count > 0
//        for ip in thumbnailCollection.indexPathsForSelectedItems ?? [] {
//            thumbnailCollection.deselectItem(at: ip, animated: false)
//        }
        thumbnailCollection.reloadData()
    }
    
    func setEditMode(_ flag: Bool) {
        editMode = flag
        let style: UIBarButtonItem.SystemItem = flag ? .action : .add
        let item = UIBarButtonItem(barButtonSystemItem: style, target: self, action: #selector(handleRightItem(_:)))
        item.tintColor = UIColor.white
        navigationItem.setRightBarButton(item, animated: true)
    }
    
    @objc func handleRightItem(_ sender: UIBarButtonItem) {
        if editMode {
            performSegue(withIdentifier: "showSheet", sender: self)
        } else {
            performSegue(withIdentifier: "showLibrary", sender: self)
        }
        
    }
    
    @IBAction func unwindFromSheet(_ unwindSegue: UIStoryboardSegue) {
        if let sourceViewController = unwindSegue.source as? SheetViewController {
            if let _ = sourceViewController.selected,
               let indexPathes = thumbnailCollection.indexPathsForSelectedItems {
                manager.delete(indexPathes)
            }
            updateAlbum()
        }
    }
    
    @IBAction func unwindToAlbum(_ unwindSegue: UIStoryboardSegue) {
        if let sourceViewController = unwindSegue.source as? LibraryViewController {
            let assets = sourceViewController.selectedPhotos
            manager.importPhotos(assets)
        }
    }
    
    @IBSegueAction func toGallery(coder: NSCoder, sender: PhotoThumbnailCollectionViewCell?, segueIdentifier: String?) -> GalleryViewController? {
        let vc = GalleryViewController(coder: coder)
        vc?.albumManager = manager
        vc?.startIndexPath = sender?.indexPath ?? IndexPath(row: 0, section: 0)
        return vc
    }
    
    @IBAction func handlePress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .changed && !editMode {
            let point = sender.location(in: thumbnailCollection)
            if let indexPath = thumbnailCollection.indexPathForItem(at: point) {
                setEditMode(true)
                thumbnailCollection.selectItem(at: indexPath, animated: true, scrollPosition: [])
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? SheetViewController {
            dest.setOptions(["delete"])
        }
    }
}

extension AlbumViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if !editMode, let sender = collectionView.cellForItem(at: indexPath) {
            performSegue(withIdentifier: "showGallery", sender: sender)
        }
        return editMode
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoThumbnail", for: indexPath) as! PhotoThumbnailCollectionViewCell
        if let photo = manager.photos.object(at: indexPath.row) as? Photo,
            let rawData = photo.thumbnail,
            let image = UIImage(data: rawData) {
            cell.setup(image, indexPath)
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return thumbnailSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return thumbnailSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return thumbnailSpacing
    }
        
}

extension AlbumViewController: AlbumManagerDelegate {
    func didImportPhotos(assets: [PHAsset]) {
        updateAlbum()
    }
    
    func didDeletePhotos(at indexPathes: [IndexPath]) {
        thumbnailCollection.deleteItems(at: indexPathes)
    }
}
