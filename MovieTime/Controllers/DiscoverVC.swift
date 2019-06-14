//
//  DiscoverVC.swift
//  MovieTime
//
//  Created by Nouf Abdullah on 6/8/19.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import UIKit
import Speech
class DiscoverVC: UIViewController,UICollectionViewDelegate,
UICollectionViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var popularMoviesCollectionView: UICollectionView!
    @IBOutlet weak var upComingMoviesCollectionView: UICollectionView!

    var listOfMovies: [DummyData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        listOfMovies = StaticDataHelper().getAllMovies()
    }
    
    func setUI() {
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBarView.setViewWithBorder()
    }
    
    @objc func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == popularMoviesCollectionView {
            return listOfMovies.count > 0 ? listOfMovies.count:  0
            
        } else {
            return listOfMovies.count > 0 ? listOfMovies.count:  0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == popularMoviesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularMoviesCell", for: indexPath) as! MovieCell
            cell.movie = listOfMovies[indexPath.row]
            cell.moviesPoster.image = listOfMovies[indexPath.row].moviePoster
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upComingMoviesCell", for: indexPath) as! MovieCell
            cell.movie = listOfMovies[indexPath.row]
            cell.moviesPoster.image = listOfMovies[indexPath.row].moviePoster
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        HelperClass().showAlert(title: nil, message: "This functionality currently unavailable", self)
    }
    
    
    @IBAction func showAllMovies(_ sender: Any) {
        HelperClass().showAlert(title: nil, message: "This functionality currently unavailable", self)
    }
    
    @IBAction func showSearchView(_ sender: UIButton) {
        HelperClass().showAlert(title: nil, message: "This functionality currently unavailable", self)
    }
    
    @IBAction func searchForMovies(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchMoviesVC") as! SearchMoviesVC
        HelperClass().showPopUp(vc, parent: self)
    }
}

