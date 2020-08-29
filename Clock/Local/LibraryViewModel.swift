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
    
    let dataSource = PassthroughSubject<[UIImage], Never>()
    
    var photoCount: Int {
        return result.count
    }
    
    private let result: PHFetchResult<PHAsset>
    
    
    init() {
        let options = PHFetchOptions()
        options.sortDescriptors = [.init(key: "creationDate", ascending: false)]
        
        result = PHAsset.fetchAssets(with: .image, options: options)
    }
    
    func asset(at index: Int) -> PHAsset {
        return result.object(at: index)
    }
}
