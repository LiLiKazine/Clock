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
    
    let viewModel = LibraryViewModel()
    
    private static var cellSpacing: CGFloat = 4
    
    private static var cellSize: CGSize = {
        let num: CGFloat
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            num = 5.0
        default:
            num = 3.0
        }
        let avaliableWidth = UIScreen.main.bounds.width - (num - 1) * cellSpacing
        let length = avaliableWidth / num
        return CGSize(width: length, height: length)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension LibraryViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "libraryPhotoThumbnail", for: indexPath) as! PhotoThumbnailCollectionViewCell
        let asset = viewModel.asset(at: indexPath.row)
        cell.assetIdentifier = asset.localIdentifier
        PHImageManager.default().requestImage(for: asset, targetSize: Self.cellSize, contentMode: .aspectFill, options: nil) { (image, _) in
            if cell.assetIdentifier == asset.localIdentifier {
                cell.setup(image)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Self.cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Self.cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Self.cellSpacing
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photoCount
    }
    
}

