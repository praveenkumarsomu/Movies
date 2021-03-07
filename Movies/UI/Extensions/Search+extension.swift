//
//  Search+extension.swift
//  Movies
//
//  Created by Praveen on 6/3/21.
//

import Foundation

extension Search {
    /// Converts `Search` model to `Movie`
    func getMovieModel() -> Movie {
        return Movie(id: Date().timeIntervalSince1970, imdbID: imdbID, title: title, posterURL: getPosterUrl())
    }
}
