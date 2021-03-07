//
//  MoviesModel.swift
//  Movies
//
//  Created by Praveen on 6/3/21.
//

import Foundation

struct Movie: Hashable {
    var id: Double?
    var imdbID: String?
    var title: String?
    var posterURL: URL?
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
