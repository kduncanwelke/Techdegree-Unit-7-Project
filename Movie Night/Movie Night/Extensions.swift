//
//  Extensions.swift
//  Movie Night
//
//  Created by Kate Duncan-Welke on 1/10/19.
//  Copyright © 2019 Kate Duncan-Welke. All rights reserved.
//

import Foundation
import UIKit

// add reusable alert functionality
extension UITableViewController {
    func showAlert(title: String, message: String, sendingViewController: UITableViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        sendingViewController.present(alert, animated: true, completion: nil)
    }
}

