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
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoIV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addGestureRecognizer(scrollView.panGestureRecognizer)
        if let pinch = scrollView.pinchGestureRecognizer {
            contentView.addGestureRecognizer(pinch)
        }
    }
    
    func setup(_ image: UIImage?) {
        photoIV.image = image
    }

}

extension PhotoCollectionViewCell: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoIV
    }
    
}
