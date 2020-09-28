//
//  PhotoCollectionViewController.swift
//  Clock
//
//  Created by yingkelei on 2020/9/28.
//  Copyright © 2020 LiLi Kazine. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class PhotoCollectionViewController: UICollectionViewController {

    var dataSource = NSOrderedSet()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        if let photo = dataSource.object(at: indexPath.row) as? Photo,
           let raw = photo.content {
            cell.identifier = photo.name
//            DispatchQueue.global().async {
                let image = UIImage(data: raw)
//                DispatchQueue.main.async {
//                    if cell.identifier == photo.name {
                        cell.setup(image)
//                    }
//                }
//            }
        }
        return cell
    }
}

extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insets = collectionView.contentInset
        let size = collectionView.bounds.size
        let width = size.width - insets.left - insets.right
        let height = size.height - insets.top - insets.bottom
        return .init(width: width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hidden = navigationController?.isNavigationBarHidden ?? false
        navigationController?.setNavigationBarHidden(!hidden, animated: true)
        collectionView.reloadItems(at: [indexPath])
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
