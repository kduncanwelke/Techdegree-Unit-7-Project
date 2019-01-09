//
//  RatingTableViewController.swift
//  Movie Night
//
//  Created by Kate Duncan-Welke on 1/8/19.
//  Copyright © 2019 Kate Duncan-Welke. All rights reserved.
//

import UIKit

class RatingTableViewController: UITableViewController {
    // passed from previous view
    var chosenGenres = [Genre]()
    var chosenActors = [Actor]()
    
    var selectedMinimumRating = Int()
    
    var viewer = Int()

    override func viewDidLoad() {
        super.viewDidLoad()

        print(chosenGenres)
        print(chosenActors)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ViewController {
            let selectedItem = tableView.indexPathsForSelectedRows
            guard let selection = selectedItem else { return }
            let item = selection[0]
            selectedMinimumRating = Rating.ratingPercentages[item.row].value
            
            let destinationViewController = segue.destination as? ViewController
            if viewer == 1 {
                destinationViewController?.viewer1.preferredGenres.append(contentsOf: chosenGenres)
                destinationViewController?.viewer1.preferredActors.append(contentsOf: chosenActors)
                destinationViewController?.viewer1.preferredMinimumRating = selectedMinimumRating
            } else if viewer == 2 {
                destinationViewController?.viewer2.preferredGenres.append(contentsOf: chosenGenres)
                destinationViewController?.viewer2.preferredActors.append(contentsOf: chosenActors)
                destinationViewController?.viewer2.preferredMinimumRating = selectedMinimumRating
            }
        }
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToActors", sender: Any?.self)
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindAfterSubmit", sender: Any?.self)
    }
    

}
