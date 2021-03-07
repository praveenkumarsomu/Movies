//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Praveen on 6/3/21.
//

import UIKit
import Kingfisher

/// Collection view cell to display search result in SearchViewController
class MovieCollectionViewCell: UICollectionViewCell, Registrable {
    // MARK:- Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet private(set) weak var posterImageView: UIImageView!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    
    /// Movie object to display data
    var movie: Movie! {
        didSet {
            updateCell()
        }
    }
    /// Update data this function is called each time new data is assigned to `Movie`
    private func updateCell() {
        titleLabel.text = movie.title
        posterImageView.kf.setImage(with: movie.posterURL, placeholder: UIImage(named: "placeholder")) { _ in
        }
    }
}
