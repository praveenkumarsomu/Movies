//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Praveen on 6/3/21.
//

import UIKit

class MovieDetailViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    var viewModel: MovieDetailsViewModel!
    var movieID: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let viewModel = searchContainer.resolve(MovieDetailsViewModel?.self) {
            self.viewModel = viewModel
        }
//        viewModel.getMovieDetails(for: <#T##String#>)
    }
    private func bindViewModel() {
        viewModel.updateMovieDetails = { movieDetails in
            
        }
        viewModel.updateMovieDetailsError = { [weak self] error in
            guard let self = self else { return }
            self.showErrorMessage(with: "Error", description: error, actions: self.defaultAlertButton())
        }
    }
}
