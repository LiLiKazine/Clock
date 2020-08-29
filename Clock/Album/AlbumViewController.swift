//
//  AlbumViewController.swift
//  Clock
//
//  Created by LiLi Kazine on 2020/8/28.
//  Copyright © 2020 LiLi Kazine. All rights reserved.
//

import UIKit
import Photos
import Combine

class AlbumViewController: UIViewController {

    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var importButton: UIButton!
    @IBOutlet weak var thumbnailCollection: UICollectionView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func importAction(_ sender: UIButton) {
        
    }

}

extension AlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoThumbnail", for: indexPath) as! PhotoThumbnailCollectionViewCell
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
}
