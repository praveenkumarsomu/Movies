//
//  SearchViewModelTest.swift
//  MoviesTests
//
//  Created by Praveen on 7/3/21.
//

import XCTest
@testable import Movies
class SearchMovieTests: XCTestCase {
    var viewModel: SearchViewModel!
    var service: MockService = MockService()
    var moviesList: Movies = []
    var isError = false
    override func setUpWithError() throws {
        let moviesRepo = MoviesRepositoryImpl(service: service)
        let searchMoviesUseCase = SearchMoviesUseCase(searchRepo: moviesRepo)
        viewModel = SearchViewModel(usecase: searchMoviesUseCase)
    }

    override func tearDownWithError() throws {
        moviesList = []
        isError = false
    }

    func testGettingSearchResultsWithEmptyKeyWord() throws {
        /// Aqssign
        service.mockResponsFileName = "searchMovies"
        let searchViewController = configureSearchViewController()
        searchViewController?.searchController.searchBar.text = ""
        /// ACT
        searchViewController?.updateSearchResults(for: searchViewController!.searchController)
        /// Assert
        XCTAssertTrue(moviesList.isEmpty, "On searching with empty keyword mock service class returns non empty list")
        XCTAssertFalse(isError, "On searching with empty keyword mock service class thrown error")
    }
    func testGettingSearchResultsWithSearchKeyWithLengthFour() throws {
        /// Assign
        let searchViewController = configureSearchViewController()
        service.mockResponsFileName = "searchMovies"
        searchViewController?.searchController.searchBar.text = "test"
        /// Act
        searchViewController?.updateSearchResults(for: searchViewController!.searchController)
        /// Assert
        XCTAssertFalse(moviesList.isEmpty, "On searching with non empty keyword (more than 2 letters) mock service class returns empty list")
        XCTAssertFalse(isError, "On searching with empty keyword mock service class thrown error")
    }
    func testUpdatingErrorUpdationForSearchMovies() {
        /// Assign
        let searchViewController = configureSearchViewController()
        service.mockResponsFileName = "searchMoviesFailure"
        searchViewController?.searchController.searchBar.text = "test"
        /// ACT
        searchViewController?.updateSearchResults(for: searchViewController!.searchController)
        /// Assert
        XCTAssertTrue(moviesList.isEmpty, "Movies list is non empty on search service failure")
        XCTAssertTrue(isError, "Search movies error callback not called")
    }
    func configureSearchViewController() -> SearchViewController? {
        let searchViewController = SearchViewController.instantiate()
        searchViewController?.beginAppearanceTransition(true, animated: false)
        searchViewController?.viewModel = viewModel
        configureViewModelOutputs()
        return searchViewController
    }
    func configureViewModelOutputs() {
        viewModel.updateMoviesList = { movies in
            self.moviesList = movies
        }
        viewModel.receiveErrorFromSearchMovies = { error in
            self.isError = true
        }
    }
}
