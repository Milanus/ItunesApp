//
//  AlbumListDataSource.swift
//  iTunesClient
//
//  Created by Milan Schon on 05/01/2019.
//  Copyright © 2019 Milan Schon. All rights reserved.
//

import UIKit

class AlbumListDataSource: NSObject,UITableViewDataSource {
   
    
    private var albums:[Album]
    
    let pendingOperations = PendingOperations()
    var tableView:UITableView?
    init(albums:[Album]) {
        self.albums = albums
        super.init()
    }
    
    //MARK: Data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let albumCell = tableView.dequeueReusableCell(withIdentifier: AlbumCell.reusedIdentifier, for: indexPath) as! AlbumCell
        let album = albums[indexPath.row]
        let viewModel = AlbumCellViewModel(album: album)
        albumCell.configure(with: viewModel)
        albumCell.accessoryType = .disclosureIndicator
        
        if album.aertworkState == .placeholder {
            downloadArtworkForAlbum(album, atIndexPath: indexPath)
        }
        return albumCell
    }
    
    // MARK: - HELPER
    
    func album(at indexPath:IndexPath) ->Album {
        return albums[indexPath.row]
    }
    
    func update(with albums:[Album]) {
        self.albums = albums
    }
    func setTableView(_ tableView:UITableView)   {
        self.tableView = tableView
    }
    func downloadArtworkForAlbum(_ album:Album, atIndexPath indexPath:IndexPath) {
        if let _ = pendingOperations.downloadsInProgress[indexPath] {
            return
        }
        let downLoader = ArtworkDownloader(album: album)
        downLoader.completionBlock = {
            if downLoader.isCancelled {
                return
            }
            DispatchQueue.main.async {
                self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
                if let tableView = self.tableView {
                    tableView.reloadRows(at: [indexPath], with: .automatic)

                }
            }
        }
        pendingOperations.downloadsInProgress[indexPath] = downLoader
        pendingOperations.downloadQueue.addOperation(downLoader)
    }
}
