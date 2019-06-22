//
//  UserPreferences.swift
//  MovieTime
//
//  Created by Nouf Abdullah on 6/14/19.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class UserPreferences:NSObject {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Save moive to watch list
    func addToWatchList (_ movie:MovieEntity, _ moviesPoster:Data) {
        do {
            let watchList = WatchListEntity(context: context)
            watchList.movieTitle = movie.title
            watchList.movieReleaseDate = movie.releaseDate
            watchList.moviePoster = moviesPoster
            try context.save()
        } catch {
            print("error while saving \(error)")
        }
    }
    
    // Remove the moive for DB
    func removeFromWatchList (_ movieTitle:String, _ releaseDate:String) {
        let fetchRequest:NSFetchRequest<WatchListEntity> = WatchListEntity.fetchRequest()
        let predicate = NSPredicate(format: "movieTitle == %@",movieTitle)
        let sortDescriptors = NSSortDescriptor(key: "movieTitle", ascending: false)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [sortDescriptors]
        
        do {
            let watchList = try context.fetch(fetchRequest)
            if watchList.first?.movieTitle == movieTitle && watchList.first?.movieReleaseDate == releaseDate {
                context.delete(watchList.first!)
            }
        } catch {
            print("error while deleteing \(error)")
        }
        
    }
    
    // Check if the movie existed in the DB
    func isMovieInWatchList(title:String) -> Bool {
        let fetchRequest:NSFetchRequest<WatchListEntity> = WatchListEntity.fetchRequest()
        let predicate = NSPredicate(format: "movieTitle == %@", title)
        fetchRequest.predicate = predicate
        
        do {
            let watchList = try context.fetch(fetchRequest)
            if watchList.first?.movieTitle == title {
                return true
            }
        } catch {
            print("could not find moive")
        }
        return false
    }
    
    // Save moive to favorite list
    func addToFavoriteList (_ movie:MovieEntity, _ moviePoster:Data) {
        do {
            let favoriteList = FavoriteListEntity(context: context)
            favoriteList.movieTitle = movie.title
            favoriteList.movieReleaseDate = movie.releaseDate
            favoriteList.moviePoster = moviePoster
            try context.save()
            
        } catch {
            print("error while saving \(error)")
        }
    }
    
    // Remove the moive for DB
    func removeFavoriteList (_ movieTitle:String, _ releaseDate:String)  {
        let fetchRequest:NSFetchRequest<FavoriteListEntity> = FavoriteListEntity.fetchRequest()
        let predicate = NSPredicate(format: "movieTitle == %@", movieTitle)
        fetchRequest.predicate = predicate
        
        do {
            let favoriteList = try context.fetch(fetchRequest)
            if favoriteList.first?.movieTitle == movieTitle && favoriteList.first?.movieReleaseDate == releaseDate {
                context.delete(favoriteList.first!)
            }
        } catch {
            print("error while deleteing \(error)")
        }
    }
    
    // Check if the favorite movie existed in the DB
    func isMovieInFavoriteList(title:String) -> Bool {
        let fetchRequest:NSFetchRequest<FavoriteListEntity> = FavoriteListEntity.fetchRequest()
        let predicate = NSPredicate(format: "movieTitle == %@", title)
        fetchRequest.predicate = predicate
        do {
            let watchList = try context.fetch(fetchRequest)
            if watchList.first?.movieTitle == title {
                return true
            }
        } catch {
            print("could not find moive")
        }
        return false
    }
}
