
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
    
    var assetIdentifier: String?
    
    func setup(_ thumbnail: UIImage?) {
        thumbnailImageView.image = thumbnail
    }
}
