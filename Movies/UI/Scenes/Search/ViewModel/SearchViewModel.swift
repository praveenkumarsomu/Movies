//
//  SearchViewModel.swift
//  Movies
//
//  Created by Praveen on 2/3/21.
//

import Foundation

/// Search view model Inputs
protocol SearchViewModelInputProtocol {
    func searchMovies(_ searchKey: String)
    func loadNextPage(_ searchKey: String)
}
/// Search view model Outputs
protocol SearchViewModelOutputProtocol {
    var updateMoviesList: ((Movies) -> Void) { get set }
    var updateMoviesListFromPagination: ((Movies) -> Void) { get set }
    var receiveErrorFromSearchMovies: ((String) -> Void) { get set }
}
typealias SearchViewModelProtocol = SearchViewModelInputProtocol & SearchViewModelOutputProtocol
/*
 Inputs:
 Search request model
 Get next page of search results (Pagination)
 
 Outputs:
 Update search results
 Update Service error
 Update Pagination results
 */
class SearchViewModel: SearchViewModelProtocol {
    let searchUseCase: SearchMoviesUseCase
    // MARK:- Outputs
    var updateMoviesList: ((Movies) -> Void) = { _ in }
    var receiveErrorFromSearchMovies: ((String) -> Void) = { _ in }
    var updateMoviesListFromPagination: ((Movies) -> Void) = { _ in }
    
    // MARK:- Private variables
    private(set) var currentPage = 1
    private(set) var movies: Movies = []
    var searchKeyword: String?
    /// Initialization
    init(usecase: SearchMoviesUseCase) {
        self.searchUseCase = usecase
    }
    // MARK:- Inputs
    /// Gets search results
    /// - Parameter searchKey: search key word
    func searchMovies(_ searchKey: String) {
        /// Reset current page to `1` on new search
        currentPage = 1
        let searchViewModel = SearchRequestModel(s: searchKey, page: currentPage)
        self.searchKeyword = searchKey
        searchUseCase.execute(input: searchViewModel) { [self] response in
            switch response {
            case .success(let result):
                // remove duplicated results
                self.movies.removeAll()
                self.movies = result
                self.uniqueSearchResults()
                self.updateMoviesList(self.movies)
            case .failure(let error):
                self.receiveErrorFromSearchMovies(error.localizedDescription)
            }
        }
    }
    /// Get Next page search results
    /// - Parameter searchKey:
    func loadNextPage(_ searchKey: String) {
        /// Increment next page count by `1` for pagination
        updateCurrentPage()
        let searchViewModel = SearchRequestModel(s: searchKey, page: currentPage)
        searchUseCase.execute(input: searchViewModel) { [self] response in
            switch response {
            case .success(let result):
                self.movies.append(contentsOf: result)
                self.uniqueSearchResults()
                self.updateMoviesListFromPagination(self.movies)
            case .failure(let error):
                self.receiveErrorFromSearchMovies(error.localizedDescription)
            }
        }
    }
    func uniqueSearchResults() {
        self.movies =  Array(Set(self.movies))
    }
    // MARK:- Private functions
    private func updateCurrentPage() {
        currentPage += 1
    }
}
