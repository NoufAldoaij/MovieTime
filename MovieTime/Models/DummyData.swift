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
    
    init(moviePoster:UIImage, movieTitle:String) {
        self.moviePoster = moviePoster
        self.movieTitle = movieTitle
    }
}
