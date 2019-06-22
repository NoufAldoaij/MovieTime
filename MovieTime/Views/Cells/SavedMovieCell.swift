//
//  SavedMovieCell.swift
//  MovieTime
//
//  Created by Nouf Aldoaij on 18/06/2019.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import UIKit

class SavedMovieCell: UITableViewCell {
    
    @IBOutlet weak var moviesPoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var moiveView: UIView!
    @IBOutlet weak var watchListButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var watchList:WatchListEntity?
    var favoriteList:FavoriteListEntity?
    var WatchListDelegate:UpdateWatchList?
    var favoriteListDelegate: UpdateFavoriteList?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // add shadow effect to the moive view
        moiveView.dropShadow()
    }
    
    // Save or remove movie to the watch list
    @IBAction func updateWatchList(_ sender: UIButton) {
        UserPreferences().removeFromWatchList(watchList!.movieTitle! , watchList!.movieReleaseDate!)
        WatchListDelegate?.updateWatchList()
    }
    
    // Save or remove movie from favorites list
    @IBAction func updateFavoritesList(_ sender: Any) {
        UserPreferences().removeFavoriteList(favoriteList!.movieTitle!, favoriteList!.movieReleaseDate!)
        favoriteListDelegate?.updateFavoriteList()
    }
    
}
