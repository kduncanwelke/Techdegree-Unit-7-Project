//
//  ViewController.swift
//  Movie Night
//
//  Created by Kate Duncan-Welke on 1/2/19.
//  Copyright © 2019 Kate Duncan-Welke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
        /*DataManager<Genre>.fetch() { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
       
        DataManager<Actor>.fetch() { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }*/
    }
    
    // MARK: IBOutlets
    
    @IBAction func selectDetails(_ sender: UIButton) {
        performSegue(withIdentifier: "makeSelections", sender: (Any).self)
    }
    

}

