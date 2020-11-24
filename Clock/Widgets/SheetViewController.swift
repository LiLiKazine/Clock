//
//  SheetViewController.swift
//  Clock
//
//  Created by yingkelei on 2020/9/28.
//  Copyright © 2020 LiLi Kazine. All rights reserved.
//

import UIKit

class SheetViewController: UIViewController {

    @IBOutlet weak var optionTable: UITableView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    
    var selected: Int?
    
    private var options: [String] = []
    
    private var height: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableHeightConstraint.constant = height
    }
    
    func setOptions(_ options: [String]) {
        self.options = options
        height = CGFloat(64 * options.count)
    }
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        selected = nil
        performSegue(withIdentifier: "unwind", sender: self)
    }
    
}

extension SheetViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = indexPath.row
        performSegue(withIdentifier: "unwind", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

extension SheetViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let locate = touch.location(in: view)
        return !optionTable.frame.contains(locate)
    }
}

