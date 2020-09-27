//
//  GalleryViewController.swift
//  Clock
//
//  Created by yingkelei on 2020/9/27.
//  Copyright © 2020 LiLi Kazine. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var defaultIV: UIImageView!
    
    var albumManager: AlbumManager!
    var startIndexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(albumManager != nil && startIndexPath != nil, "Did not find album.")
        let photo = albumManager.photos.object(at: startIndexPath.row) as! Photo
        let image = UIImage(data: photo.content!)
        defaultIV.image = image
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
