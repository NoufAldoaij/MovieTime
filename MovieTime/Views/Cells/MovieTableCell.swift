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
    
    @IBAction func addToWatchList(_ sender: Any) {
        if watchListButton.currentImage == #imageLiteral(resourceName: "134224-16") {
            UserPreferences().updateToWatchList(toWatch: true, movie: movie!)
            watchListButton.backgroundColor = MovieTimeColors.darkPink_Color
            watchListButton.setImage(#imageLiteral(resourceName: "1063906-20"), for: .normal)
        } else {
            UserPreferences().updateToWatchList(toWatch: false, movie: movie!)
            watchListButton.backgroundColor = MovieTimeColors.darkGray_Color
            watchListButton.setImage(#imageLiteral(resourceName: "134224-16"), for: .normal)
        }
    }
    
    
    @IBAction func addToFavorites(_ sender: Any) {
        if favoriteButton.currentImage == #imageLiteral(resourceName: "2246820-512-4") {
            UserPreferences().updateToFavoriteList(isAFavorited: true, movie: movie!)
            favoriteButton.setImage(#imageLiteral(resourceName: "pinkHearts"), for: .normal)
            
        } else {
            UserPreferences().updateToFavoriteList(isAFavorited: false, movie: movie!)
            favoriteButton.setImage(#imageLiteral(resourceName: "2246820-512-4"), for: .normal)
        }
    }
}
