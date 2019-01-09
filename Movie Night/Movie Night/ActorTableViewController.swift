//
//  ActorTableViewController.swift
//  Movie Night
//
//  Created by Kate Duncan-Welke on 1/7/19.
//  Copyright © 2019 Kate Duncan-Welke. All rights reserved.
//

import UIKit

class ActorTableViewController: UITableViewController {
    // passed from previous view
    var chosenGenres = [Genre]()
    
    var actorsList = [Actor]()
    var selectedActors = [Actor]()
    
    var selectedCount = 0
    
    var viewer = Int()

    override func viewDidLoad() {
        super.viewDidLoad()

        selectedActors.removeAll()
        
        DataManager<Actor>.fetch() { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.actorsList = response
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actorsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "actorCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = actorsList[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if selectedCount < 3 {
            selectedCount += 1
            return indexPath
        } else {
            // prevent selection of more than five items
            print("list maxed out at 3")
            tableView.cellForRow(at: indexPath)?.isSelected = false
            tableView.cellForRow(at: indexPath)?.selectionStyle = .none
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if selectedCount > 0 {
            selectedCount -= 1
        }
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
        let selectedItems = tableView.indexPathsForSelectedRows
        guard let selections = selectedItems else { return }
        for item in selections {
            selectedActors.append(actorsList[item.row])
        }
        
        if let navController = segue.destination as? UINavigationController {
            if let child = navController.topViewController as? RatingTableViewController {
                child.chosenActors = selectedActors
                child.chosenGenres = chosenGenres
                child.viewer = viewer
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToGenre", sender: Any?.self)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToRatingSelection", sender: Any?.self)
    }

}
    
