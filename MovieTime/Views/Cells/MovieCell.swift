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
    
    @IBAction func addToWatchList(_ sender: UIButton) {
        if watchListButton.currentImage == #imageLiteral(resourceName: "bookmark") {
            UserPreferences().updateToWatchList(toWatch: true, movie: movie!)
            watchListButton.setImage(#imageLiteral(resourceName: "pink_bookmark"), for: .normal)
        } else {
            UserPreferences().updateToWatchList(toWatch: false, movie: movie!)
            watchListButton.setImage(#imageLiteral(resourceName: "bookmark"), for: .normal)
        }
    }
    
    @IBAction func addToFavorites(_ sender: Any) {
        if favoriteButton.currentImage == #imageLiteral(resourceName: "hearts") {
            UserPreferences().updateToFavoriteList(isAFavorited: true, movie: movie!)
            favoriteButton.setImage(#imageLiteral(resourceName: "pinkHearts"), for: .normal)
            
        } else {
            UserPreferences().updateToFavoriteList(isAFavorited: false, movie: movie!)
            favoriteButton.setImage(#imageLiteral(resourceName: "hearts"), for: .normal)
        }
    }
}
