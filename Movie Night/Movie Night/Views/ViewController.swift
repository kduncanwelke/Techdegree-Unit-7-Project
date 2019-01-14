//
//  ViewController.swift
//  Movie Night
//
//  Created by Kate Duncan-Welke on 1/2/19.
//  Copyright © 2019 Kate Duncan-Welke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets
    var actorsList = [Actor]()
    
    @IBOutlet weak var viewer1ChoicesLabel: UILabel!
    @IBOutlet weak var viewer2ChoicesLabel: UILabel!
    
    @IBOutlet weak var viewer1View: UIButton!
    @IBOutlet weak var viewer2View: UIButton!
    
    @IBOutlet weak var resultsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

    }
    
    // MARK: Custom functions
    
    func updateUI() {
        checkForCompleteSelection()
        
        // toggle UI based on selections
        if Viewer.hasViewer1Selected {
            viewer1View.setImage(UIImage(named: "bubble-selected"), for: .normal)
             viewer1ChoicesLabel.text = "Genres: \(Viewer.viewer1.preferredGenres.count) selected \nActors: \(Viewer.viewer1.preferredActors.count) selected \nMinimum rating: \(Viewer.viewer1.preferredMinimumRating)0%"
        } else {
            viewer1View.setImage(UIImage(named: "bubble-empty"), for: .normal)
             viewer1ChoicesLabel.text = "Selection incomplete - tap bubble to continue \n\nGenres: \(Viewer.viewer1.preferredGenres.count) selected \nActors: \(Viewer.viewer1.preferredActors.count) selected \nMinimum rating: \(Viewer.viewer1.preferredMinimumRating)0%"
        }
        
        if Viewer.hasViewer2Selected {
            viewer2View.setImage(UIImage(named: "bubble-selected"), for: .normal)
            viewer2ChoicesLabel.text = "Genres: \(Viewer.viewer2.preferredGenres.count) selected \nActors: \(Viewer.viewer2.preferredActors.count) selected \nMinimum rating: \(Viewer.viewer2.preferredMinimumRating)0%"
        } else {
            viewer2View.setImage(UIImage(named: "bubble-empty"), for: .normal)
            viewer2ChoicesLabel.text = "Selection incomplete - tap bubble to continue \n\nGenres: \(Viewer.viewer2.preferredGenres.count) selected \nActors: \(Viewer.viewer2.preferredActors.count) selected \nMinimum rating: \(Viewer.viewer2.preferredMinimumRating)0%"
        }
    }
    
    func checkForCompleteSelection() {
        // if any of the items are missing, set hasselected to false to prevent segue to results
        if Viewer.viewer1.preferredGenres.isEmpty || Viewer.viewer1.preferredActors.isEmpty || Viewer.viewer1.preferredMinimumRating == 0 {
            Viewer.hasViewer1Selected = false
        }
        
        if Viewer.viewer2.preferredGenres.isEmpty || Viewer.viewer2.preferredActors.isEmpty || Viewer.viewer2.preferredMinimumRating == 0 {
            Viewer.hasViewer2Selected = false
        }
    }
    
    func checkSubmission() -> Bool {
        // check that no items are empty - this can happen if a viewer makes initial selections, then goes back into the selection menu and backs out
        if Viewer.viewer1.preferredGenres.isEmpty || Viewer.viewer2.preferredGenres.isEmpty {
            showAlert(title: "Selection incomplete", message: "Please select at least one genre for each viewer")
            return false
        } else if Viewer.viewer1.preferredActors.isEmpty || Viewer.viewer2.preferredActors.isEmpty  {
            showAlert(title: "Selection incomplete", message: "Please select at least one actor for each viewer")
            return false
        } else if Viewer.viewer1.preferredMinimumRating == 0 || Viewer.viewer2.preferredMinimumRating == 0  {
            showAlert(title: "Selection incomplete", message: "Please select a minimum rating for each viewer")
            return false
        } else {
            return true
        }
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectForViewer1" {
            Viewer.currentlySelected = .viewer1
        }
        if segue.identifier == "selectForViewer2" {
            Viewer.currentlySelected = .viewer2
        }
    }
    
    
    // MARK: Actions
    
    @IBAction func view1ButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "selectForViewer1", sender: (Any).self)
    }
    
    @IBAction func viewer2ButtonPressed(_ sender: Any) {
         performSegue(withIdentifier: "selectForViewer2", sender: (Any).self)
    }
    
    
    @IBAction func resultsButtonPressed(_ sender: Any) {
        if checkSubmission() {
            performSegue(withIdentifier: "goToResults", sender: (Any).self)
        } else {
            return
        }
    }
    
}

