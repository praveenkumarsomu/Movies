//
//  MockService.swift
//  MoviesTests
//
//  Created by Praveen on 7/3/21.
//

import Foundation
@testable import Movies

class MockService: Service {
    var mockResponsFileName: String!
    func getMovies(model: SearchRequestModel, completion: @escaping ((Result<SearchResult, Error>) -> Void)) {
        let result: Result<SearchResult, Error> = parseData()
        completion(result)
    }
    func getMovieDetails(imdbID: String, completion: @escaping ((Result<MovieDetails, Error>) -> Void)) {
        let result: Result<MovieDetails, Error> = parseData()
        completion(result)
    }
    func parseData<T: Codable>() -> Result<T, Error> {
        if let filePath = Bundle(for: MockService.self).path(forResource: mockResponsFileName, ofType: "json"), let data = try? Data(contentsOf: URL(fileURLWithPath: filePath), options: .mappedIfSafe) {
            let decoder = JSONDecoder()
            if let searchResult = try? decoder.decode(T.self, from: data) {
                return Result<T, Error>.success(searchResult)
            }
        }
        return Result<T, Error>.failure(MockError.failure)
    }
    enum MockError: Error {
        case failure
    }
}
