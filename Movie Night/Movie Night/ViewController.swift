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
    
    @IBOutlet weak var viewer1ChoicesLabel: UILabel!
    @IBOutlet weak var viewer2ChoicesLabel: UILabel!
    
    @IBOutlet weak var viewer1View: UIButton!
    @IBOutlet weak var viewer2View: UIButton!
    
    @IBOutlet weak var resultsButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateUI()
        
        resultsButton.isEnabled = false
    }
    
    // MARK: Custom functions
    
    func updateUI() {
        if Viewer.hasViewer1Selected {
            viewer1View.setImage(UIImage(named: "bubble-selected"), for: .normal)
            viewer1ChoicesLabel.text = "Genres: \(Viewer.viewer1.preferredGenres.count) selected \nActors: \(Viewer.viewer1.preferredActors.count) selected \nMinimum rating: \(Viewer.viewer1.preferredMinimumRating)0%"
        }
        if Viewer.hasViewer2Selected {
            viewer2View.setImage(UIImage(named: "bubble-selected"), for: .normal)
            viewer2ChoicesLabel.text = "Genres: \(Viewer.viewer2.preferredGenres.count) selected \nActors: \(Viewer.viewer2.preferredActors.count) selected \nMinimum rating: \(Viewer.viewer2.preferredMinimumRating)0%"
        }
        if Viewer.hasViewer1Selected && Viewer.hasViewer2Selected {
            resultsButton.isEnabled = true
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
    }
    
}

