//
//  Service.swift
//  Movies
//
//  Created by Praveen on 2/3/21.
//

import Foundation
/// `MoviesRepository` Implementation class
class MoviesRepositoryImpl: MoviesRepository {
    var service: Service!
    init(service: Service) {
        self.service = service
    }
    /// Gets the Search result
    func searchMovies(model: SearchRequestModel, completion: @escaping ((Result<SearchResult, Error>) -> Void)) {
        service.getMovies(model: model, completion: completion)
    }
    /// Gets the movie detail
    func getMovieDetails(imdbID: String, completion: @escaping ((Result<MovieDetails, Error>) -> Void)) {
        service.getMovieDetails(imdbID: imdbID, completion: completion)
    }
}
