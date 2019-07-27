//
//  MovieEntity.swift
//  MovieTime
//
//  Created by Nouf Abdullah on 6/21/19.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import Foundation

// MARK: - Welcome
class MoviesEntity: Codable {
    var results: [MovieEntity]
    var page, totalResults: Int
    var totalPages: Int
    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}



// MARK: - Result
class MovieEntity: Codable {
    var voteCount, id: Int
    var video: Bool
    var voteAverage: Double
    var title: String
    var popularity: Double
    var posterPath: String
    var originalTitle: String
    var genreIDS: [Int]
    var backdropPath: String?
    var adult: Bool
    var overview, releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case id, video
        case voteAverage = "vote_average"
        case title, popularity
        case posterPath = "poster_path"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
       case backdropPath = "backdrop_path"
        case adult, overview
        case releaseDate = "release_date"
    }
}
