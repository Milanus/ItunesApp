//
//  AlbumCellViewModel.swift
//  iTunesClient
//
//  Created by Milan Schon on 05/01/2019.
//  Copyright © 2019 Milan Schon. All rights reserved.
//

import Foundation
import UIKit

struct AlbumCellViewModel {
    let artworkImage:UIImage
    let title:String
    let releaseDate:String
    let genre:String
}
extension AlbumCellViewModel {
  
    init(album:Album) {
        self.artworkImage = album.aertworkState == .downloaded ? album.artwork! : #imageLiteral(resourceName: "AlbumPlaceholder")
        self.title = album.censoredName
        self.genre = album.primaryGenre.name
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MMM dd, yyyy"
        self.releaseDate = formatter.string(from: album.releaseDate)
    }
}
