//
//  PopViewController.swift
//  Clock
//
//  Created by yingkelei on 2020/9/25.
//  Copyright © 2020 LiLi Kazine. All rights reserved.
//

import UIKit
import Combine

class PopViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
        confirmButton.isEnabled = false
    }

    @IBAction func editingChanged(_ sender: UITextField) {
        self.confirmButton.isEnabled = sender.text?.isEmpty == false
    }
    
}

extension PopViewController: UITextFieldDelegate {
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
