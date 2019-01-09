//
//  ViewController.swift
//  Movie Night
//
//  Created by Kate Duncan-Welke on 1/2/19.
//  Copyright © 2019 Kate Duncan-Welke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var chosenGenres = [Genre]()
    var chosenActors = [Actor]()
    var chosenMinimumRating = Int()
    
    var viewer1 = Viewer(preferredGenres: [], preferredActors: [], preferredMinimumRating: 0)
    var viewer2 = Viewer(preferredGenres: [], preferredActors: [], preferredMinimumRating: 0)
    
    var viewer = Int()
    
    @IBOutlet weak var viewer1View: UIButton!
    @IBOutlet weak var viewer2View: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(viewer1)
        print(viewer2)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navController = segue.destination as? UINavigationController {
            if let child = navController.topViewController as? GenreTableViewController {
                if segue.identifier == "selectForViewer1" {
                    child.viewer = 1
                } else if segue.identifier == "selectForViewer2" {
                    child.viewer = 2
                }
            }
        }
    }
    
    // MARK: IBOutlets
    
    @IBAction func view1ButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "selectForViewer1", sender: (Any).self)
    }
    
    
    @IBAction func viewer2ButtonPressed(_ sender: Any) {
         performSegue(withIdentifier: "selectForViewer2", sender: (Any).self)
    }
    
}

