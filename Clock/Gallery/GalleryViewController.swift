//
//  GalleryViewController.swift
//  Clock
//
//  Created by yingkelei on 2020/9/27.
//  Copyright © 2020 LiLi Kazine. All rights reserved.
//

import UIKit
import iOSPhotoEditor

class GalleryViewController: UIViewController {

    private var displayVC: PhotoCollectionViewController?
    private var previewVC: PreviewCollectionViewController?
    
    var albumManager: AlbumManager!
    var startIndexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(albumManager != nil && startIndexPath != nil, "Did not find album.")
    }
    
    private func handleAction(_ i: Int) {
        switch i {
        case 0:
            print("delete")
        case 1:
            print("edit")
            guard let image = displayVC?.currentImage else {
                return
            }
            let photoEditor = PhotoEditorViewController(nibName:"PhotoEditorViewController",bundle: Bundle(for: PhotoEditorViewController.self))
            
            //PhotoEditorDelegate
            photoEditor.photoEditorDelegate = self

            //The image to be edited
            photoEditor.image = image

            //Present the View Controller
            DispatchQueue.main.async {
                self.present(photoEditor, animated: true, completion: nil)
            }
        default:
            break
        }
    }
    
    @IBAction func unwindFromSheet(_ unwindSegue: UIStoryboardSegue) {
        if let sourceViewController = unwindSegue.source as? SheetViewController,
           let selected = sourceViewController.selected {
            handleAction(selected)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let photoVC = segue.destination as? PhotoCollectionViewController {
            photoVC.dataSource = albumManager.photos
            photoVC.indexPath = startIndexPath
            displayVC = photoVC
        }
        if let sheet = segue.destination as? SheetViewController {
            sheet.setOptions(["delete", "edit"])
        }
    }

}

extension GalleryViewController: PhotoEditorDelegate {
    func doneEditing(image: UIImage) {
        // the edited image
    }
        
    func canceledEditing() {
        print("Canceled")
    }
}
