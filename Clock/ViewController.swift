//
//  ViewController.swift
//  Clock
//
//  Created by LiLi Kazine on 2020/8/25.
//  Copyright © 2020 LiLi Kazine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timePlateView: TimePlateView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    @IBAction func dismissAction(_ sender: UIButton) {
        performSegue(withIdentifier: "test", sender: self)
    }
}


