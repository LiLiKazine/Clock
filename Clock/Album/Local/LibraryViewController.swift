//
//  LibraryViewController.swift
//  Clock
//
//  Created by LiLi Kazine on 2020/8/29.
//  Copyright © 2020 LiLi Kazine. All rights reserved.
//

import UIKit
import Photos

class LibraryViewController: UIViewController {
    
    @IBOutlet weak var assetCollection: UICollectionView!
    @IBOutlet weak var importItem: UIBarButtonItem!
    
    var selectedPhotos: [PHAsset] {
        var assets: [PHAsset] = []
        if let indexes = assetCollection.indexPathsForSelectedItems {
            assets = viewModel.assets(at: indexes.map{ $0.row})
        }
        return assets
    }
    
    let viewModel = LibraryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assetCollection.allowsSelection = true
        assetCollection.allowsMultipleSelection = true
    }
    
    private func cellTapped() {
        let indexPathes = assetCollection.indexPathsForSelectedItems ?? []
        importItem.isEnabled = indexPathes.count > 0
    }
}

extension LibraryViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellTapped()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        cellTapped()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "libraryPhotoThumbnail", for: indexPath) as! PhotoThumbnailCollectionViewCell
        let asset = viewModel.asset(at: indexPath.row)
        cell.assetIdentifier = asset.localIdentifier
        PHImageManager.default().requestImage(for: asset, targetSize: thumbnailSize, contentMode: .aspectFill, options: nil) { (image, _) in
            if cell.assetIdentifier == asset.localIdentifier {
                cell.setup(image)
            }
        }
        return cell
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
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photoCount
    }
    
}

