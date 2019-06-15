//
//  DummyData.swift
//  MovieTime
//
//  Created by Nouf Abdullah on 6/11/19.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import Foundation
import UIKit
class DummyData:NSObject {
    
    var moviePoster:UIImage?
    var movieTitle:String?
    var moviesReleaseDate:String?

    init(moviePoster:UIImage, movieTitle:String, moviesReleaseDate:String) {
        self.moviePoster = moviePoster
        self.movieTitle = movieTitle
        self.moviesReleaseDate = moviesReleaseDate
    }
}
