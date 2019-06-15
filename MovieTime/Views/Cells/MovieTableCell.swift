//
//  MovieTableCell.swift
//  MovieTime
//
//  Created by Nouf Abdullah on 6/12/19.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import UIKit

class MovieTableCell: UITableViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var watchListButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var moiveView: UIView!
    @IBOutlet weak var moviesReleaseDate: UILabel!
    
    var movie:DummyData?
    override func awakeFromNib() {
        super.awakeFromNib()
        moiveView.dropShadow()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func addToWatchList(_ sender: UIButton) {
        if watchListButton.currentImage == #imageLiteral(resourceName: "bookmark") {
            UserPreferences().updateToWatchList(toWatch: true, movie: movie!)
            //watchListButton.backgroundColor = MovieTimeColors.darkPink_Color
            watchListButton.setImage(#imageLiteral(resourceName: "pink_bookmark"), for: .normal)
        } else {
            UserPreferences().updateToWatchList(toWatch: false, movie: movie!)
           // watchListButton.backgroundColor = MovieTimeColors.darkGray_Color
            watchListButton.setImage(#imageLiteral(resourceName: "bookmark"), for: .normal)
        }
    }
    
    
    @IBAction func addToFavorites(_ sender: UIButton) {
        if favoriteButton.currentImage == #imageLiteral(resourceName: "hearts") {
            UserPreferences().updateToFavoriteList(isAFavorited: true, movie: movie!)
            favoriteButton.setImage(#imageLiteral(resourceName: "pinkHearts"), for: .normal)
            
        } else {
            UserPreferences().updateToFavoriteList(isAFavorited: false, movie: movie!)
            favoriteButton.setImage(#imageLiteral(resourceName: "hearts"), for: .normal)
        }
    }
}
