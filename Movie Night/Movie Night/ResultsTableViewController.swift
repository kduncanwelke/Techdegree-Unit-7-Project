//
//  ResultsTableViewController.swift
//  Movie Night
//
//  Created by Kate Duncan-Welke on 1/9/19.
//  Copyright © 2019 Kate Duncan-Welke. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    var resultsList = [MovieSearch]()

    override func viewDidLoad() {
        super.viewDidLoad()

        DataManager<MovieSearch>.getData() { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.resultsList = response
                    if self.resultsList.isEmpty {
                        self.showAlert(title: "No results found", message: "Please modify your selections and try again")
                    } else {
                    self.tableView.reloadData()
                    }
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
       return resultsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = resultsList[indexPath.row].title
        cell.imageView?.getImage(partialURL: resultsList[indexPath.row].posterPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "viewDetails", sender: Any?.self)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewDetails" {
            if let destinationViewController = segue.destination as? DetailsViewController {
                guard let selection = tableView.indexPathForSelectedRow else { return }
                
                destinationViewController.selectedFilm = resultsList[selection.row]
            }
        }
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "return", sender: Any?.self)
    }
}
