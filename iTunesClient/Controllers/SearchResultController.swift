//
//  SearchResultController.swift
//  iTunesClient
//
//  Created by Milan Schon on 05/01/2019.
//  Copyright © 2019 Milan Schon. All rights reserved.
//

import UIKit

class SearchResultController: UITableViewController {
   
    let searchController = UISearchController(searchResultsController: nil)
    let dataSource = SearcheResultDataSource()
    let client = ItunesAPIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(SearchResultController.dismissSearchresultController))
        tableView.tableHeaderView = searchController.searchBar
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        tableView.dataSource = dataSource
        definesPresentationContext = true
    }
    @objc func dismissSearchresultController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAlbums" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let artist = dataSource.artist(at: indexPath)
                let albumListController = segue.destination as! AlbumController
                albumListController.artist = artist
                client.lookupArtist(with: artist.id) {artist,error in
                    albumListController.artist = artist
                    albumListController.tableView.reloadData()
                }
            }
        }
    }
}

extension SearchResultController :UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        client.searchForArtist(with: searchController.searchBar.text!) { [weak self] artists,error in
            guard  error == nil else {
                print("error \(String(describing: error))")
                return
            }
           self?.dataSource.update(with: artists)
            self?.tableView.reloadData()
            
        }
    }
}
