//
//  MainViewController.swift
//  Clock
//
//  Created by LiLi Kazine on 2020/8/26.
//  Copyright © 2020 LiLi Kazine. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController {

    @IBOutlet weak var MaskView: UIView!
    @IBOutlet weak var folderTableView: UITableView!
    

    
    private lazy var fm: FolderManager = {
        let fm = FolderManager()
        fm.delegate = self
        fm.fetch()
        return fm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100), execute: {
//            self.performSegue(withIdentifier: "lock", sender: self)
//        })
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        folderTableView.reloadData()
    }

    @IBSegueAction func toAlbum(coder: NSCoder, sender: FolderTableViewCell?, segueIdentifier: String?) -> AlbumViewController? {
        guard let indexPath = sender?.indexPath else {
            return nil
        }
        let vc = AlbumViewController(coder: coder)
        vc?.album = fm.albums[indexPath.row]
        return vc
    }
    
    @IBAction func unwindToMain(_ unwindSegue: UIStoryboardSegue) {
        // Use data from the view controller which initiated the unwind segue
        if let from = unwindSegue.source as? PopViewController,
            let name = from.nameTextField.text {
            fm.save(name)
        }
    }
  
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fm.albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "folder", for: indexPath) as! FolderTableViewCell
        let album = fm.albums[indexPath.row]
        cell.setup(nil, album.name, nil, indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let handler: (UIContextualAction, UIView, @escaping (Bool) -> Void) -> Void = { [weak self] _,_,completion in
            guard let album = self?.fm.albums[indexPath.row] else {
                completion(false)
                return
            }
            self?.fm.delete(album)
            completion(true)
        }
        let action = UIContextualAction(style: .destructive, title: "Delete", handler: handler)
        let config = UISwipeActionsConfiguration(actions: [action])
        return config
    }
    
}

extension MainViewController: FolderManagerDelegate {
    func didInsert(album: Album, at indexPath: IndexPath) {
        folderTableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func didDelete(album: Album, at indexPath: IndexPath) {
        folderTableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func didUpdate(album: Album, at indexPath: IndexPath) {
        
    }
    
    func didMove(album: Album, from: IndexPath, to: IndexPath) {
        
    }
    
    
}
