//
//  MovieDetailsEntity.swift
//  MovieTime
//
//  Created by Nouf Abdullah on 6/26/19.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import Foundation

class MovieDetailsEntity:Codable {
    let adult: Bool
    let backdropPath: String?
    let belongsToCollection : BelongsToCollectionEntity?
    let budget: Int
    let id: Int
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double
    let posterPath: String?
    let productionCompanies: [ProductionCompaniesEntity]?
    let releaseDate: String?
    let status, tagline, title: String?
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case belongsToCollection = "belongs_to_collection"
        case releaseDate = "release_date"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

