//
//  WatchListVC.swift
//  MovieTime
//
//  Created by Nouf Aldoaij on 18/06/2019.
//  Copyright © 2019 Nouf Abdullah. All rights reserved.
//

import UIKit
import CoreData
class WatchListVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UpdateWatchList {
    
    
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!

    var watchList: [WatchListEntity] = []
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noDataFound: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
        let fetchRequest:NSFetchRequest<WatchListEntity> = WatchListEntity.fetchRequest()
        do {
            watchList = try context.fetch(fetchRequest)
            tableView.reloadData()
        } catch {
            HelperClass().showAlert(title: nil, message: "Could Not Load Save Data!", self)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noDataFound.isHidden = watchList.count > 0 ? true : false
        return watchList.count > 0 ? watchList.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SavedMovieCell
        let entity = watchList[indexPath.row]
        cell.watchList = entity
        cell.WatchListDelegate = self
        cell.moviesPoster.image = UIImage(data: entity.moviePoster!)
        cell.movieTitle.text = entity.movieTitle
        cell.movieGenres.text = entity.movieReleaseDate
        return cell
    }
    
    // Show more details for individual movie
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        HelperClass().showAlert(title: nil, message: "This functionality currently unavailable", self)
    }
   
    // Update the watch list after a moive have been remove for the list 
    func updateWatchList() {
        loadData()
        tableView.reloadData()
    }
}
