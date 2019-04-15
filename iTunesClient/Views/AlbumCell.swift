//
//  AlbumCell.swift
//  iTunesClient
//
//  Created by Milan Schon on 05/01/2019.
//  Copyright © 2019 Milan Schon. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {
    
    static let reusedIdentifier = "AlbumCell"

    @IBOutlet weak var artworkView: UIImageView!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension AlbumCell {
    func configure(with viewModel:AlbumCellViewModel) {
        artworkView.image = viewModel.artworkImage
        albumLabel.text = viewModel.title
        genreLabel.text = viewModel.genre
        releaseLabel.text = viewModel.releaseDate
    }
}
