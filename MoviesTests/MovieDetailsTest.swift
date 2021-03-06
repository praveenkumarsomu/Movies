//
//  MovieDetailsTest.swift
//  MoviesTests
//
//  Created by Praveen on 7/3/21.
//

import XCTest
@testable import Movies

class MovieDetailsTest: XCTestCase {
    var viewModel: MovieDetailsViewModel!
    var service: MockService = MockService()
    var movieDetails: MovieDetailsModel?
    
    override func setUpWithError() throws {
        let moviesRepo = MoviesRepositoryImpl(service: service)
        let searchMoviesUseCase = MovieDetailsUseCase(searchRepo: moviesRepo)
        viewModel = MovieDetailsViewModel(useCase: searchMoviesUseCase)
        movieDetailsContainer.register(MovieDetailsViewModel?.self) { resolver in
            return self.viewModel
        }
    }
    override func tearDownWithError() throws {
    }
    func testGettingMovieDetailsOnViewDidLoad() {
        /// Assign
        let movieDetailsVC = configureMovieDetailsViewController()
        service.mockResponsFileName = "movieDetails"
        /// Act
        movieDetailsVC?.beginAppearanceTransition(true, animated: false)
        /// Assert
        XCTAssertNotNil(movieDetailsVC?.movieDetails, "Movie details object is empty or service is not called on ViewDidLoad")
    }
    func testMovieDetailsAPIError() {
        /// Assign
        let movieDetailsVC = configureMovieDetailsViewController()
        service.mockResponsFileName = "movieDetailsFailure"
        /// Act
        movieDetailsVC?.beginAppearanceTransition(true, animated: false)
        /// Assert
        XCTAssertNil(movieDetailsVC?.movieDetails, "Movie details error state is not updated properly")
    }
    func configureMovieDetailsViewController() -> MovieDetailViewController? {
        let movieDetailsVC = MovieDetailViewController.instantiate()
        movieDetailsVC?.movieID = "test"
        return movieDetailsVC
    }

}
