//
//  SearchMoviesUseCaseImplementation.swift
//  Movies
//
//  Created by Praveen on 2/3/21.
//

import Foundation
import Alamofire

typealias Movies = [Movie]
class SearchMoviesUseCase: UseCaseWithParameter {
    typealias Input = SearchRequestModel
    typealias Output = (Result<[Movie], Error>) -> Void

    var searchRepository: MoviesRepository!
    init(searchRepo: MoviesRepository) {
        self.searchRepository = searchRepo
    }
    func execute(input: SearchRequestModel, completion: @escaping (Result<[Movie], Error>) -> Void) {
        searchRepository.searchMovies(model: input) { result in
            switch result {
            case .success(let result):
                let movies = self.convertSearchResultIntoMovie(result)
                completion(Result<[Movie], Error>.success(movies))
            case .failure(let error):
                completion(Result<[Movie], Error>.failure(error))
            }
        }
    }
    func convertSearchResultIntoMovie(_ searchResult: SearchResult) -> [Movie] {
        let movies = searchResult.search?.compactMap({ search in
            search.getMovieModel()
        })
        return movies ?? []
    }
}
