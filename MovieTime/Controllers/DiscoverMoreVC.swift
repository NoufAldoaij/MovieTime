//
//  DiscoverMoreVC.swift
//  MovieTime
//
//  Created by Nouf Abdullah on 6/14/19.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import UIKit

class DiscoverMoreVC: UIViewController,UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var listOfMovies:[MovieEntity] = []
    var classfication:String = ""
    var pageNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadData()
    }
    
    func setUI() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Discover More"
    }
    
    // Load moives data from the TMDb
    func loadData() {
        webserviceManager().getMovies(page: pageNumber, classfication: classfication) { (success, listOfMovie) in
            if success {
                for movies in listOfMovie! {
                    self.listOfMovies.append(movies)
                }
                self.tableView.reloadData()
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfMovies.count > 0 ? listOfMovies.count : 0
    }
    
    // Show collection of popular and upcoming movies
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableCell
        let entity = listOfMovies[indexPath.row]
        cell.movie = entity
        cell.movieTitle.text = entity.title
        cell.moviesReleaseDate.text = entity.releaseDate
        cell.voteAverage.text = "\(entity.voteAverage)"
        getMoviePoster(entity.backdropPath) { (image) in
            cell.moviePoster.image = image
            cell.moviesPosterData = image.pngData()
        }
        if  UserPreferences().isMovieInFavoriteList(title: entity.title) {
            cell.favoriteButton.setImage(#imageLiteral(resourceName: "pinkHearts"), for: .normal)
        } else {
            cell.favoriteButton.setImage(#imageLiteral(resourceName: "hearts"), for: .normal)
        }
        
        if UserPreferences().isMovieInWatchList(title: entity.title) {
            cell.watchListButton.setImage(#imageLiteral(resourceName: "pink_bookmark"), for: .normal)
        } else {
            cell.watchListButton.setImage(#imageLiteral(resourceName: "bookmark"), for: .normal)
        }
        
        return cell
    }
    
    // Load more movies when reaching the end of the list
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == listOfMovies.count {
            pageNumber += 1
            loadData()
        }
    }
    
    // Show more details for individual movie
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsVC") as! MovieDetailsVC
        vc.movieID = String(listOfMovies[indexPath.row].id)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
