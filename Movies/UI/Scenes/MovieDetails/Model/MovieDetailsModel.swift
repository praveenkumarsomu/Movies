//
//  MovieDetailsModel.swift
//  Movies
//
//  Created by Praveen on 6/3/21.
//

import Foundation

/// Model for displaying movie details in `MovieDetailViewController`
struct MovieDetailsModel: Hashable, Equatable {
    let actors : String?
    let language : String?
    let posterURL : URL?
    let ratings : [Rating]?
    let plot : String?
    let writer : String?
    let year : String?
    let title: String?
    let imdbRating : String?
    func hash(into hasher: inout Hasher) {
        hasher.combine(Date().timeIntervalSince1970)
    }
    static func == (lhs: MovieDetailsModel, rhs: MovieDetailsModel) -> Bool {
        lhs.title == rhs.title
    }
}
