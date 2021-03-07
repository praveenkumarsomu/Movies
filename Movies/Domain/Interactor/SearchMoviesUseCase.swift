//
//  SearchMoviesUseCaseImplementation.swift
//  Movies
//
//  Created by Praveen on 2/3/21.
//

import Foundation
import Alamofire

typealias Movies = [Movie]
/// Search movies use case
class SearchMoviesUseCase: UseCaseWithParameter {
    typealias Input = SearchRequestModel
    typealias Output = (Result<Movies, Error>) -> Void
    /// Movies repository
    var searchRepository: MoviesRepository!
    init(searchRepo: MoviesRepository) {
        self.searchRepository = searchRepo
    }
    func execute(input: SearchRequestModel, completion: @escaping (Result<Movies, Error>) -> Void) {
        searchRepository.searchMovies(model: input) { result in
            switch result {
            case .success(let result):
                let movies = self.convertSearchResultIntoMovie(result)
                completion(Result<Movies, Error>.success(movies))
            case .failure(let error):
                completion(Result<Movies, Error>.failure(error))
            }
        }
    }
    /// Converts `[Search]` into `[Movie]`
    func convertSearchResultIntoMovie(_ searchResult: SearchResult) -> Movies {
        let movies = searchResult.search?.compactMap({ search in
            search.getMovieModel()
        })
        return movies ?? []
    }
}
