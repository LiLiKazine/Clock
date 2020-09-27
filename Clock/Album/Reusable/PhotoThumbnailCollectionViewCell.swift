
//
//  PhotoThumbnailCollectionViewCell.swift
//  Clock
//
//  Created by LiLi Kazine on 2020/8/29.
//  Copyright © 2020 LiLi Kazine. All rights reserved.
//

import UIKit

class PhotoThumbnailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var selectionMask: UIView!
    
    var indexPath: IndexPath?
    
    var assetIdentifier: String?
    
    func setup(_ thumbnail: UIImage?, _ indexPath: IndexPath?) {
        thumbnailImageView.image = thumbnail
        self.indexPath = indexPath
    }
    
    override var isSelected: Bool {
        get {
            !selectionMask!.isHidden
        }
        set {
            selectionMask!.isHidden = !newValue
        }
    }
    
}
