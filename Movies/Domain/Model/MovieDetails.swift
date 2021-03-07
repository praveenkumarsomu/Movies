//
//  MovieDetails.swift
//  Movies
//
//  Created by Praveen on 6/3/21.
//

import Foundation
/// Movie details service response model
struct MovieDetails : Codable {
    let actors : String?
    let awards : String?
    let boxOffice : String?
    let country : String?
    let director : String?
    let dVD : String?
    let genre : String?
    let imdbID : String?
    let imdbRating : String?
    let imdbVotes : String?
    let language : String?
    let metascore : String?
    let plot : String?
    let poster : String?
    let production : String?
    let rated : String?
    let ratings : [Rating]?
    let released : String?
    let response : String?
    let runtime : String?
    let title : String?
    let type : String?
    let website : String?
    let writer : String?
    let year : String?
    enum CodingKeys: String, CodingKey {
        case actors = "Actors"
        case awards = "Awards"
        case boxOffice = "BoxOffice"
        case country = "Country"
        case director = "Director"
        case dVD = "DVD"
        case genre = "Genre"
        case imdbID = "imdbID"
        case imdbRating = "imdbRating"
        case imdbVotes = "imdbVotes"
        case language = "Language"
        case metascore = "Metascore"
        case plot = "Plot"
        case poster = "Poster"
        case production = "Production"
        case rated = "Rated"
        case ratings = "Ratings"
        case released = "Released"
        case response = "Response"
        case runtime = "Runtime"
        case title = "Title"
        case type = "Type"
        case website = "Website"
        case writer = "Writer"
        case year = "Year"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        actors = try values.decodeIfPresent(String.self, forKey: .actors)
        awards = try values.decodeIfPresent(String.self, forKey: .awards)
        boxOffice = try values.decodeIfPresent(String.self, forKey: .boxOffice)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        director = try values.decodeIfPresent(String.self, forKey: .director)
        dVD = try values.decodeIfPresent(String.self, forKey: .dVD)
        genre = try values.decodeIfPresent(String.self, forKey: .genre)
        imdbID = try values.decodeIfPresent(String.self, forKey: .imdbID)
        imdbRating = try values.decodeIfPresent(String.self, forKey: .imdbRating)
        imdbVotes = try values.decodeIfPresent(String.self, forKey: .imdbVotes)
        language = try values.decodeIfPresent(String.self, forKey: .language)
        metascore = try values.decodeIfPresent(String.self, forKey: .metascore)
        plot = try values.decodeIfPresent(String.self, forKey: .plot)
        poster = try values.decodeIfPresent(String.self, forKey: .poster)
        production = try values.decodeIfPresent(String.self, forKey: .production)
        rated = try values.decodeIfPresent(String.self, forKey: .rated)
        ratings = try values.decodeIfPresent([Rating].self, forKey: .ratings)
        released = try values.decodeIfPresent(String.self, forKey: .released)
        response = try values.decodeIfPresent(String.self, forKey: .response)
        runtime = try values.decodeIfPresent(String.self, forKey: .runtime)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        website = try values.decodeIfPresent(String.self, forKey: .website)
        writer = try values.decodeIfPresent(String.self, forKey: .writer)
        year = try values.decodeIfPresent(String.self, forKey: .year)
    }
    func convertToMovieDetailsModel() -> MovieDetailsModel {
        MovieDetailsModel(actors: actors, language: language, posterURL: getPosterUrl(), ratings: ratings, plot: plot, writer: writer, year: year, title: title, imdbRating: imdbRating)
    }
    func getPosterUrl() -> URL? {
        guard let poster = poster else { return nil }
        return URL(string: poster)
    }
}
