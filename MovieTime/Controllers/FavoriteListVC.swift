//
//  FavoriteListVC.swift
//  MovieTime
//
//  Created by Nouf Aldoaij on 18/06/2019.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import UIKit
import CoreData

class FavoriteListVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UpdateFavoriteList {
    

    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noDataFound: UILabel!
    
    var favoriteList: [FavoriteListEntity] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        loadData()
    }
    
    func setUI() {
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBarView.setViewWithBorder()
        noDataFound.isHidden = true
    }
    
    // Load saved moives for DB
    func loadData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<FavoriteListEntity> = FavoriteListEntity.fetchRequest()
        do {
            favoriteList = try  context.fetch(fetchRequest)
            tableView.reloadData()
        } catch {
            HelperClass().showAlert(title: nil, message: "Could Not Load Save Data!", self)
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
        return cell
    }
    
    // Show more details for individual movie
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        HelperClass().showAlert(title: nil, message: "This functionality currently unavailable", self)
    }
    
    // Update the favorite list after a moive have been remove for the list
    func updateFavoriteList() {
        loadData()
        tableView.reloadData()
    }
    
}
