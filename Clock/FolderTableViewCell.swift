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
    
    func setup(_ cover: UIImage?, _ title: String?, _ num: Int?) {
        coverImageView.image = cover
        titleLabel.text = title
        numLabel.text = num?.description
    }

}
