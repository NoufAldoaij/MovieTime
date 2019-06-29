//
//  FavoriteListVC.swift
//  MovieTime
//
//  Created by Nouf Aldoaij on 18/06/2019.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import UIKit
import CoreData

class FavoriteListVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UpdateFavoriteList {
    
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noDataFound: UILabel!
    
    var favoriteList: [FavoriteListEntity] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadData()
        setUI()
    }
    
    func setUI() {
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBarView.setViewWithBorder()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        noDataFound.isHidden = true
    }
    
    // Load saved moives for DB
    func loadData(_ searchText:String = "") {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<FavoriteListEntity> = FavoriteListEntity.fetchRequest()
        // filter the watch list base on the movie title
        if searchText != "" {
            let predicateer = NSPredicate(format: "movieTitle CONTAINS %@", searchText)
            fetchRequest.predicate = predicateer
        }
        do {
            favoriteList = try context.fetch(fetchRequest)
            tableView.reloadData()
        } catch {
            HelperClass().showAlert(title: nil, message: "Could not find any movies", self)
        }
    }
    
    // Search the watch list
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            loadData()
        } else {
            loadData(searchText)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noDataFound.isHidden = favoriteList.count > 0 ? true : false
        return favoriteList.count > 0 ? favoriteList.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SavedMovieCell
        let entity = favoriteList[indexPath.row]
        cell.favoriteList = entity
        cell.favoriteListDelegate = self
        cell.moviesPoster.image = UIImage(data: entity.moviePoster!)
        cell.movieTitle.text = entity.movieTitle
        cell.movieGenres.text = entity.movieReleaseDate
        //cell.movieGenres.text = "2019 Action,Thriller"
        // Check if the movie was in the watch list
        if UserPreferences().isMovieInWatchList(title: entity.movieTitle!) {
            cell.watchListButton.setImage(#imageLiteral(resourceName: "pink_bookmark"), for: .normal)
        } else {
            cell.watchListButton.setImage(#imageLiteral(resourceName: "bookmark"), for: .normal)
        }
        if  UserPreferences().isMovieInFavoriteList(title: entity.movieTitle!) {
            cell.favoriteButton.setImage(#imageLiteral(resourceName: "pinkHearts"), for: .normal)
        } else {
            cell.favoriteButton.setImage(#imageLiteral(resourceName: "hearts"), for: .normal)
        }
        return cell
    }
    
    // Show more details for individual movie
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsVC") as! MovieDetailsVC
        vc.movieID = favoriteList[indexPath.row].movieId!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // Update the favorite list after a moive have been remove for the list
    func updateFavoriteList() {
        loadData()
    }
    
}
