//
//  PhotoCollectionViewCell.swift
//  Clock
//
//  Created by yingkelei on 2020/9/28.
//  Copyright © 2020 LiLi Kazine. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    var identifier: String?
    
    @IBOutlet weak var photoIV: UIImageView!
    
    func setup(_ image: UIImage?) {
        photoIV.image = image
    }
    
}
