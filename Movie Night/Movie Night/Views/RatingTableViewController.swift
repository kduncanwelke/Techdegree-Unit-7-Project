//
//  RatingTableViewController.swift
//  Movie Night
//
//  Created by Kate Duncan-Welke on 1/8/19.
//  Copyright © 2019 Kate Duncan-Welke. All rights reserved.
//

import UIKit

class RatingTableViewController: UITableViewController {
    
    var selected = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Rating.ratingPercentages.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ratingCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = Rating.ratingPercentages[indexPath.row].title
        return cell
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindAfterSubmit" {
            let selectedItem = tableView.indexPathsForSelectedRows
            guard let selection = selectedItem else { return }
            let item = selection[0]
            // assign current selection to viewer rating
           
            switch Viewer.currentlySelected {
            case .viewer1:
                Viewer.viewer1.preferredMinimumRating = Rating.ratingPercentages[item.row].value
                Viewer.hasViewer1Selected = true
            case .viewer2:
                Viewer.viewer2.preferredMinimumRating = Rating.ratingPercentages[item.row].value
                Viewer.hasViewer2Selected = true
            default:
                break // should not be able to be none, add error handling if is
            }
        }
        
        if segue.identifier == "unwindToActors" {
            // wipe selections if going back to prevent duplication
            switch Viewer.currentlySelected {
            case .viewer1:
                Viewer.viewer1.preferredActors.removeAll()
                Viewer.viewer1.preferredMinimumRating = 0
            case .viewer2:
                Viewer.viewer2.preferredActors.removeAll()
                Viewer.viewer2.preferredMinimumRating = 0
            default:
                break 
            }
        }
    }
    
    // MARK: Actions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToActors", sender: Any?.self)
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        let selectedItem = tableView.indexPathsForSelectedRows
        guard selectedItem != nil else {
            showAlert(title: "Missing information", message: "Please make a selection")
            return
        }
        
        performSegue(withIdentifier: "unwindAfterSubmit", sender: Any?.self)
    }

}
