//
//  FolderTableViewCell.swift
//  Clock
//
//  Created by LiLi Kazine on 2020/8/28.
//  Copyright © 2020 LiLi Kazine. All rights reserved.
//

import UIKit

class FolderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    
    var indexPath: IndexPath?
    
    func setup(_ cover: UIImage?, _ title: String?, _ num: Int?, _ indexPath: IndexPath) {
        coverImageView.image = cover ?? UIImage(named: "image_cover_placeholder")
        titleLabel.text = title ?? "Default Folder"
        numLabel.text = num?.description ?? "0"
        self.indexPath = indexPath
    }

}
