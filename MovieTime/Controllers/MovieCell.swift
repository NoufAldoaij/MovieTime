//
//  MovieCell.swift
//  MovieTime
//
//  Created by Nouf Abdullah on 6/8/19.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var moviesPoster: UIImageView!
    @IBOutlet weak var watchListButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    var movie:DummyData?
    
    func updateToWatchList(toWatch:Bool) {
        let watchList = WatchList.init(movieInfo: movie!)
        // Add it to the movie array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        var index = 0
        if toWatch {
            appDelegate.watchList.append(watchList)
        } else {
            for movies in appDelegate.watchList {
                if movies.movieInfo?.movieTitle == movie!.movieTitle {
                    appDelegate.watchList.remove(at: index)
                }
                index += 1
            }
        }
    }
    
    func updateToFavoriteList(isFavorited:Bool) {
        let favoriteList  = FavoriteList.init(movieInfo: movie!)
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        var index = 0
        if isFavorited {
            appDelegate.favoriteList.append(favoriteList)
        } else {
            for movies in appDelegate.favoriteList {
                if movies.movieInfo?.movieTitle == movie!.movieTitle {
                    appDelegate.favoriteList.remove(at: index)
                }
                index += 1
            }
        }
        
    }
    
    @IBAction func addToWatchList(_ sender: UIButton) {
        if watchListButton.currentImage == #imageLiteral(resourceName: "134224-16") {
            updateToWatchList(toWatch: true)
            watchListButton.backgroundColor = MovieTimeColors.darkPink_Color
            watchListButton.setImage(#imageLiteral(resourceName: "1063906-20"), for: .normal)
        } else {
            updateToWatchList(toWatch: false)
            watchListButton.backgroundColor = MovieTimeColors.darkGray_Color
            watchListButton.setImage(#imageLiteral(resourceName: "134224-16"), for: .normal)
        }
    }
    
    @IBAction func addToFavorites(_ sender: Any) {
        if favoriteButton.currentImage == #imageLiteral(resourceName: "2246820-512-4") {
            updateToFavoriteList(isFavorited: true)
            favoriteButton.setImage(#imageLiteral(resourceName: "pinkHearts"), for: .normal)
            
        } else {
            updateToFavoriteList(isFavorited: false)
            favoriteButton.setImage(#imageLiteral(resourceName: "2246820-512-4"), for: .normal)
        }
    }
}
