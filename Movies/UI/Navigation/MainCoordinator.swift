//
//  MainCoordinator.swift
//  Movies
//
//  Created by Praveen on 6/3/21.
//

import Foundation

import UIKit

class MainCoordinator: Coordinator {
    var chileCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = SearchViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    func showMovieDetailsScreen(with imdbID: String) {
        let movieDetailsVC = MovieDetailViewController.instantiate()
        movieDetailsVC.movieID = imdbID
        navigationController.pushViewController(movieDetailsVC, animated: true)
    }
}
