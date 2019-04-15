//
//  AlbumDetailController.swift
//  iTunesClient
//
//  Created by Milan Schon on 05/01/2019.
//  Copyright © 2019 Milan Schon. All rights reserved.
//

import UIKit

class AlbumDetailController: UITableViewController {
    
    var album:Album? {
        didSet {
            if let album = album {
//                configure(with: album)
                dataSource.update(with:album.songs)
                tableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var artworkImageView: UIImageView!
   
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var albumGenre: UILabel!
    
    @IBOutlet weak var albumDate: UILabel!
    
    
    var dataSource:AlbumDetailDataSource = AlbumDetailDataSource(songs: [])
    override func viewDidLoad() {
        super.viewDidLoad()
        if let album = album {
            configure(with: album)
        }
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
    
    func configure(with album:Album) {
        let viewModel = AlbumDetailViewModel(album: album)
        // ADD implementtion for artwork
        albumTitle.text = viewModel.title
        albumGenre.text = viewModel.genre
        albumDate.text = viewModel.releaseDate
    }
}
