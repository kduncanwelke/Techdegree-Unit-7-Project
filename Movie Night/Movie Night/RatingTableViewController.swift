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
        
        print(Viewer.viewer1)
        print(Viewer.viewer2)
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

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindAfterSubmit" {
            let selectedItem = tableView.indexPathsForSelectedRows
            guard let selection = selectedItem else { return }
            let item = selection[0]
           
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
            switch Viewer.currentlySelected {
            case .viewer1:
                Viewer.viewer1.preferredActors.removeAll()
                Viewer.viewer1.preferredMinimumRating = 0
            case .viewer2:
                Viewer.viewer2.preferredActors.removeAll()
                Viewer.viewer2.preferredMinimumRating = 0
            default:
                break // should not be able to be none, add error handling if is
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
