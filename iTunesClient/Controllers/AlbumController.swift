//
//  AlbumController.swift
//  iTunesClient
//
//  Created by Milan Schon on 05/01/2019.
//  Copyright © 2019 Milan Schon. All rights reserved.
//

import UIKit

class AlbumController: UITableViewController {
    
    private struct Constants {
        static let AlbumCellHeight:CGFloat = 80
    }
    let client = ItunesAPIClient()
    var artist:Artist? {
        didSet {
            self.title = artist?.name
            dataSource.update(with: artist!.albums)
            tableView.reloadData()
        }
    }
    var dataSource:AlbumListDataSource = AlbumListDataSource(albums: [])
//    lazy var dataSource:AlbumListDataSource = {
//        return AlbumListDataSource(albums: [],tableView:self.tableView)
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        dataSource.setTableView(tableView)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.AlbumCellHeight
    }
    
    //MARK: prepar for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAlbum" {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                let selectedAlbum = dataSource.album(at: selectedIndexPath)
                let albumDetailController = segue.destination as! AlbumDetailController
                client.lookupAlbum(with: selectedAlbum.id){ album,error in
                    albumDetailController.album = album
                }
                albumDetailController.album = selectedAlbum
                
            }
        }
    }
}
