//
//  SearchMoviesUsecaseProtocol.swift
//  Movies
//
//  Created by Praveen on 2/3/21.
//

import Foundation

/// Search Movies Request model
struct SearchRequestModel: Codable {
    var s: String
    var page: Int
}
