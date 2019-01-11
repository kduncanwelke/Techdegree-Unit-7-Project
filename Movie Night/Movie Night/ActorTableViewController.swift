//
//  ActorTableViewController.swift
//  Movie Night
//
//  Created by Kate Duncan-Welke on 1/7/19.
//  Copyright © 2019 Kate Duncan-Welke. All rights reserved.
//

import UIKit

class ActorTableViewController: UITableViewController {

    // MARK: Variables
    
    var actorsList = [Actor]()
    var selectedCount = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Viewer.viewer1)
        print(Viewer.viewer2)
        
        DataManager<Actor>.fetch() { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.actorsList = response
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.showAlert(title: "Networking failed", message: "Network error: \(error.localizedDescription)")
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
            // prevent selection of more than three items
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRatingSelection" {
            let selectedItems = tableView.indexPathsForSelectedRows
            guard let selections = selectedItems else { return }
            
            switch Viewer.currentlySelected {
            case .viewer1:
                for item in selections {
                    Viewer.viewer1.preferredActors.append(actorsList[item.row])
                }
            case .viewer2:
                for item in selections {
                    Viewer.viewer2.preferredActors.append(actorsList[item.row])
                }
            default:
                break // should not be able to be none, add error handling if is
            }
        }
        
        if segue.identifier == "unwindToGenre" {
            switch Viewer.currentlySelected {
            case .viewer1:
                Viewer.viewer1.preferredGenres.removeAll()
                Viewer.viewer1.preferredActors.removeAll()
            case .viewer2:
                Viewer.viewer2.preferredGenres.removeAll()
                Viewer.viewer2.preferredActors.removeAll()
            default:
                break // should not be able to be none, add error handling if is
            }
        }
    }
    
    
    // MARK: Actions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToGenre", sender: Any?.self)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if selectedCount > 0 {
            performSegue(withIdentifier: "goToRatingSelection", sender: Any?.self)
        } else {
            showAlert(title: "Missing information", message: "Please select at least one item")
        }
    }

}
    
