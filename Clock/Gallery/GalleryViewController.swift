//
//  GalleryViewController.swift
//  Clock
//
//  Created by yingkelei on 2020/9/27.
//  Copyright © 2020 LiLi Kazine. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {

    private var displayVC: PhotoCollectionViewController?
    private var previewVC: PreviewCollectionViewController?
    
    var albumManager: AlbumManager!
    var startIndexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(albumManager != nil && startIndexPath != nil, "Did not find album.")
//        let photo = albumManager.photos.object(at: startIndexPath.row) as! Photo
//        let image = UIImage(data: photo.content!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let photoVC = segue.destination as? PhotoCollectionViewController {
            photoVC.dataSource = albumManager.photos
            displayVC = photoVC
        }
    }

}
