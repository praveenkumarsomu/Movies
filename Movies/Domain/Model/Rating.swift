//
//  Rating.swift
//  Movies
//
//  Created by Praveen on 6/3/21.
//

import Foundation

struct Rating : Codable {
    let source : String?
    let value : String?
    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        source = try values.decodeIfPresent(String.self, forKey: .source)
        value = try values.decodeIfPresent(String.self, forKey: .value)
    }
}
