//
//  UserPreferences.swift
//  MovieTime
//
//  Created by Nouf Abdullah on 6/14/19.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import Foundation
import UIKit
class UserPreferences:NSObject {
    
    
    func updateToWatchList(toWatch:Bool, movie:DummyData) {
        let watchList = WatchList.init(movieInfo: movie)
        // Add it to the movie array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        var index = 0
        if toWatch {
            appDelegate.watchList.append(watchList)
        } else {
            for movies in appDelegate.watchList {
                if movies.movieInfo?.movieTitle == movie.movieTitle {
                    appDelegate.watchList.remove(at: index)
                }
                index += 1
            }
        }
    }
  
    func updateToFavoriteList(isAFavorited:Bool,movie:DummyData) {
        let favoriteList  = FavoriteList.init(movieInfo: movie)
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        var index = 0
        if isAFavorited {
            appDelegate.favoriteList.append(favoriteList)
        } else {
            for movies in appDelegate.favoriteList {
                if movies.movieInfo?.movieTitle == movie.movieTitle {
                    appDelegate.favoriteList.remove(at: index)
                }
                index += 1
            }
        }
    }
}
