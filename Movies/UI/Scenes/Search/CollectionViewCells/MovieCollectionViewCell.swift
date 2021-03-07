//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Praveen on 6/3/21.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell, Registrable {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet private(set) weak var posterImageView: UIImageView!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    var movie: Movie! {
        didSet {
            updateCell()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    private func updateCell() {
        titleLabel.text = movie.title
        posterImageView.kf.setImage(with: movie.posterURL, placeholder: UIImage(named: "placeholder")) { _ in
            
        }
    }
}
