//
//  FooterLoaderCollectionReusableView.swift
//  Movies
//
//  Created by Praveen on 6/3/21.
//

import UIKit

/// Collection view reusable view to display Pagination loader at the bottom of the SearchViewController
class FooterLoaderCollectionReusableView: UICollectionReusableView, Registrable {
    @IBOutlet private(set) weak var activityIndicator: UIActivityIndicatorView!
    /// Bool value based on this activity indicator is animated
    var loading: Bool = false {
        didSet {
            loading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        }
    }
}
