//
//  MovieDetailsCollectionViewCell.swift
//  Movies
//
//  Created by Praveen on 7/3/21.
//

import UIKit
import Kingfisher

class MovieDetailsCollectionViewCell: UICollectionViewCell, Registrable {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var imdbRating: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    var movieDetails: MovieDetailsModel! {
        didSet {
            updateData()
        }
    }
    func updateData() {
        posterImage.kf.setImage(with: movieDetails.posterURL, placeholder: UIImage(named: "placeholder")) { _ in
        }
        movieTitleLabel.text = movieDetails.title
        plotLabel.text = movieDetails.plot
        actorsLabel.text = movieDetails.actors
        imdbRating.text = "Imdb Rating: \(movieDetails.imdbRating ?? "")"
    }
    
}
