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
    var moviesPosterData:Data?
    var title = ""
    var releaseDate = ""
    var movieId = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // add shadow effect to the moive view
        moiveView.dropShadow()
    }
    
    func setMovieEntity() {
        if watchList != nil {
            title = watchList!.movieTitle!
            releaseDate = watchList!.movieReleaseDate!
            moviesPosterData = watchList?.moviePoster
            movieId = watchList!.movieId!
            watchList = nil
        } else {
            title = favoriteList!.movieTitle!
            releaseDate = favoriteList!.movieReleaseDate!
            moviesPosterData = favoriteList?.moviePoster
            movieId = favoriteList!.movieId!
            favoriteList = nil
        }
    }
    // Save or remove movie to the watch list
    @IBAction func updateWatchList(_ sender: UIButton) {
        setMovieEntity()
        if watchListButton.currentImage == #imageLiteral(resourceName: "bookmark") {
            UserPreferences().addToWatchList(movieId,title,releaseDate , moviesPosterData!)
            watchListButton.setImage(#imageLiteral(resourceName: "pink_bookmark"), for: .normal)
        } else {
            UserPreferences().removeFromWatchList(title,releaseDate)
            watchListButton.setImage(#imageLiteral(resourceName: "bookmark"), for: .normal)
        }
        favoriteListDelegate?.updateFavoriteList()
        WatchListDelegate?.updateWatchList()
        
    }
    
    // Save or remove movie from favorites list
    @IBAction func updateFavoritesList(_ sender: Any) {
        setMovieEntity()
        if favoriteButton.currentImage == #imageLiteral(resourceName: "hearts") {
            //UserPreferences().addToFavoriteList(title, releaseDate, moviesPosterData!)
            favoriteButton.setImage(#imageLiteral(resourceName: "pinkHearts"), for: .normal)
        } else {
            UserPreferences().removeFavoriteList(title, releaseDate)
            favoriteButton.setImage(#imageLiteral(resourceName: "hearts"), for: .normal)
        }
        favoriteListDelegate?.updateFavoriteList()
        WatchListDelegate?.updateWatchList()

    }
    
}
