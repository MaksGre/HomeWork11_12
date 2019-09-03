//
//  JSONModel.swift
//  Home Work 11. Alamofire
//
//  Created by Maksim Grebenozhko on 27/08/2019.
//  Copyright © 2019 Maksim Grebenozhko. All rights reserved.
//

import Foundation

struct BySearch: Decodable {
    let title: String?
    let year: String?
    let imdbID: String?
    let type: String?
    let poster: String?

    enum CodingCase: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }
    
//без init, CodingCase не работает, возможно из-за NSMutableURLRequest
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingCase.self)
        
        title = try values.decode(String.self, forKey: .title)
        year = try? values.decode(String.self, forKey: .year)
        imdbID = try? values.decode(String.self, forKey: .imdbID)
        type = try? values.decode(String.self, forKey: .type)
        poster = try? values.decode(String.self, forKey: .poster)
    }
}

struct ResultBySearch: Decodable {
    let search: [BySearch]?
    let totalResults: String?
    let response: String?

    enum CodingCase: String, CodingKey {
        case search = "Search"
        case totalResults = "totalResults"
        case response = "Response"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingCase.self)
        
        search = try values.decode([BySearch].self, forKey: .search)
        totalResults = try? values.decode(String.self, forKey: .totalResults)
        response = try? values.decode(String.self, forKey: .response)
    }
}

struct Rating: Decodable {
    let source: String?
    let value: String?

    enum CodingCase: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingCase.self)
        
        source = try? values.decode(String.self, forKey: .source)
        value = try? values.decode(String.self, forKey: .value)
    }
}

struct resultByID: Decodable {
    let title: String?
    let year: String?
    let rated: String?
    let released: String?
    let runtime: String?
    let genre: String?
    let director: String?
    let writer: String?
    let actors: String?
    let plot: String?
    let language: String?
    let country: String?
    let awards: String?
    let poster: String?
    let ratings: [Rating]?
    let metascore: String?
    let imdbRating: String?
    let imdbVotes: String?
    let imdbID: String?
    let type: String?
    let dvd: String?
    let boxOffice: String?
    let production: String?
    let website: String?
    let response: String?

    enum CodingCase: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating = "imdbRating"
        case imdbVotes = "imdbVotes"
        case imdbID = "imdbID"
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingCase.self)
        
        title = try? values.decode(String.self, forKey: .title)
        year = try? values.decode(String.self, forKey: .year)
        rated = try? values.decode(String.self, forKey: .rated)
        released = try? values.decode(String.self, forKey: .released)
        runtime = try? values.decode(String.self, forKey: .runtime)
        genre = try? values.decode(String.self, forKey: .genre)
        director = try? values.decode(String.self, forKey: .director)
        writer = try? values.decode(String.self, forKey: .writer)
        actors = try? values.decode(String.self, forKey: .actors)
        plot = try? values.decode(String.self, forKey: .plot)
        language = try? values.decode(String.self, forKey: .language)
        country = try? values.decode(String.self, forKey: .country)
        awards = try? values.decode(String.self, forKey: .awards)
        poster = try? values.decode(String.self, forKey: .poster)
        ratings = try? values.decode([Rating].self, forKey: .ratings)
        metascore = try? values.decode(String.self, forKey: .metascore)
        imdbRating = try? values.decode(String.self, forKey: .imdbRating)
        imdbVotes = try? values.decode(String.self, forKey: .imdbVotes)
        imdbID = try? values.decode(String.self, forKey: .imdbID)
        type = try? values.decode(String.self, forKey: .type)
        dvd = try? values.decode(String.self, forKey: .dvd)
        boxOffice = try? values.decode(String.self, forKey: .boxOffice)
        production = try? values.decode(String.self, forKey: .production)
        website = try? values.decode(String.self, forKey: .website)
        response = try? values.decode(String.self, forKey: .response)
    }
}
