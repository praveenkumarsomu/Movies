//
//  Service.swift
//  Movies
//
//  Created by Praveen on 3/3/21.
//

import Foundation
import Alamofire

class ServiceImpl: Service {
    var baseURL: String = "http://www.omdbapi.com/?apikey=b9bd48a6"
    func getMovies(model: SearchRequestModel, completion: @escaping ((Result<SearchResult, Error>) -> Void)) {
        let url = "\(baseURL)&s=\(model.s.stringByAddingPercentEncodingForRFC3986() ?? "")&page=\(model.page)"
        print("Search URL \(url)")
        AF.request(url, method: .get).responseDecodable(of: SearchResult.self) { (response) in
            guard let searchResult = response.value else {
                return completion(.failure(response.error!))
            }
            completion(.success(searchResult))
        }
    }
    func getMovieDetails(imdbID: String, completion: @escaping ((Result<MovieDetails, Error>) -> Void)) {
        let url = "\(baseURL)&i=\(imdbID)"
        AF.request(url, method: .get).responseDecodable(of: MovieDetails.self) { (response) in
            guard let movieDetails = response.value else {
                return completion(.failure(response.error!))
            }
            completion(.success(movieDetails))
        }
    }
}
