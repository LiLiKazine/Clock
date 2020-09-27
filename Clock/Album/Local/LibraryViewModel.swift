//
//  LibraryViewModel.swift
//  Clock
//
//  Created by LiLi Kazine on 2020/8/29.
//  Copyright © 2020 LiLi Kazine. All rights reserved.
//

import UIKit
import Photos
import Combine

class LibraryViewModel {
    
//    let dataSource = PassthroughSubject<[UIImage], Never>()
    
    var photoCount: Int {
        return imageResult.count
    }
    
    private lazy var imageResult: PHFetchResult<PHAsset> = {
        let options = PHFetchOptions()
               options.sortDescriptors = [.init(key: "creationDate", ascending: false)]
        return PHAsset.fetchAssets(with: .image, options: options)
    }()
    
    
    func asset(at index: Int) -> PHAsset {
        return imageResult.object(at: index)
    }
    
    func assets(at indexes: [Int]) -> [PHAsset] {
        let indexSet = IndexSet(indexes)
        return imageResult.objects(at: indexSet)
    }
}
