//
//  MoviesRepository.swift
//  Movies
//
//  Created by Praveen on 3/3/21.
//

import Foundation
/// Movies repository protocol
protocol MoviesRepository {
    func searchMovies(model: SearchRequestModel, completion: @escaping ((Result<SearchResult, Error>) -> Void))
    func getMovieDetails(imdbID: String, completion: @escaping ((Result<MovieDetails, Error>) -> Void))
}
