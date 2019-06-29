//
//  DiscoverVC.swift
//  MovieTime
//
//  Created by Nouf Abdullah on 6/8/19.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import UIKit
import Speech
import CoreData
class DiscoverVC: UIViewController,UICollectionViewDelegate,
UICollectionViewDataSource {
    
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var popularMoviesCollectionView: UICollectionView!
    @IBOutlet weak var upcomingMoviesCollectionView: UICollectionView!
    
    var listOfPopularMovies: [MovieEntity] = []
    var listOfUpcomingMovies: [MovieEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        loadData()        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        reloadCollectionViews()
    }
    
    func setUI() {
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBarView.setViewWithBorder()
    }
    
    // Load moives data from the TMDb
    func loadData() {
        webserviceManager().getMovies(page: 1, classfication: "popular") { (success, listOfMovie) in
            if success {
                self.listOfPopularMovies = listOfMovie!
                self.reloadCollectionViews()
            }
        }
        
        webserviceManager().getMovies(page: 1, classfication: "upcoming") { (success, listOfMovie) in
            if success {
                self.listOfUpcomingMovies = listOfMovie!
                self.reloadCollectionViews()
            }
        }
    }
    
    // Load moives poster
    func getMoviePoster(_ imagePath: String , completion: @escaping (_ image: UIImage) -> Void ) -> Void {
        webserviceManager().getMoviePoster(imagePath:imagePath) { (success, image) in
            if success {
                completion(image!)
            }
        }
    }
    
    // Reload the collection views when need
    func reloadCollectionViews() {
        popularMoviesCollectionView.reloadData()
        upcomingMoviesCollectionView.reloadData()
    }
    
    // Dismiss the keyboard when is the search has been clicked
    @objc func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
        
        
    }
    
    // Show 10 inital movies
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == popularMoviesCollectionView {
            return listOfPopularMovies.count > 0 ? 10 : 0
        } else {
            return listOfUpcomingMovies.count > 0 ? 10 : 0
        }
        
    }
    
    // Show collection of popular and upcoming movies
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == popularMoviesCollectionView {
            let entity = listOfPopularMovies[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularMoviesCell", for: indexPath) as! MovieCollectionViewCell
            cell.movie = entity
            getMoviePoster(entity.posterPath, completion: { (image) in
                cell.moviesPoster.image = image
                cell.moviesPosterData = image.pngData()
            })
            
            if UserPreferences().isMovieInWatchList(title: entity.title) {
                cell.watchListButton.setImage(#imageLiteral(resourceName: "pink_bookmark"), for: .normal)
            } else {
                cell.watchListButton.setImage(#imageLiteral(resourceName: "bookmark"), for: .normal)
            }
            
            if UserPreferences().isMovieInFavoriteList(title: entity.title) {
                cell.favoriteButton.setImage(#imageLiteral(resourceName: "pinkHearts"), for: .normal)
            } else {
                cell.favoriteButton.setImage(#imageLiteral(resourceName: "hearts"), for: .normal)
            }
            return cell
            
        } else {
            let entity = listOfUpcomingMovies[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upComingMoviesCell", for: indexPath) as! MovieCollectionViewCell
            cell.movie = entity
            getMoviePoster(entity.posterPath) { (image) in
                cell.moviesPoster.image = image
                cell.moviesPosterData = image.pngData()
            }
            
            if UserPreferences().isMovieInWatchList(title: entity.title) {
                cell.watchListButton.setImage(#imageLiteral(resourceName: "pink_bookmark"), for: .normal)
            } else {
                cell.watchListButton.setImage(#imageLiteral(resourceName: "bookmark"), for: .normal)
            }
            
            if UserPreferences().isMovieInFavoriteList(title: entity.title) {
                cell.favoriteButton.setImage(#imageLiteral(resourceName: "pinkHearts"), for: .normal)
            } else {
                cell.favoriteButton.setImage(#imageLiteral(resourceName: "hearts"), for: .normal)
            }
            
            return cell
        }
    }
    
    // Show more details for individual movie
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsVC") as! MovieDetailsVC
        if collectionView == popularMoviesCollectionView {
            vc.movieID = String(listOfPopularMovies[indexPath.row].id)
        } else {
            vc.movieID = String(listOfUpcomingMovies[indexPath.row].id)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // Show more movies for popular or upcoming
    @IBAction func showAllMovies(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverMoreVC") as! DiscoverMoreVC
        if sender.tag == 1  {
            vc.classfication = "popular"
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            vc.classfication = "upcoming"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // show the search VC to search for a specific movie
    @IBAction func searchForMovies(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchMoviesVC") as! SearchMoviesVC
        HelperClass().showPopUp(vc, parent: self)
    }
}

