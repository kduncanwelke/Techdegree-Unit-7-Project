//
//  DetailViewController.swift
//  Movie Night
//
//  Created by Kate Duncan-Welke on 1/11/19.
//  Copyright © 2019 Kate Duncan-Welke. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: Variables
    
    var selectedFilm: MovieSearch?
    var genres = [String]()
    var genreList = [Genre]()
    
    // MARK: Outlets
    
    @IBOutlet weak var artwork: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // check that selection was passed from previous view
        guard let selection = selectedFilm else { return }
        
        // assign values to labels
        artwork.getImage(partialURL: selection.posterPath)
        titleLabel.text = selection.title
        voteAverage.text = "\(selection.voteAverage)"
        releaseDate.text = selection.releaseDate
        overview.text = selection.overview
        
        // retrieve genre information
        DataManager<Genre>.getData() { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.genreList = response
                    
                    // loop through current movie genres and genre list to generate genre names
                    for genreID in selection.genreIds {
                        for genre in self.genreList {
                            if genreID == genre.id {
                                self.genres.append(genre.name)
                                
                                // then assign to label
                                let joined = self.genres.joined(separator: ", ")
                                self.genresLabel.text = joined
                            }
                        }
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    switch error {
                    case Errors.networkError:
                        self.showAlert(title: "Networking failed", message: "\(Errors.networkError.localizedDescription)")
                    default:
                        self.showAlert(title: "Networking failed", message: "\(error.localizedDescription)")
                    }
                }
            }
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
