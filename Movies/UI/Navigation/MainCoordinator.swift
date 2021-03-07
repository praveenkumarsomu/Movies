//
//  MainCoordinator.swift
//  Movies
//
//  Created by Praveen on 6/3/21.
//

import Foundation

import UIKit

/// Coordinator for handling navigation
class MainCoordinator: Coordinator {
    /// Not using this one for now it's for future use
    var chileCoordinators: [Coordinator] = []
    /// Navigation controller of the coordinator
    var navigationController: UINavigationController
    // MARK:- Initialization
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    /// Start coordinator (This called from SceneDelegate to display Initial screen)
    func start() {
        if let vc = SearchViewController.instantiate() {
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: false)
        }
    }
    /// Navigate to `MovieDetailController`
    /// - Parameter imdbID: Id of the movie to get details from Repo
    func showMovieDetailsScreen(with imdbID: String) {
        if let movieDetailsVC = MovieDetailViewController.instantiate() {
            movieDetailsVC.movieID = imdbID
            navigationController.pushViewController(movieDetailsVC, animated: true)
        }
    }
}
