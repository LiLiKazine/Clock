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
    
    private lazy var persistentContainer: NSPersistentContainer  = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer
    }()
    
    private lazy var fm: FolderManager = {
        let fm = FolderManager(persistentContainer)
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
    
    @IBAction func handleAdd(_ sender: UIBarButtonItem) {
        fm.save("test")
    }
    

    @IBSegueAction func toAlbum(coder: NSCoder, sender: Any?, segueIdentifier: String?) -> AlbumViewController? {
        return AlbumViewController(coder: coder)
    }
    
    @IBAction func unwindToMain(_ unwindSegue: UIStoryboardSegue) {
        // Use data from the view controller which initiated the unwind segue
    }
  
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fm.albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "folder", for: indexPath) as! FolderTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}

extension MainViewController: FolderManagerDelegate {
    func didInsert(album: Album, at indexPath: IndexPath) {
        folderTableView.reloadData()
    }
    
    func didDelete(album: Album, at indexPath: IndexPath) {
        
    }
    
    func didUpdate(album: Album, at indexPath: IndexPath) {
        
    }
    
    func didMove(album: Album, from: IndexPath, to: IndexPath) {
        
    }
    
    
}
