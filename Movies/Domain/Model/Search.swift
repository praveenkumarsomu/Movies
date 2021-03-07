//
//  Search.swift
//  Movies
//
//  Created by Praveen on 2/3/21.
//

import Foundation

struct Search : Codable, Hashable {
    
    let imdbID : String?
    let poster : String?
    let title : String?
    let type : String?
    let year : String?
    
    enum CodingKeys: String, CodingKey {
        case imdbID = "imdbID"
        case poster = "Poster"
        case title = "Title"
        case type = "Type"
        case year = "Year"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        imdbID = try values.decodeIfPresent(String.self, forKey: .imdbID)
        poster = try values.decodeIfPresent(String.self, forKey: .poster)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        year = try values.decodeIfPresent(String.self, forKey: .year)
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(imdbID)
    }
    func getPosterUrl() -> URL? {
        guard let poster = poster else { return nil }
        return URL(string: poster)
    }
}
