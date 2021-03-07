//
//  MovieDetailsUseCase.swift
//  Movies
//
//  Created by Praveen on 6/3/21.
//

import Foundation

class MovieDetailsUseCase: UseCaseWithParameter {
    typealias Input = String
    typealias Output = (Result<MovieDetailsModel, Error>) -> Void

    var searchRepository: MoviesRepository!
    init(searchRepo: MoviesRepository) {
        self.searchRepository = searchRepo
    }
    func execute(input: Input, completion: @escaping  Output) {
        searchRepository.getMovieDetails(imdbID: input) { result in
            switch result {
            case .success(let result):
                let movies = self.convertMovieDetailsModel(result)
                completion(Result<MovieDetailsModel, Error>.success(movies))
            case .failure(let error):
                completion(Result<MovieDetailsModel, Error>.failure(error))
            }
        }
    }
    func convertMovieDetailsModel(_ movieDetails: MovieDetails) -> MovieDetailsModel {
        movieDetails.convertToMovieDetailsModel()
    }
}
