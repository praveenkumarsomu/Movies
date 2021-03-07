//
//  SearchViewModel.swift
//  Movies
//
//  Created by Praveen on 2/3/21.
//

import Foundation

/*
 Inputs:
 Search request model
 user scrolled to the end get another page
 
 Outputs:
 List of movies
 Error
 
 Usecase: Search movie use case 
 */
protocol SearchViewModelInputProtocol {
    func searchMovies(_ searchKey: String)
    func loadNextPage(_ searchKey: String)
}
protocol SearchViewModelOutputProtocol {
    var updateMoviesList: (([Movie]) -> Void) { get set }
    var updateMoviesListFromPagination: (([Movie]) -> Void) { get set }
    var receiveErrorFromSearchMovies: ((String) -> Void) { get set }
}
typealias SearchViewModelProtocol = SearchViewModelInputProtocol & SearchViewModelOutputProtocol

class SearchViewModel: SearchViewModelProtocol {
    // MARK:- Outputs
    var updateMoviesList: (([Movie]) -> Void) = { _ in }
    var receiveErrorFromSearchMovies: ((String) -> Void) = { _ in }
    var updateMoviesListFromPagination: (([Movie]) -> Void) = { _ in }
    
    let searchUseCase: SearchMoviesUseCase
    private(set) var currentPage = 1
    private(set) var movies: [Movie] = []
    var searchKeyword: String?
    init(usecase: SearchMoviesUseCase) {
        self.searchUseCase = usecase
    }
    // MARK:- Inputs
    func searchMovies(_ searchKey: String) {
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
           print(response)
        }
    }
    func loadNextPage(_ searchKey: String) {
        updateCurrentPage()
        let searchViewModel = SearchRequestModel(s: searchKey, page: currentPage)
        searchUseCase.execute(input: searchViewModel) { [self] response in
            switch response {
            case .success(let result):
                self.movies.append(contentsOf: result ?? [])
                self.uniqueSearchResults()
                self.updateMoviesListFromPagination(self.movies)
            case .failure(let error):
                self.receiveErrorFromSearchMovies(error.localizedDescription)
            }
           print(response)
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
