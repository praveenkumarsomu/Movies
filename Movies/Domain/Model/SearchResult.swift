//
//  SearchResult.swift
//  Movies
//
//  Created by Praveen on 2/3/21.
//

import Foundation

/// Search movies service response model
struct SearchResult : Codable {
    
    let response : String?
    let search : [Search]?
    let totalResults : String?
    
    enum CodingKeys: String, CodingKey {
        case response = "Response"
        case search = "Search"
        case totalResults = "totalResults"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        response = try values.decodeIfPresent(String.self, forKey: .response)
        search = try values.decodeIfPresent([Search].self, forKey: .search)
        totalResults = try values.decodeIfPresent(String.self, forKey: .totalResults)
    }
    /// Filter Unique values from search result
    /// - Parameter list: list of movies
    func uniqueSearchResults() -> [Search] {
        Array(Set(search ?? []))
    }
}
